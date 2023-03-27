% Function for 2 Users
% Plots graph for the load values of each user and shows efficiency and fairness line
function[Fairness, Responsiveness, Smoothness, X1, X2, T] = AIMD2Users(AdditiveIncreaseConstant, MultiplicativeDecreaseConstant, User1StartValue, User2StartValue, Iterations, DataCap)

a = AdditiveIncreaseConstant;
b = MultiplicativeDecreaseConstant;
x1 = User1StartValue;
x2 = User2StartValue;
n = Iterations;
c = DataCap;
Xgoal = x1+x2;
eff = 0:c;
EFF = c:-1:0;
fair = 0:c;
FAIR = 0:c;

%% INITIAL PARAMETERS
Responsiveness = (log(((a*2)+(b-1)*Xgoal)/((a*2)+(b-1)*Xgoal)))/log(b);
Smoothness = abs((a*2)+((b-1)*Xgoal));

%% MAIN

for i = 2:n
    y(i) = x1(end) + x2(end);
    if y(end) <= Xgoal
        x1(i) = a + x1(end);
        x2(i) = a + x2(end);
    else y(end) > Xgoal;
    x1(i) = b * x1(end);
    x2(i) = b * x2(end);
    end
end

y(end+1) = x1(end) + x2(end);
TotalLoad = y(2:end);

%% PLOT
X1 = x1';
X2 = x2';
T = TotalLoad';
xx = 0:0.1:n;
YY2 = [0 TotalLoad];
xx1 = [0 x1];
xx2 = [0 x2];
g = pchip(0:n,YY2,xx);
yy = pchip(0:n,xx1,xx);
yy2 = pchip(0:n,xx2,xx);
subplot(2,2,1)
plot(x1,x2,'-o',eff,EFF,fair,FAIR,'--')
title ('AIMD')
xlabel ('USER 1')
ylabel ('USER 2','Rotation',0,'VerticalAlignment','middle','HorizontalAlignment','right')
axis square
grid on
grid minor
legend('AIMD','EFF.','FAIR.')
subplot(2,2,2)
plot(1:n,TotalLoad,'o',xx,g)
title ('Total Load')
xlabel ('Time')
ylabel ('Load','Rotation',0,'VerticalAlignment','middle','HorizontalAlignment','right')
grid on
grid minor
subplot(2,2,3)
plot(1:n,x1,'o',xx,yy)
title('User 1')
xlabel('Time')
ylabel('Load','Rotation',0,'VerticalAlignment','middle','HorizontalAlignment','right')
grid on
grid minor
subplot(2,2,4)
plot(1:n,x2,'o',xx,yy2)
title('User 2')
xlabel('Time')
ylabel('Load','Rotation',0,'VerticalAlignment','middle','HorizontalAlignment','right')
grid on
grid minor

%% CALCULATED PARAMETERS
Fairness = (sum(x1)+sum(x2))^2/(2*((sum(x1))^2+(sum(x2))^2));