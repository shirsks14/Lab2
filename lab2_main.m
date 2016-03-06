clear all;
close all;

load('lab2_1.mat');

figureNo = 1;
%% Question 1
% Parametric Gaussian Distribution Estimation
% class a
x1 = 0:0.1:10;
AaMu = 5;
AaSigma = 1;
AbLam = 1;
AaGPdf = normpdf(x1,AaMu,AaSigma);
AbEPdf = exppdf(x1,AbLam);

EaMu = (1/length(a)) * sum(a);
EaSigma =  0;


% variance equals sum of (xi - mu)^2 divide by Number of terms
for i = 1:length(a)
    EaSigma = EaSigma +(a(i) - EaMu)^2;  
end
EaSigma = EaSigma/length(a);


EaGPdf = normpdf(x1,EaMu,EaSigma);
figure(figureNo)
plot(x1,EaGPdf, 'g');
hold on
plot(x1,AaGPdf, 'r');
figureNo = figureNo +1;
% class b
AbLam = 1;
EbMu = (1/length(b)) * sum(b);
EbSigma =  0;
% variance equals sum of (xi - mu)^2 divide by Number of terms
for i = 1:length(b)
    EbSigma = EbSigma +(b(i) - EbMu)^2;  
end
EbSigma = EbSigma/length(b);

EbGPdf = normpdf(x1,EbMu,EbSigma);

figure(figureNo)
plot(x1,EbGPdf, 'g');
hold on
plot(x1,AbEPdf, 'r');
figureNo = figureNo +1;

% Parametric Exponential distribution
% class a
EaLam = length(a)/(sum(a));

EaEPdf = exppdf(x1, EaLam);

figure (figureNo)
plot(x1, EaEPdf, 'g');
hold on
plot(x1, AaGPdf, 'r');
figureNo = figureNo +1;

% class b
EbLam = length(b)/(sum(b));

EbEPdf = exppdf(x1, EbLam);

figure (figureNo)
plot(x1, EbEPdf, 'g');
hold on
plot(x1, AbEPdf, 'r');
figureNo = figureNo +1;

% Uniform
% class a
EaUPdf = unifpdf(x1, min(a), max(a));
figure(figureNo)
plot(x1, EaUPdf, 'g');
hold on
plot(x1, AaGPdf, 'r');
figureNo = figureNo +1;

% class b
EbUPdf = unifpdf(x1, min(b), max(b));
figure(figureNo)
plot(x1, EbUPdf, 'g');
hold on
plot(x1, AbEPdf, 'r');
figureNo = figureNo +1;
% Parzen Method
% class a
% Simga = 0.1

ParzenYa1 = Lab2Utils.ParzenGaussEstimation(x1,a,0.1,10);
figure(figureNo)
plot(x1,ParzenYa1);
hold on
plot(x1,AaGPdf);

figureNo = figureNo +1;

ParzenYa2 = Lab2Utils.ParzenGaussEstimation(x1,a,0.4,10);
figure(figureNo)
plot(x1,ParzenYa2);
hold on
plot(x1,AaGPdf);

figureNo = figureNo +1;

ParzenYb1 = Lab2Utils.ParzenGaussEstimation(x1,b,0.1,10);
figure(figureNo)
plot(x1,ParzenYb1);
hold on
plot(x1,AbEPdf);

figureNo = figureNo +1;

ParzenYb2 = Lab2Utils.ParzenGaussEstimation(x1,b,0.4,10);
figure(figureNo)
plot(x1,ParzenYb2);
hold on
plot(x1,AbEPdf);

figureNo = figureNo +1;

%% Question 2

clearvars -except figureNo;
% close all; % temporary
load('lab2_2.mat');

MLClassifier = MLClassifier(al,bl,cl);
figure(figureNo)
MLClassifier.Plot(al,bl,cl);
figureNo = figureNo +1;

% aMu = sum(al)/length(al);
% bMu = sum(bl)/length(bl);
% cMu = sum(cl)/length(cl);
% 
% 
% aSigma = Lab2.CalCovariance(al,aMu);
% bSigma = Lab2.CalCovariance(al,aMu);
% cSigma = Lab2.CalCovariance(al,aMu);


