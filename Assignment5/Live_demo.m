function Live_demo
addpath('PattRecClasses\');
addpath('GetMusicFeatures\');
addpath('Train\');
addpath('Small_Train\');
addpath('Test\');
addpath('Small_Test\');

load('hmms_final');

Fs = 22050;

recorder = audiorecorder(Fs,16,1);
fprintf("Press any character to start recording\n");% (%i seconds)\n", reclength);
pause;

fprintf("Recording audio, press any character to stop\n");
record(recorder)
pause;
stop(recorder);


fprintf("Done! Press any character to listen\n");
pause;
p = play(recorder);

fprintf("Press any character to classify\n");
pause;


y = getaudiodata(recorder, 'int16');
%[y,Fs] = audioread(file.name);
fprintf("Extracting features...\n");
frIsequence = GetMusicFeatures(y,Fs);
features = FeatureExtractor(frIsequence);

fprintf("Classifying...\n");
lp=logprob(hmms,features(1,:));
[~, argmax] = max(lp);

fprintf("Most probable song: %i \n", argmax);
