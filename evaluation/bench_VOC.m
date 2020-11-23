addpath benchmarks
clear
close all;

%motivated from PascalVOC2012

dataDir = '';   %path to train.txt
gtDir = '';	%path to gt
inDir = ''; 	%path to output



D=dlmread(dataDir);
acc=[];
for ii=1:length(D)
    image=num2str(D(ii));
    res=load([inDir,image,'.mat']);
    seg=uint8(res.out+1);
    gt=imread([gtDir,image,'.png']);
    gval=unique(gt);
    gthold=zeros(size(gt));
    for j=1:length(gval)
        ind=find(gt==gval(j));
        gthold(ind)=j;
    end
    gt=gthold;
    gt=double(gt);
    seg=double(seg);
    seg=imresize(seg,[size(gt,1),size(gt,2)],'nearest');
    num1 = max(gt(:)) + 1; 
    num2 = max(seg(:)) + 1;
    confcounts = zeros(num1, num2);

    % joint histogram
    sumim = 1 + gt + seg*num1;

    hs = histc(sumim(:), 1:num1*num2);
    confcounts(:) = confcounts(:) + hs(:);

    accuracies = zeros(num1-1, num2-1);
    for j = 1:num1
        for i = 1:num2
            gtj = sum(confcounts(j, :));
            resj = sum(confcounts(:, i));
            gtjresj = confcounts(j, i);
            accuracies(j, i) = gtjresj / (gtj + resj - gtjresj);
        end
    end
    matches = accuracies(2:end, 2:end);
    matchesSeg = max(matches, [], 2);
    matchesGT = max(matches, [], 1);
    acc(ii,1)=mean(matchesGT);
    acc(ii,2)=mean(matchesSeg);
   
end
mean(acc)
