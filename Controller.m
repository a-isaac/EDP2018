function [X,U] =Controller(X0,Ref,X,U) 

% Inputs
% X0 = 3x1
% Ref = 2x6
% X  = 3x5
% U  = 2x5

% Outputs
% X  = 3x5
% U  = 2x5


ts=0.2;     % sampling time
TH=6;       % final horizon + 1

% Enter the data points for tracking.
Xref=Ref(1,:);
Yref=Ref(2,:);
%Qref=Ref(3,:);

% Vehicle Current position and predicted position
if exist('U','var')
else
    U=zeros(2,TH);
end
X0=X(:,1);
if exist('X','var')
    %X(:,1)=X0(:);
    X(:,TH)=X(:,TH-1)+[rand rand rand]';
else
    X=zeros(3,TH);
end

%% define Vehicle Characteristics
r       = 0.064;       
c       = ((15.46-10.89)/2+10.89)*10^-2;

%%% Bounds on States
xL    = -200;               xU = 200;
yL    = -200;               yU = 200;
TL    = -5*pi;               TU = 5*pi;

%%% Bounds on Controls
OM_L_L= 0;      OM_L_U= 18;
OM_R_L= 0;      OM_R_U= 18;

%% define problem variables

xmin=[xL  yL  TL];
xmax=[xU  yU  TU];
umin=[OM_L_L  OM_R_L];
umax=[OM_L_U  OM_R_U];

Xmin=xmin;
Umin=umin;
Xmax=xmax;
Umax=umax;
for J=1:TH-2
    Xmin=[Xmin xmin];
    Umin=[Umin umin];
    Xmax=[Xmax xmax];
    Umax=[Umax umax];
end
Xmin=[Xmin Umin];
Xmax=[Xmax Umax];

%%%%%%%%% create equality constraint 

for i=1:TH-1
Ac=[ 0   0   -sin(X(3,i))*(r/2)*(U(1,i)+U(2,i))
     0   0    cos(X(3,i))*(r/2)*(U(1,i)+U(2,i))
     0   0      0];

Ac=Ac+eye(3)*1e-7;
 
Bc=[(r/2)*cos(X(3,i)) (r/2)*cos(X(3,i))
    (r/2)*sin(X(3,i)) (r/2)*sin(X(3,i))
   -(r/c)             (r/c)];

gc=[cos(X(3,i))*(r/2)*(U(1,i)+U(2,i))  sin(X(3,i))*(r/2)*(U(1,i)+U(2,i)) (r/c)*(-U(1,i)+U(2,i))]' -Ac*X(:,i)-Bc*U(:,i);

A=expm([Ac*ts Bc*ts gc*ts
        zeros(3,6)] );
    
Ad{i}=blkdiag(A(1:3,1:3));
Bd{i}=blkdiag(A(1:3,4:5));
gd{i}=[A(1:3,6)];
end

Add=Ad{2};
Bdd=Bd{1};
for J=2:TH-2
    Add=blkdiag(Add,Ad{J+1});
    Bdd=blkdiag(Bdd,Bd{J});
end
Bdd=blkdiag(Bdd,Bd{(TH-1)});

A3=zeros(3*(TH-1));
A3(4:end,1:((TH-2)*3))=-Add;
A3=A3+eye(3*(TH-1));
A2=-Bdd;
Aeq=[A3 A2];

beq=Ad{1}*X(:,1)+gd{1};
for J=2:TH-1
    beq=[beq;gd{J}];
end
      
% Set the solver options for NMPC

Hes=cell(1,(TH-1));
Gra=cell(1,(TH-1));
col=1;

%% Iteration starts

for i=1:TH-1
    f=@(x) (0.5*(x(1)-Xref(col))^2 + 0.5*(x(2)-Yref(col))^2);
    col=col+1;
    [H,gr,z1t]=hessiancsd(f,X(:,i));
    Hes{i}=H;
    Gra{i}=gr';
end
Hess1=Hes{1};
Grad1=Gra{1}';
for J=2:TH-1
    Hess1=blkdiag(Hess1,Hes{J});
    Grad1=[Grad1;Gra{J}'];
end

for i=1:TH-1
    f=@(x) (0)^2 + (0)^2;  %% venki look here for minimum speed line 133
    [H,gr,z1t]=hessiancsd(f,U(:,i));
    Hess1=blkdiag(Hess1,H);
    Grad1=[Grad1;gr];
end

% % Hess=blkdiag(Hess1,zeros((TH-1)*2));
% % Grad=[Grad1;zeros((TH-1)*2,1)];
Hess=Hess1;
Grad=Grad1;

Aineq=[];
bineq=[];
X0L=[reshape(X(1:3,1:5),1,15) reshape(U(1:2,1:5),1,10)];
xout = quadprog(Hess,Grad,Aineq,bineq,Aeq,beq,Xmin',Xmax',X0L);

counta=0;
 for i = 1:TH-1
 Xn(:,i)=xout(1+3*counta:3+3*counta);
 Un(:,i)=xout(3*(TH-1)+1+2*counta:((3*(TH-1)+2)+2*counta));
 counta=counta+1;
 end
 for II=1:TH-1
 X(:,II)=Ad{II}*X0(:) + Bd{II}*Un(:,II) + gd{II};
 X0=X(:,II);
 end
 U=[Un [0 0]' [0 0]'];

function [A,g,z] = hessiancsd(fun,x)

if nargout>2
    z=fun(x);                       % function value
end
n=numel(x);                         % size of independent
A=zeros(n);                         % allocate memory for the Hessian matrix
g=zeros(n,1);                       % allocate memory for the gradient matrix
h=sqrt(2.226^(-10));                        % differentiation step size
h2=h*h;                             % square of step size
for k=1:n                           % loop for each independent variable 
    x1=x;                           % reference point
    x1(k)=x1(k)+h*i;                % increment in kth independent variable
    if nargout>1
        v=fun(x1);                  % function call with a comlex step increment
        g(k)=imag(v)/h;             % the kth gradient
    end
    for l=k:n                       % loop for off diagonal Hessian
        x2=x1;                      % reference with kth increment
        x2(l)=x2(l)+h;              % kth + lth (positive real) increment
        u1=fun(x2);                 % function call with a double increment
        x2(l)=x1(l)-h;              % kth + lth (negative real) increment
        u2=fun(x2);                 % function call with a double increment
        A(k,l)=imag(u1-u2)/h2/2;    % Hessian (central + complex step)
        A(l,k)=A(k,l);              % symmetric
    end
end
