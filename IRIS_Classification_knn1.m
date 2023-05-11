clear all;
clc;

addpath('E:\Sparse\Iris_dataset');
load Iris_data;
load Iris_GT;
Data=IRIS;
c1=GT;
distance=[];

k=3;
Suc=[];
G1_aa=[];
G2_oa = [];
ClassesNumber=3;
KAP=[];


for z=1:5
    clas=[];
    K1=[];
    K2=[];
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
%         a=Testing_data(j,1);
%         b=Testing_data(j,2);
%         c=Testing_data(j,3);
%         d=Testing_data(j,4);
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
        
        clas=[clas label];  %predicted class 
    end
    
    success_rate=zeros(1,3); %gives us a zero matrix of 1x3 size
        for i=1:size(clas,2)
           
                
                if(testing_class(i)' == clas(i) && testing_class(i)~=0)
                    success_rate(testing_class(i))= success_rate(testing_class(i))+1;
                end
                
            
        end
        
        for lb=1:1:3
            success_rate(lb)=success_rate(lb)*100/(size(find(testing_class==lb),1));
        end
        
        Suc = [Suc; success_rate];
        % ROI = reshape(ROI,[size(Testing_data,1)*size(Testing_data,2),1]);
        % All_Class= reshape(All_Class,[size(Testing_data,1)*size(Testing_data,2),1]);
        
        index2 = find(testing_class~=0);
        clas_accr = clas(index2);
        Class_accr = testing_class(index2);
        
        accr = (size(find(Class_accr==clas_accr),1)*100)/size(index2,1);
        accr2 = sum(success_rate)/ClassesNumber;
        
        G1_aa = [G1_aa accr2];
        G2_oa = [G2_oa accr];
        
    
    
    confmat=zeros(max(ClassesNumber),max(ClassesNumber));
    
    for i=1:1:size(Class_accr,1)
        confmat(Class_accr(i),clas_accr(i))=confmat(Class_accr(i),clas_accr(i))+1;
    end
    
    r=sum(confmat,2);   %sum the rows of the confusion matrix
    c=sum(confmat,1);   %sum the columns of the confusion matrix
    a=sum(diag(confmat));
    b=c*r;
    n=sum(r);
    a1=a/n;
    b1=b/n^2;
    kappa=(a1-b1)/(1-b1);
    
    KAP = [KAP kappa];
    
    K1 = [K1 G1_aa];
    K2 = [K2 G2_oa];
   
end
average_accuracy=mean(K1)



