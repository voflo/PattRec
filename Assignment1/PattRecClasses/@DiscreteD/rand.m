function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Authors: Philip o Calle
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

%*** Insert your own code here and remove the following error message 
R = zeros(1,nData);
for i=1:nData
    r = rand();
    temp = pD.ProbMass(1);
    for j=1:numel(pD.ProbMass)
        if r < temp
            R(i) = j;
            break;
        else
            temp = temp + pD.ProbMass(j+1);
        end
    end
    
end
