classdef Lab2Utils
    methods (Static)
        function Y = ParzenGaussEstimation(x1, Class, Sigma, K)
            N = length(Class);
            h = K/sqrt(N);
            
            for j = 1:length(x1)
                ParzenSum = 0;
                for i = 1:N
                    ParzenSum = ParzenSum + ((1/(sqrt(2*pi)*Sigma))*exp((-1/2*Sigma^2)*((x1(j) - Class(i))/h)^2));
                end
                Y(j) = (1/N)*(1/h)*ParzenSum;
            end      
        end
        
        function PlotGauss(Mu, Sigma, color)
            x = Mu -5:Sigma/100:Mu+5;
            y = normpdf(x,Mu,Sigma);
            plot(x,y,color);
        end
        function PlotExp(Lamda, color)
            x = 0: 0.1:10;
            y = exppdf(x,Lamda);
            plot(x,y,color);
        end
        
        function PlotUni(min_x, max_x, color)
            x= min_x -5: (max_x - min_x)/100:max_x+5;
            y = unifpdf(x, min_x, max_x);
            plot(x,y,color);
        end
        
        function PlotPar(Class, Sigma, K, color)
            p= min(Class);
            q = max(Class);
            d = (max(Class) - max(Class))/100;
            x = min(Class) -5 : (max(Class) - min(Class))/100:max(Class)+5;
            z=Lab2Utils.ParzenGaussEstimation(x,Class,Sigma, K);
            plot(x,z,color);
        end
        
    end
end