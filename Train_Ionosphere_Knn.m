clear;
clc;
addpath('E:\Sparse\Ionosphere_dataset');
load iono;
load iono_gt;
Data=ionosphere1;
Data=table2array(Data);
GT=ionosphere;
GT=table2array(GT);
Data(:,2)=[];
GT1=[];
for i=1:351
    if GT(i)=='g'
        GT1(i)=1;
    else 
        GT1(i)=2;
    end
end


for z=1:5
    Testing_data = Data;
    testing_class = GT1';
    All_Class = GT1;
    class=2;
    index = cell([class,1]); % reserving 3 x 1 cells 
    Train = cell([class,1]); % reserving 3 x 1 cells
    training_data = [];
    training_class =[];
    Tr_S=[23,13];
    for i=1:class
        disp(i)
        row = find(testing_class==i);
        index{i} = row;
        p = randperm(size(index{i},1),Tr_S(i));
        for j=1:1:size(p,2)
            for k=1:33
            Train{i}{j,k}= [ Testing_data(index{i}(p(j)),k)];
            end
            testing_class(index{i}(p(j),1)) = 0;
        end
        %SM = [SM reshape(Train{i},[size(Train{i},1)* size(Train{i},2), size(Train{i},3)])'];
        training_class = [training_class ones(1,Tr_S(i)) * i];
    end
    training_data=[Train{1,1}' ,Train{2,1}'];
    training_data=cell2mat(training_data)';
    training_data = training_data ./ vecnorm(training_data,2);
%     matfile1 = sprintf('E://Sparse//Iris_dataset//Training_Data%d',z);
%     matfile2 =sprintf('E://Sparse//Iris_dataset//Testing_Class%d',z);
%     matfile3 =sprintf('E://Sparse//Iris_dataset//Training_Class%d',z);
%     matfile4 =sprintf('E://Sparse//Iris_dataset//Testing_data%d',z);
%     
%     save(matfile1, 'SM') %Our Dictionary
%     save(matfile2, 'T_Class') %Testing Class. It is our ground truth.
%     save(matfile3, 'Tr_Class') %Training Class. Tr_class is an array that contains all the selected pixels in 
%     %SM holding the class value
%     save(matfile4, 'Testing_data') %Testing_Data is the Data set
% 
% %   save('E://Sparse//Iris_dataset//All_data.mat', 'All_data'); %The Data set
% %   save('E://Sparse//Iris_dataset//All_Class.mat', 'All_Class'); %The Ground Truth
     matfile1 = sprintf('E://KNN//IONOSPHERE//Training_Data%d',z);
     matfile2 =sprintf('E://KNN//IONOSPHERE//Training_Class%d',z);
     matfile3 =sprintf('E://KNN//IONOSPHERE//Testing_Class%d',z);
     matfile4 =sprintf('E://KNN//IONOSPHERE//Testing_data%d',z);
   
     save(matfile1, 'training_data') %training_data
     save(matfile2, 'training_class') %Training Class. Tr_class is an array that contains all the selected pixels in 
    %SM holding the class value
    
    save(matfile3, 'testing_class') %Testing Class. It is our ground truth.
    save(matfile4, 'Testing_data') %Testing_Data is the Data set


end
disp("Finished");