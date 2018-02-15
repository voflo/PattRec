function feature_extractor_plots()

[y,Fs] = audioread('melody_1.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
figure(1)
plot(features(1,:))
axis([0 inf 1 inf])
title('melody\_1')
xlabel('Time')
ylabel('Semitone distance')
figure(2)
plot(features(2,:))
axis([0 inf 1 inf])
title('melody\_1')
xlabel('Time')
ylabel('Direction')

[y,Fs] = audioread('melody_2.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
figure(3)
plot(features(1,:))
axis([0 inf 1 inf])
title('melody\_2')
xlabel('Time')
ylabel('Semitone distance')
figure(4)
plot(features(2,:))
axis([0 inf 1 inf])
title('melody\_2')
xlabel('Time')
ylabel('Direction')

[y,Fs] = audioread('melody_3.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
figure(5)
plot(features(1,:))
axis([0 inf 1 inf])
title('melody\_3')
xlabel('Time')
ylabel('Semitone distance')
figure(6)
plot(features(2,:))
axis([0 inf 1 inf])
title('melody\_3')
xlabel('Time')
ylabel('Direction')

[y,Fs] = audioread('melody_4.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);
figure(7)
plot(features(1,:))
axis([0 inf 1 inf])
title('Own melody')
xlabel('Time')
ylabel('Semitone distance')
figure(8)
plot(features(2,:))
axis([0 inf 1 inf])
title('Own melody')
xlabel('Time')
ylabel('Direction')