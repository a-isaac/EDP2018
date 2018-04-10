function[] = model(testpk)
%display('stage0')
%% 
%r = radius of the wheel in m
%c = half of wheel base width in m
%b = length of front axle to the CG in m
%a = length of rear axle to CG in m
%l = vector fronm C.G to Geometric Centre in m
%T = time step in s
%T_tot = total sim time in s
%W = yaw angular velocity of robot in rad/s
%Vx = linear velocity of the robot in m/s
%X = X position of robot in m
%Y = Y postion of robot in m
%Theta = yaw angular postion of the robot in rad
%Acc_X = Linear acceleration in vehicles x direction
%Acc_Y = Linear acceleration in vehicles y direction
%Gyro_Z = Yaw velocity

%Sensor Measurements
%X_dot_S(pk) = Vehicle X Velocity
%X_S(pk) = Vehicle X Velocity
%Y_dot_S(pk) = Y_dot_F(pk-1) +  T * Acc_Y(pk);
%Y_S(pk) = Y_S_F(pk-1) + T * Y_dot_S(pk);
%Theta_S(pk)


%%Inputs
r = 6.4*10^-2;
c = ((15.46-10.89)/2+10.89)*10^-2;
b = 0*10^-2;
a = 0*10^-2;
l = b - a ;
T_Tot = 300;
T = 0.150;


global W
global Vx
global Theta
global WL
global WR
global n
global X
global Y
global Acc_X
global Acc_Y 
global Gyro_Z 
global X_dot_S
global Y_dot_S 
global X_Est
global P
global G
global Path  
global matrix
global X_MPC
global U_MPC
X_Est(testpk,:) = [0 0 0];

   %% Discrete State Space Non Linear Model

    W(testpk) = r/2/c*(-WL(testpk-1)+WR(testpk-1));
    Vx(testpk) = r/2*(WL(testpk-1)+WR(testpk-1));
    
    X(testpk,:) = [ X(testpk-1,1) + Vx(testpk)*T*cos(X(testpk-1,3)),X(testpk-1,2) + Vx(testpk)*T*sin(X(testpk-1,3)),X(testpk-1,3) + W(testpk)*T];
    
    %% Sensor readings
    
    %         TELEMETRY
    %         ---------------
    %         1 - Packet
    %         2 - Time 
    %         3 - Accel X
    %         4 - Accel Y
    %         5 - Accel Z
    %         6 - Gyro X
    %         7 - Gyro Y
    %         8 - Gyro Z
    

    %% Sensor and Output model
    Acc_X(testpk) = matrix.data(testpk,3);
    Acc_Y(testpk) = matrix.data(testpk,5);
    Gyro_Z(testpk) = -matrix.data(testpk,7);
    
    X_dot_S(testpk) = X_dot_S(testpk-1) + T * Acc_X(testpk);
    Y_dot_S(testpk) = Y_dot_S(testpk-1) + T * Acc_Y(testpk);
    
    Y(testpk,:) = [ Y(testpk-1,1)+T*X_dot_S(testpk)  Y(testpk-1,2)+T*Y_dot_S(testpk)  Y(testpk-1,3)+T*Gyro_Z(testpk)]
  
    %% EK Filter  

    %Predict 
    F = [0 0 -sin(X(testpk-1,3))*Vx(testpk);
         0 0  cos(X(testpk-1,3))*Vx(testpk);
         0 0   0               ];
    H = eye(3);
    
    X_Est(testpk,:) = [X_Est(testpk-1,1) + Vx(testpk)*T*cos(X_Est(testpk-1,3)), X_Est(testpk-1,2) + Vx(testpk)*T*cos(X_Est(testpk-1,3)), X_Est(testpk-1,3)+W(testpk)*T];
    P = F*P*F' + diag([0.00273258^2, 0.00377865^2, 0.04915648^2]);
    
    %Update
    G =  P*H'*inv(H*P*H')+ diag([0.01^2, 0.011^2, 0.009^2]);
    X_Est(testpk,:) =  X_Est(testpk,:)+[G*(Y(testpk,:)'-X_Est(testpk,:)')]';
    P = [eye(3)-G*H]*P;
    
    X_Est(testpk,:);
    %% Control System

    %Finding the next path based on current position estimate
    Error = abs((Path(:,1)-X_Est(testpk,1)))+abs((Path(:,1)-X_Est(testpk,2)));
    min_id = find(Error==min(Error));
    if(length(Error) - min_id > 5)
        Ref = Path((min_id+1):(min_id+6),:); 

    else 
        extra_id = length(Error) - min_id;
        Ref = Path([(min_id+1):(min_id+extra_id),1:(6-extra_id)],:);

    end
    
    %MPC Control
%     X_Est(testpk,:)'
%     Ref
%     X_MPC
%     U_MPC
     [X_MPC,U_MPC] = Controller(X_Est(testpk,:)',Ref',X_MPC,U_MPC);
    
    WL(testpk) = U_MPC(1,1)*9.5493;
    WR(testpk) = U_MPC(2,1)*9.5493;
%       WL(testpk) = 100;
%      WR(testpk) = 100;
    
    % motor control

    Left = roots([2.181e-05 -0.01309 2.756 -3.118-WL(testpk)]);
    Right = roots([2.181e-05 -0.01309 2.756 -3.118-WR(testpk)]);
    
    C_FL = Left(imag(Left)==0)+15;
    C_RL = C_FL;
    
    C_FR = Right(imag(Right)==0)+15;
    C_RR = C_FR;
    
    I = num2str(round(C_FL));
    II = num2str(round(C_FR));
    III = num2str(round(C_RL));
    IV = num2str(round(C_RR));
        
    %% To Arduino     
    global ard;
    fwrite(ard,strcat('<',I,',',II,',',III,',',IV,'>'));  
    display(strcat(I,',',II,',',III,',',IV));  
    %fwrite(ard, 'test');
end

