clear;
clc;
data=readtable('iris.csv');
% data=table2array(data);

Petal_length=data.Var1;
Petal_width=data.Var2 ;
Sepal_length=data.Var3;
Sepal_width=data.Var4;

c=data.Var5;
c=categorical(c);
c1=[];


for g=1:150
    if c(g)=='Iris-setosa'
        c1(g)=1;
    else if c(g)=='Iris-versicolor'
            c1(g)=2;
        else
            c1(g)=3;
        end
    end
end
c1=c1';
testing_class=c1;
class=testing_class;
    

testing_data=[ Petal_length,Petal_width, Sepal_length, Sepal_width];
for z=1:5
    
    
    training_class=[];
    tr=[5,5,5];
    index=cell(max(testing_class),1);
    train=cell(max(testing_class),1);
    for i=1:max(testing_class)
        index{i}=find(class==i);
        p=randperm(size(index{i},1),tr(i));
        for j=1:size(p,2)
            
            for k=1:4
                train{i}{j,k}= [testing_data(index{i}(p(j)),k)];
            end
            testing_class(index{i}(p(j),1)) = 0;
            % Train{i} = [Train{i} Testing_data(index{i}(p(j),1),index{i}(p(j),2),)];
        end
        training_data =[ train{1,1}' ,train{2,1}' ,train{3,1}' ];
        training_class = [training_class ones(1,tr(i)) * i];
        
    end
   training_data = cell2mat(training_data)';
   matfile1 = sprintf('E://KNN//IRIS//Training_Data%d',z);
   matfile2 =sprintf('E://KNN//IRIS//Training_Class%d',z);
   matfile3 =sprintf('E://KNN//IRIS//Testing_Class%d',z);
   matfile4 =sprintf('E://KNN//IRIS//Testing_data%d',z);
   
    save(matfile1, 'training_data') %training_data
    save(matfile2, 'training_class') %Training Class. Tr_class is an array that contains all the selected pixels in 
    %SM holding the class value
    
    save(matfile3, 'testing_class') %Testing Class. It is our ground truth.
    save(matfile4, 'testing_data') %Testing_Data is the Data set

end
