clear;
clc;
clear;
clc;
addpath('E:\Sparse\Iris_dataset');
load Iris_data;
load Iris_GT;
Data=IRIS;
c1=GT;

k=3;
for z=1:5
    distance=[];
    clas=[];
    matfile1 = sprintf('E://KNN//IRIS//Training_Data%d',z);
    matfile2 =sprintf('E://KNN//IRIS//Training_Class%d',z);
    matfile3 =sprintf('E://KNN//IRIS//Testing_Class%d',z);
    matfile4 =sprintf('E://KNN//IRIS////testing_data%d',z);
    
    load (matfile1); %Training_Data
    load (matfile2); %Training_Class
    load (matfile3); %Testing_Class
    load (matfile4) %testing_data
    
    for j=1:size(testing_data,1)
        distance=[];
        a=testing_data(j,1);
        b=testing_data(j,2);
        c=testing_data(j,3);
        d=testing_data(j,4);
        % a=5.25;
        % b=3.45;
        % c=1.72;
        % d=0.75;
        
        for i=1:size(training_data,1)
            e = sqrt(sum((testing_data(j,:)'-training_data(i,:)').^2));
            distance=[distance e]; %array of distances
        end
%         for i=1:size(training_data,2)
%                 e=sqrt((training_data(1,i)-a)^2 + (training_data(2,i) - b)^2  + (training_data(3,i) - c)^2 +(training_data(4,i) -d)^2); %euclidian distance of the test point to every point in the dataset
%                 distance=[distance e]; %array of distances 
%         end
        
        D = [distance' training_data training_class'];
        D_sort = sortrows(D,1);
        
        label = mode(D_sort(1:k,6));
        
        clas=[clas label];
    end
end



