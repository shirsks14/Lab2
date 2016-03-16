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
Lab2Utils.PlotPar(a,0.4,22, 'g');
hold on
Lab2Utils.PlotGauss(AaMu,AaSigma,'r');

figureNo = figureNo +1;

% class b
figure(figureNo)
Lab2Utils.PlotPar(b,0.1,10, 'g');
hold on
Lab2Utils.PlotExp(AbLam, 'r');

figureNo = figureNo +1;

figure(figureNo)
Lab2Utils.PlotPar(b,0.4,10, 'g');
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



hold on
plot(al(:,1),al(:,2),'.r');plot(bl(:,1),bl(:,2),'xb');plot(cl(:,1),cl(:,2),'^g');
hold off

figureNo = figureNo +1;

% Non Parametric Classifier
variance = 400;

MLNonParametricClassifier = MLNonParametricClassifier(al,bl,cl,variance,10, [32 32]);
figure(figureNo)
MLNonParametricClassifier.Plot();
hold on
plot(al(:,1),al(:,2),'.r');plot(bl(:,1),bl(:,2),'xb');plot(cl(:,1),cl(:,2),'^g');
hold off

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

Error_1 = (size(a,1)+size(b,2) - (p_1(1) + q_1(2)))/(size(a,1)+size(b,2));
% sequential classifier 2
SequentialClassifier_2 = SequentialClassifier(a,b);
p_2 = SequentialClassifier_2.Sequential_ClassifyClass(a);
q_2 = SequentialClassifier_2.Sequential_ClassifyClass(b);
Error_2 = (size(a,1)+size(b,2) - (p_2(1) + q_2(2)))/(size(a,1)+size(b,2));

% sequential classifier 3
SequentialClassifier_3 = SequentialClassifier(a,b);
p_3 = SequentialClassifier_3.Sequential_ClassifyClass(a);
q_3 = SequentialClassifier_3.Sequential_ClassifyClass(b);
Error_3 = (size(a,1)+size(b,2) - (p_3(1) + q_3(2)))/(size(a,1)+size(b,2));

% Error = zeros(20);
for i = 1:20
    
    SequentialClassifier = SequentialClassifier(a,b,i);
    p = SequentialClassifier.Sequential_ClassifyClass(a);
    q = SequentialClassifier.Sequential_ClassifyClass(b);
    Error(i) = (size(a,1)+size(b,2) - (p(1) + q(2)))/(size(a,1)+size(b,2));
    clear SequentialClassifier;
end

figure(figureNo)
plot(1:1:20,Error);





