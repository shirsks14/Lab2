% Lab 2
% Name: Shirshak Shrestha

clear all;
close all;



figureNo = 1;
%% Question 1
% Parametric Gaussian Distribution Estimation
% class a
load('lab2_1.mat');
AaMu = 5;
AaSigma = 1;
AbLam = 1;


% AaGPdf = normpdf(x1,AaMu,AaSigma);
% AbEPdf = exppdf(x1,AbLam);

EaMu = (1/length(a)) * sum(a);
EaSigma =  0;


% variance equals sum of (xi - mu)^2 divide by Number of terms
for i = 1:length(a)
    EaSigma = EaSigma +(a(i) - EaMu)^2;  
end
EaSigma = EaSigma/length(a);


figure(figureNo)
Lab2Utils.PlotGauss(EaMu,EaSigma,'g');
% plot(x1,EaGPdf, 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');
figureNo = figureNo +1;
% class b
EbMu = (1/length(b)) * sum(b);
EbSigma =  0;
% variance equals sum of (xi - mu)^2 divide by Number of terms
for i = 1:length(b)
    EbSigma = EbSigma +(b(i) - EbMu)^2;  
end
EbSigma = EbSigma/length(b);

figure(figureNo)
Lab2Utils.PlotGauss(EaMu,EaSigma,'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');
figureNo = figureNo +1;

% Parametric Exponential distribution
% class a
EaLam = length(a)/(sum(a));

figure (figureNo)
Lab2Utils.PlotExp(EaLam, 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');
figureNo = figureNo +1;

% class b
EbLam = length(b)/(sum(b));

figure (figureNo)
Lab2Utils.PlotExp(EaLam, 'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');
figureNo = figureNo +1;

% Uniform
% class a
figure(figureNo)
Lab2Utils.PlotUni(min(a), max(a), 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');
figureNo = figureNo +1;

% class b
figure(figureNo)
Lab2Utils.PlotUni(min(b), max(b), 'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');
figureNo = figureNo +1;
% Parzen Method
% class a
% Simga = 0.1

figure(figureNo)
Lab2Utils.PlotPar(a,0.1,1, 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');

figureNo = figureNo +1;
% close all % temporary close all
figure(figureNo)
Lab2Utils.PlotPar(a,0.2,1, 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');

figureNo = figureNo +1;

% class b
figure(figureNo)
Lab2Utils.PlotPar(b,0.1,1, 'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');

figureNo = figureNo +1;

figure(figureNo)
Lab2Utils.PlotPar(b,0.2,1, 'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');

figureNo = figureNo +1;

%% Question 2

% Parametric Classifier

clearvars -except figureNo;
% close all; % temporary
load('lab2_2.mat');

MLClassifier = MLClassifier(al,bl,cl);
figure(figureNo)
MLClassifier.Plot();


Classify_at = MLClassifier.MLClassifier_ClassifyClass(at);
Classify_bt = MLClassifier.MLClassifier_ClassifyClass(bt);
Classify_ct = MLClassifier.MLClassifier_ClassifyClass(ct);

Total_N = size(at,1)+size(bt,1)+size(ct,1);
Total_Misclassified_para = Total_N - (Classify_at(1) + Classify_bt(2) + Classify_ct(3));
Error_ML_Parametric = Total_Misclassified_para/Total_N
hold on
plot(al(:,1),al(:,2),'.r');plot(bl(:,1),bl(:,2),'xb');plot(cl(:,1),cl(:,2),'^g');
hold off

figureNo = figureNo +1;

% Non Parametric Classifier
variance = 400;

MLNonParametricClassifier = MLNonParametricClassifier(al,bl,cl,variance,10, [32 32]);
figure(figureNo)
MLNonParametricClassifier.Plot();

Classify_at_Nonpara = MLNonParametricClassifier.MLNonParametricClassifier_ClassifyClass(at);
Classify_bt_Nonpara = MLNonParametricClassifier.MLNonParametricClassifier_ClassifyClass(bt);
Classify_ct_Nonpara = MLNonParametricClassifier.MLNonParametricClassifier_ClassifyClass(ct);

Total_Misclassified_Nonpara = Total_N - (Classify_at_Nonpara(1) + Classify_bt_Nonpara(2) + Classify_ct_Nonpara(3));
Error_ML_NonParametric = Total_Misclassified_Nonpara/Total_N

hold on
plot(al(:,1),al(:,2),'.r');plot(bl(:,1),bl(:,2),'xb');plot(cl(:,1),cl(:,2),'^g');

figureNo = figureNo +1;

%% question 3

clearvars -except figureNo;
% clear all;
% close all; % temp close all
load('lab2_3.mat');

% sequential classifier 1
SequentialClassifier_1 = SequentialClassifier(a,b);
p_1 = SequentialClassifier_1.Sequential_ClassifyClass(a);
q_1 = SequentialClassifier_1.Sequential_ClassifyClass(b);
minX = min([min(a(:,1)) min(b(:,1))]);
minY = min([min(a(:,2)) min(b(:,2))]);
maxX = max([max(a(:,1)) max(b(:,1))]);
maxY = max([max(a(:,2)) max(b(:,2))]);
figure(figureNo)
SequentialClassifier_1.Plot(minX,minY, maxX, maxY);
hold on
plot(a(:,1),a(:,2),'.r');plot(b(:,1),b(:,2),'xb')
figureNo = figureNo +1;

Error_1 = (size(a,1)+size(b,1) - (p_1(1) + q_1(2)))/(size(a,1)+size(b,1));
% sequential classifier 2
SequentialClassifier_2 = SequentialClassifier(a,b);
p_2 = SequentialClassifier_2.Sequential_ClassifyClass(a);
q_2 = SequentialClassifier_2.Sequential_ClassifyClass(b);
Error_2 = (size(a,1)+size(b,1) - (p_2(1) + q_2(2)))/(size(a,1)+size(b,2));

figure(figureNo)
SequentialClassifier_2.Plot(minX,minY, maxX, maxY);
hold on
plot(a(:,1),a(:,2),'.r');plot(b(:,1),b(:,2),'xb')
figureNo = figureNo +1;

% sequential classifier 3
SequentialClassifier_3 = SequentialClassifier(a,b);
p_3 = SequentialClassifier_3.Sequential_ClassifyClass(a);
q_3 = SequentialClassifier_3.Sequential_ClassifyClass(b);
Error_3 = (size(a,1)+size(b,1) - (p_3(1) + q_3(2)))/(size(a,1)+size(b,2));

figure(figureNo)
SequentialClassifier_3.Plot(minX,minY, maxX, maxY);
hold on
plot(a(:,1),a(:,2),'.r');plot(b(:,1),b(:,2),'xb')
figureNo = figureNo +1;

Error = zeros(20,5);
for i = 1:20
    for j = 1:5
        SequentialClassifier = SequentialClassifier(a,b,j);
        p = SequentialClassifier.Sequential_ClassifyClass(a);
        q = SequentialClassifier.Sequential_ClassifyClass(b);
        Error(i,j) = (size(a,1)+size(b,1) - (p(1) + q(2)))/(size(a,1)+size(b,1));
        clear SequentialClassifier;
    end
end
Error_avg = [sum(Error(:,1))/20 sum(Error(:,2))/20 sum(Error(:,3))/20 sum(Error(:,4))/20 sum(Error(:,5))/20];

Error_min = [min(Error(:,1)) min(Error(:,2)) min(Error(:,3)) min(Error(:,4)) min(Error(:,5))];

Error_max = [max(Error(:,1)) max(Error(:,2)) max(Error(:,3)) max(Error(:,4)) max(Error(:,5))];

Error_Sigma = [0 0 0 0 0];

for i = 1:size(Error,1)
    Error_Sigma = Error_Sigma +[(Error(i,1) - Error_avg(1,1))^2 (Error(i,2) - Error(1,2))^2 (Error(i,3) - Error(1,3))^2 (Error(i,4) - Error(1,4))^2 (Error(i,5) - Error(1,5))^2];  
end

Error_Sigma = 1/20 *(Error_Sigma);

figure(figureNo)
plot(1:1:5,Error_avg, 'r');
hold on
plot(1:1:5,Error_min, 'g');
plot(1:1:5,Error_max, 'b');
plot(1:1:5,sqrt(Error_Sigma), 'k');
figureNo = figureNo + 1;




