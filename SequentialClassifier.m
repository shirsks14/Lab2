classdef SequentialClassifier
   properties
       G
       naB
       nbA
   end
   
   methods
       function obj = SequentialClassifier(a, b, j)
           a = a';
           b= b';
           
           if(nargin == 2)
               j = size(a,2) + size(b,2);
           end
           
           % G = MEDClassifier;
%            naB = [];
%            nbA = [];
           counter = 1; % j from the lab
%            Na = size(a,2);
%            Nb = size(b,2);
           while ((size(a,2) ~= 0) && (size(b,2) ~=0) && (counter <= j))
               A_num = randi([1, size(a,2)]);
               B_num = randi([1, size(b,2)]);
               AMu = a(:,A_num);
               BMu = b(:,B_num);
               MED = MEDClassifier(AMu, BMu);
               naB_temp = MED.DataClassification(a);
               naB_temp = naB_temp(2);
               nbA_temp = MED.DataClassification(b);
               nbA_temp = nbA_temp(1);
               if((nbA_temp == 0) || (naB_temp ==0))
                   obj.G{counter} = MED;
                   obj.naB(counter) = naB_temp;
                   obj.nbA(counter) = nbA_temp;
                   counter = counter +1;
               end
               if(naB_temp ==0)
                   b(:,B_num) = [];
               end
               if(nbA_temp == 0)
                   a(:,A_num) = [];
               end
          end
       end
       function Y = Sequential_Classify(obj,point)
           Y = -1;
           counter = 1;
           NG = length(obj.G);
           done = false;
            while((counter ~= NG) && (done == false)) 
                temp_class = obj.G{counter}.MED_Classify(point);
                if((temp_class == 2)&&(obj.naB(counter) ==0))
                    Y = temp_class;
                    done = true;
                end
                if((temp_class == 1)&&(obj.nbA(counter) == 0))
                    Y = temp_class;
                    done = true;
                end
                counter = counter + 1;
            end
       end
       function Y = Sequential_ClassifyClass(obj, class)
           class = class';
           nA = 0;
           nB = 0;
           for i= 1:size(class,2)
              x = [class(1,i) class(2,i)]';
              temp_class = obj.Sequential_Classify(x);
              if(temp_class == 1)
                 nA = nA +1; 
              end
              if(temp_class == 2)
                 nB = nB +1; 
              end              
           end
           Y = [nA nB];
       end
   end 
end