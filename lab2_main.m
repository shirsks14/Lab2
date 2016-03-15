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
AbLam = 1;
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

% clearvars -except al bl cl% temp clear
% close all % temp close
% 
% xMin = min([min(al(:,1)) min(bl(:,1)) min(cl(:,1))]);
% xMax = max([max(al(:,1)) max(bl(:,1)) max(cl(:,1))]);
%             
% yMin = min([min(al(:,2)) min(bl(:,2)) min(cl(:,2))]);
% yMax = max([max(al(:,2)) max(bl(:,2)) max(cl(:,2))]);
% 
% 
% 
% 
% varianceParzen2D = 400;
% ParzenWin = fspecial('gaussian',[10 10] , sqrt(400));
% resolution = [1 xMin yMin xMax yMax];
% 
% 
% [parzena, xa, ya] = parzen(al, resolution, ParzenWin);
% [parzenb, xb, yb] = parzen(bl, resolution, ParzenWin);
% [parzenc, xc, yc] = parzen(cl, resolution, ParzenWin);
% 
% probs{1} = parzena;
% probs{2} = parzenb;
% probs{3} = parzenc;
% 
% 
% clearvars -except probs % temp clear variables
% 
% pdfa = cell2mat(probs(1));

%% question 3

% clearvars -expect figureNo;
clear all;
close all; % temp close all
load('lab2_3.mat');
SequentialClassifier = SequentialClassifier(a,b);
p = SequentialClassifier.Sequential_ClassifyClass(a);
q = SequentialClassifier.Sequential_ClassifyClass(b);

% a = a';
% b= b';
% % G = MEDClassifier;
% naB = [];
% nbA = [];
% counter = 1; % j from the lab
% Na = size(a,2);
% Nb = size(b,2);
% while ((size(a,2) ~= 0) && (size(b,2) ~=0))
%     A_num = randi([1, size(a,2)]);
%     B_num = randi([1, size(b,2)]);
%     AMu = a(:,A_num);
%     BMu = b(:,B_num);
%     MED = MEDClassifier(AMu, BMu);
%     naB_temp = MED.DataClassification(a);
%     naB_temp = naB_temp(2);
%     nbA_temp = MED.DataClassification(b);
%     nbA_temp = nbA_temp(2);
%     if((nbA_temp == 0) || (naB_temp ==0))
%         G{counter} = MED;
%         naB(counter) = naB_temp;
%         nbA(counter) = nbA_temp;
%         counter = counter +1;
%     end
%     if(naB_temp ==0)
%         a(:,A_num) = [];
%     end
%     if(nbA_temp == 0)
%         b(:,B_num) = [];
%     end
% end






