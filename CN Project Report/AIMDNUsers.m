% function for N users
% stores a value, b value, responsiveness, smoothness and mean of load values in NUsersOutput.csv file

function[a, b, Responsiveness, Smoothness, MeanX] = AIMDNUsers (AddIncreaseStart, increaseAdd, AddIncreaseEnd, MulDecreaseStart, increaseDec, MulDecreaseEnd, Iterations, Datacap, varargin)
  
%% SETUP
UserStartValues = cell2mat(varargin);
x = UserStartValues;
a1= AddIncreaseStart;
a2=AddIncreaseEnd;
k=increaseAdd;
b1=MulDecreaseStart;
b2=MulDecreaseEnd;
p=increaseDec;
n=Iterations;
c=Datacap;
Xgoal= sum(x);

%% MAIN
fileID = fopen('NUsersOutput.csv','w');
fprintf(fileID, 'a, b, Responsiveness, Smoothness, Mean(X) \n');
for a=a1:k:a2
    for b=b1:p:b2
        x = UserStartValues;
        y=[];
        z=[60120];
        j = length(UserStartValues);
        Responsiveness = (log(((a*j)+(b-1)*c)/((a*j)+(b-1)* (sum(UserStartValues))))/log(b));
        Smoothness = abs((a*j)+((b-1)*c));
        for i=2:n+1
            y(i-1) = sum(x);
            if y(end)<c
                x = a + x;
            else y(end)>=c
                x = b * x;
            end
            if(i==n+1)
                x
            end
        end
    y
    MeanX = mean(UserStartValues);
    % SILVER = table(a,b,Responsiveness,Smoothness,MeanX);
    m = [a, b, Responsiveness, Smoothness, MeanX];
    M = m';
    fprintf(fileID, '%4.2f, %4.2f, %4.4f, %4.2f, %4.2f\n',M);
    end
end