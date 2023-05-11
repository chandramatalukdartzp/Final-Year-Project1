clear;
clc;
% data=readtable('iris.csv');
% x=data.Var1' ;
x=[4, 6, 7, 5, 8]; %maths marks
y=[3, 7, 8, 5, 8]; %electonics marks
c=[0,1,1,0,1] %result 1 means pass 0 means fail
distance=[];
clas=[];
k=3;
a=6;  %test maths marks 
b=8;   %test electronics marks
for i=1:length(x)
    e=sqrt((x(i)-a)^2 + (y(i) - b)^2); %euclidian distance of the test point to every point in the dataset
    distance=[distance e]; %array of distances 
end
temp=0;
gemp=0;
for j=1:length(distance)
    for p=1:(length(distance)-j)
        if(distance(p)>distance(p+1))
            temp=distance(p);
            distance(p)=distance(p+1);
            distance(p+1)=temp;
            gemp=c(p);
            c(p)=c(p+1);
            c(p+1)=gemp;
        end
    end
end
classy=[];
for i=1:3
    clas=[clas c(i)];
end
output=mode(clas);
disp(output);