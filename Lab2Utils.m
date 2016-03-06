classdef Lab2Utils
    methods (Static)
        function Y = ParzenGaussEstimation(x1, Class, Sigma, K)
            N = length(Class);
            h = K/sqrt(N);
            
            for j = 1:length(x1)
                ParzenSum = 0;
                for i = 1:N
                    ParzenSum = ParzenSum + (1/h) * ((1/(sqrt(2*pi)*Sigma))*exp((-1/2*Sigma^2)*((x1(j) - Class(i))/h)^2));
                end
                Y(j) = (1/N)*ParzenSum;
            end      
        end
            
    end
end