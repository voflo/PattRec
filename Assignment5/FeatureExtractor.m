function [features] = FeatureExtractor(frIsequence)

prevFreq = 0;
%meanIntensityExponent = mean(log(frIsequence(3,:)))
for i = 1:size(frIsequence,2)
    [semitoneDiff, direction] = getSemitoneDist(prevFreq, frIsequence(1, i));
    %isSong = isSong(log(frIsequence(3, i)), meanIntensityExponent);
    %songFreq = frIsequence(1,i) .* isSong; %Temp intensity
    %features(:,i) = [semitoneDiff; direction; isSong; songFreq];
    %features(:,i) = [semitoneDiff; direction];
    features(:,i) = [semitoneDiff + (direction-1)*172; semitoneDiff; direction];
    %features(:,i) = [semitoneDiff; semitoneDiff; direction];
    prevFreq = frIsequence(1, i);
end

% Returns a semitone differance and a direction of the distance
% Dist 1 at when semitone remains the same
% Maximum value when the jump is from 0 to 20000, with results in
% semitoneDist = 172
% Direction is 1 when the frequency goes down, 2 when it goes up
function [semitoneDist, direction] = getSemitoneDist(currFreq, prevFreq)
%Limit the frequencies, 1-20000
if currFreq <= 0
    currFreq = 1;
end
if prevFreq <= 0
    prevFreq = 1;
end
if currFreq > 20000
    currFreq = 20000;
end
if prevFreq > 20000
    prevFreq = 20000;
end

if currFreq == prevFreq
    direction = 3; %"still"
    semitoneDist = 1;
    return;
elseif currFreq > prevFreq
    small = prevFreq;
    big = currFreq;
    direction = 2; %"up"
else
    big = prevFreq;
    small = currFreq;
    direction = 1; %"down"
end

%Calculate the distance in semitones
semitonescalar = nthroot(2, 12);
semitoneDist = 1; %Minimum value
while big > small && big/small > semitonescalar 
    small = small*semitonescalar;
    semitoneDist = semitoneDist + 1;
end


%1 if this is noice
% function isSong = isSong(intensityExponent, meanIntensityExponent)
% isSong = 1;
% if intensityExponent < meanIntensityExponent
%     isSong = 0;
% end
