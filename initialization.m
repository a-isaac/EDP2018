function [] = initialization()

%%Inputs
r = 6.4*10^-2;
c = ((15.46-10.89)/2+10.89)*10^-2;
b = 0*10^-2;
a = 0*10^-2;
l = b - a ;
T_Tot = 300;
T = 0.1;

    %Initializations:
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
    global testpk
    global X_MPC
    global U_MPC
    
    X_MPC = zeros(3,5);
    U_MPC = zeros(2,5);

testpk = 0;

    W(1) = 0;
    Vx(1) = 0;
    Theta(1) = 0;
    WL(1) = 0;
    WR(1) = 0;
    n = T_Tot/T;
    X = [0 0 0];
    Y = [0 0 0];
    Acc_X(1) = 0;
    Acc_Y(1) = 0;
    Gyro_Z(1) = 0;
    X_dot_S(1) = 0;
    Y_dot_S(1) = 0;
    %X_Est(pk,:) = [0 0 0];
    P = eye(3);
    G = eye(3);
    %Circle
    Path = [[cos(0:(2*pi/420):(2*pi))]'+1, [sin(0:(2*pi/420):(2*pi))]'];
    Path = Path(1:(end-1),:);
end 