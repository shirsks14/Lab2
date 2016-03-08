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
        resolution = [obj.res, obj.XMin, obj.YMin, obj.XMax, obj.YMax];


        [obj.parzena, obj.x, obj.y] = parzen(class1, resolution, ParzenWin);
        [obj.parzenb, ~, ~] = parzen(class2, resolution, ParzenWin);
        [obj.parzenc, ~, ~] = parzen(class3, resolution, ParzenWin);
        
        end
        
        function Y = Classify(obj, Point)
            Y = -1;
            a = obj.parzena(Point(1), Point(2));
            b = obj.parzenb(Point(1), Point(2));
            c = obj.parzenc(Point(1), Point(2));
            
            [~, Y] = max([a b c]);
        end
        
        function Plot(obj)
        dx= obj.res;
        x1 = obj.XMin:dx:obj.XMax;
        x2 = obj.YMin:dx:obj.YMax;
        Y = zeros(length(x1), length(x2));
        for i = 1: obj.y
            for j=1:obj.x
                v=[x1(i), x2(j)];
                Y(j,i) = obj.Classify(v);
            end
        end
        temp = size(Y, 2);
         contourf(x1,x2,Y);
         
        end
    end
    
end

