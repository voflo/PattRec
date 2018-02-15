function testfile()

[y,Fs] = audioread('melody_1.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
frIsequence2 = GetMusicFeatures(y,Fs);
frIsequence2(1,:) = frIsequence2(1,:)*2;%Transpose the pitch
features2 = FeatureExtractor(frIsequence2);
figure(1)
plot(features(1,:))
axis([0 inf 1 inf])
title('melody\_1')
xlabel('Time')
ylabel('Semitone distance')
figure(2)
plot(features2(1,:))
axis([0 inf 1 inf])
title('melody\_1 transposed')
xlabel('Time')
ylabel('Semitone distance')

%Plot the frequencies
figure(3)
plot(frIsequence(1,:))
title('melody\_1')
xlabel('Time')
ylabel('Frequency, Hz')
figure(4)
plot(frIsequence2(1,:))
title('melody\_1 transposed')
xlabel('Time')
ylabel('Frequency, Hz')

