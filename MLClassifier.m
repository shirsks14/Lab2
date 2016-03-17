classdef MLClassifier
    properties
        
        aMu
        bMu
        cMu
        
        XMin
        YMin
        
        XMax
        YMax

        aSigma
        bSigma
        cSigma
    end
    
    methods
        function Y = CalCovariance(obj, x, Mu)
            Y = zeros(2,2);
            for i = 1:length(x)
                Y = Y + (x(i)' - Mu')*(x(i)' -Mu')';
            end
            Y = Y/length(x);
            Y = length(x)/(length(x) - 1) * Y;
        end
        
        function obj = MLClassifier(class1, class2, class3)
            obj.aMu = sum(class1)/length(class1);
            obj.bMu = sum(class2)/length(class2);
            obj.cMu = sum(class3)/length(class3);
            
            obj.XMin = min([min(class1(:,1)) min(class2(:,1)) min(class3(:,1))]);
            obj.XMax = max([max(class1(:,1)) max(class2(:,1)) max(class3(:,1))]);
            
            obj.YMin = min([min(class1(:,2)) min(class2(:,2)) min(class3(:,2))]);
            obj.YMax = max([max(class1(:,2)) max(class2(:,2)) max(class3(:,2))]);
            
            obj.aSigma = obj.CalCovariance(class1,obj.aMu);
            obj.bSigma = obj.CalCovariance(class2,obj.bMu);
            obj.cSigma = obj.CalCovariance(class3,obj.cMu);
        end
        
        
        function Y = Classify(obj, point)
            
%             distancea = (point - obj.aMu')'*obj.aSigma*(point - obj.aMu') - log(det(obj.aSigma));
%             distanceb = (point - obj.bMu')'*obj.bSigma*(point - obj.bMu') - log(det(obj.bSigma));
%             distancec = (point - obj.cMu')'*obj.cSigma*(point - obj.cMu') - log(det(obj.cSigma));
            Gaussa = 1/(sqrt(2*pi)*det(obj.aSigma))*exp(-0.5*(point-obj.aMu')'*inv(obj.aSigma)*(point-obj.aMu'));
            Gaussb = 1/(sqrt(2*pi)*det(obj.bSigma))*exp(-0.5*(point-obj.bMu')'*inv(obj.bSigma)*(point-obj.bMu'));
            Gaussc = 1/(sqrt(2*pi)*det(obj.cSigma))*exp(-0.5*(point-obj.cMu')'*inv(obj.cSigma)*(point-obj.cMu'));
            [~, Y] = max([Gaussa Gaussb Gaussc]);
        end
    
       function Y = MLClassifier_ClassifyClass(obj, class)
           nA = 0;
           nB = 0;
           nC = 0;
           for i= 1:size(class,2)
              x = [class(1,i) class(2,i)]';
              temp_class = obj.Classify(x);
              if(temp_class == 1)
                 nA = nA +1; 
              end
              if(temp_class == 2)
                 nB = nB +1; 
              end 
              if(temp_class == 3)
                 nC = nC +1; 
              end 
           end
           Y = [nA nB nC];
       end    
    
        function Plot(obj)
            dx= 5;
            x1 = obj.XMin:dx:obj.XMax;
            x2 = obj.YMin:dx:obj.YMax;
            Y = zeros(length(x1), length(x2));
            for i = 1: length(x1)
                for j=1:length(x2)
                    v=[x1(i);x2(j)];
                    Y(i,j) = obj.Classify(v);
                end
            end
             contourf(x1,x2,Y,[2 3]);
        end
    
  end
end