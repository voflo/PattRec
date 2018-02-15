function testfile()

[y,Fs] = audioread('melody_4.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
figure(1)
plot(features(1,:))
axis([0 inf 1 inf])
title('Own melody')
xlabel('Time')
ylabel('Semitone distance')
figure(2)
plot(features(2,:))
axis([0 inf 1 inf])
title('Own melody')
xlabel('Time')
ylabel('Direction')