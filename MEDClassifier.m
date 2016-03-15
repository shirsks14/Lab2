classdef MEDClassifier
    properties
        aMu
        bMu
    end
    
    methods
        function obj = MEDClassifier(AMu, BMu)
            if(nargin ~= 0)
                obj.aMu = AMu;
                obj.bMu = BMu;
            end
        end
        
        function setMeans(obj, AMu, BMu)
            obj.aMu = AMu;
            obj.bMu = BMu;
        end
        
        function Y = MED_Classify(obj, Point)
            distanceA = (Point - obj.aMu)' * (Point - obj.aMu);
            distanceB = (Point - obj.bMu)' * (Point - obj.bMu);
            [~, Y] = min([distanceA distanceB]);   
        end
        
        function Y = DataClassification(obj, dataPoints)
            nA = 0;
            nB = 0;
            for i = 1:size(dataPoints,2)
                if(obj.MED_Classify(dataPoints(:,i)) == 1)
                    nA = nA +1;
                else
                    nB = nB +1;
                end 
            end
            Y = [nA, nB];
            
        end
    end
    
end
