function [hNew,hGen]=testDiscrete3%test training a single DiscreteD object%Arne Leijon 2011-08-29 tested%make a simple DiscreteD distributionhGen=DiscreteD([3 3 0 1 0]);%Make a big training data sequence:xTraining=rand(hGen,3000);%training datahNew=DiscreteD([1 1 1 1 1]);hNew.PseudoCount=1;%hNew=init(hNew,xTraining);aS=hNew.adaptStart;aS=hNew.adaptAccum(aS,xTraining);hNew=hNew.adaptSet(aS);end