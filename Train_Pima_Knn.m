clear;
clc;
addpath('E:\Sparse\Pima_dataset');
load Pima_data;
Data=rawdata;
Data=table2array(Data);

load GT;
GT=diabetes;
GT=table2array(GT);
for p=1:size(GT,1)
    if GT(p)==1
        GT(p)=2;
    else
        GT(p)=1;
    end
end

 for z=1:5
    Testing_data=Data;
    testing_class=GT;
    class=max(GT);
    index = cell([class,1]); % reserving 3 x 1 cells 
    Train = cell([class,1]); % reserving 3 x 1 cells
%     training_data = [];
    training_class =[];
    Tr_S=[50,27];
    for i=1:class
        disp(i)
        row = find(testing_class==i);
        index{i} = row;
        p = randperm(size(index{i},1),Tr_S(i));
        for j=1:1:size(p,2)
            for k=1:8
            Train{i}{j,k}= [ Testing_data(index{i}(p(j)),k)];
            end
            testing_class(index{i}(p(j),1)) = 0;
        end
        %SM = [SM reshape(Train{i},[size(Train{i},1)* size(Train{i},2), size(Train{i},3)])'];
        training_class = [training_class ones(1,Tr_S(i)) * i];
    end
    training_data=[Train{1,1}' ,Train{2,1}'];
    training_data=cell2mat(training_data)';
%      training_data = training_data ./ vecnorm(training_data,2);
    matfile1 = sprintf('E://KNN//PIMA//Training_Data%d',z);
     matfile2 =sprintf('E://KNN//PIMA//Training_Class%d',z);
     matfile3 =sprintf('E://KNN//PIMA//Testing_Class%d',z);
     matfile4 =sprintf('E://KNN//PIMA//Testing_data%d',z);
   
     save(matfile1, 'training_data') %training_data
     save(matfile2, 'training_class') %Training Class. Tr_class is an array that contains all the selected pixels in 
    %SM holding the class value
    
    save(matfile3, 'testing_class') %Testing Class. It is our ground truth.
    save(matfile4, 'Testing_data') %Testing_Data is the Data set

end
disp("Finished");