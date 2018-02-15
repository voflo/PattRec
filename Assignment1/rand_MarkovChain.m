function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Authors: Philip o Calle
%---------------------------------------------

S=[];%space for resulting row vector
nS=mc.nStates;

% Get first state
Distr = DiscreteD(mc.InitialProb);
state = rand(Distr, 1);
if state == nS+1 %Check if we reached the end
   return;
end
S = [S state];


% Generate rest of state sequence.
for i=2:T
    Distr = DiscreteD(mc.TransitionProb(S(i-1), :)); %Get transition probs from where we are
    state = rand(Distr, 1);
    if state == nS+1 %Check if we reached the end
       break;
    end
    S = [S state];
end


