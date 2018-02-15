function Feature_plots()

[y,Fs] = audioread('Song recordings\melody_5_1.wav');
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);

figure(1)
plot(features(2,:))
axis([0 inf 1 inf])
title('Vem kan segla')
xlabel('Time')
ylabel('Semitone distance')
figure(2)
plot(features(3,:))
axis([0 inf 1 inf])
title('Bä, bä vita lamm')
xlabel('Time')
ylabel('Direction')

figure(3)
plot(features(1,:))
axis([0 inf 1 inf])
title('Bä, bä vita lamm')
xlabel('Time')
ylabel('Combined feature')

load('hmms_final');
[X,S]= rand(hmms(5),length(features(1,:)));
figure(4)
plot(mod(X,172))
axis([0 inf 1 inf])
title('Randomly generated Vem kan segla')
xlabel('Time')
ylabel('Combined feature, mod 172')