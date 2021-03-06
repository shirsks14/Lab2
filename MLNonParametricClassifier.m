classdef MLNonParametricClassifier
    %MLNONPARAMETRICCLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        XMin
        YMin
        
        XMax
        YMax
        
        parzena
        parzenb
        parzenc
        
        res
        x
        y
        
    end
    
    methods
        function obj = MLNonParametricClassifier(class1, class2, class3, variance, res, size)
        obj.XMin = min([min(class1(:,1)) min(class2(:,1)) min(class3(:,1))]);
        obj.XMax = max([max(class1(:,1)) max(class2(:,1)) max(class3(:,1))]);
            
        obj.YMin = min([min(class1(:,2)) min(class2(:,2)) min(class3(:,2))]);
        obj.YMax = max([max(class1(:,2)) max(class2(:,2)) max(class3(:,2))]);
        
        ParzenWin = fspecial('gaussian', size , sqrt(variance));
        obj.res = res;
        resolution = [obj.res, 0, 0, 500 - mod(500,res), 500- mod(500,res)];


        [obj.parzena, obj.x, obj.y] = parzen(class1, resolution, ParzenWin);
        [obj.parzenb, ~, ~] = parzen(class2, resolution, ParzenWin);
        [obj.parzenc, ~, ~] = parzen(class3, resolution, ParzenWin);
        
        end
        
        function Y = Classify(obj, Point)
            Y = -1;
            x_int = int32(Point(1)/obj.res)+1;
            y_int = int32(Point(2)/obj.res)+1;
            
            if((x_int <= size(obj.parzena,2))&&(y_int <= size(obj.parzena,1)))
                a = obj.parzena(y_int, x_int);
            else
                a = 0;
            end
            if((x_int <= size(obj.parzenb,2))&&(y_int <= size(obj.parzenb,1)))
                b = obj.parzenb(y_int, x_int);
            else
                b =0;
            end
            if((x_int <= size(obj.parzenc,2))&&(y_int <= size(obj.parzenc,1)))
                c = obj.parzenc(y_int, x_int);
            else
                c = 0;
            end
            
            if(max([a b c])  ~= 0)
                [~, Y] = max([a b c]);
            end
        end
        
        function Y = MLNonParametricClassifier_ClassifyClass(obj, class)
           nA = 0;
           nB = 0;
           nC = 0;
           for i= 1:size(class,1)
              x = [class(i,1) class(i, 2)]';
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
        dx= obj.res;
        x1 = 1:dx:500- mod(500,obj.res);
        x2 = 1:dx:500- mod(500,obj.res);
        Y = zeros(length(x1), length(x2));
        for i = 1: length(x1)
            for j=1:length(x2)
                v=[x1(i), x2(j)];
                Y(j,i) = obj.Classify(v);
            end
        end
         contourf(x1,x2,Y,[2 3]);
         
        end
    end
    
end

