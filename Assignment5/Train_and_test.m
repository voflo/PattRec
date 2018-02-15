function Train_and_test
addpath('PattRecClasses\');
addpath('GetMusicFeatures\');
addpath('Train\');
addpath('Small_Train\');
addpath('Test\');
addpath('Small_Test\');
addpath('Song recordings\');

%Read in training data
fprintf("Reading training data...\n");
training_data = ReadDataFromDirectory('Train');
%training_data = ReadDataFromDirectory('Small_Train');
%training_data = ReadDataFromDirectory('Song recordings');

%Create HMM:s
fprintf("Creating HMM: ");
numberOfSongs = 8;
nStates = 15;

pD = [];
pmass = ones(1,345);%2*172+1=345
pD = [pD DiscreteD(pmass)];
pmass = ones(1,3);
%pD = [pD DiscreteD(pmass)];

hmms = [];
for i = 1:numberOfSongs
    fprintf("%i ", i);
    obsData = cell2mat(training_data{i,1});
    obsData = obsData(1,:);%use only first feature
    lData = cell2mat(training_data{i,2});
    %hmms = [hmms; MakeErgodicHMM(nStates,[],pD,obsData,lData)];
    hmms = [hmms; MakeLeftRightHMM(nStates,pD,obsData,lData)];
    %hmms(i) = MakeLeftRightHMM(nStates,DiscreteD(ones(1,numberOfSongs)),obsData,lData);
end

save('hmms.mat', 'hmms');

%Read in testing data
fprintf("\nReading testing data...\n");
testing_data = ReadDataFromDirectory('Test');
%testing_data = ReadDataFromDirectory('Small_Test');

%Test HMM:s on testing data
fprintf("Classifying songs...\n");
num_correct = 0;
total_guesses = 0;
for i=1:size(testing_data,1)
    samples = testing_data{i,1};
    for j=1:size(samples, 2)
        lp=logprob(hmms,samples{j}(1,:));
        [~, argmax] = max(lp);
        if (argmax == i)
            num_correct = num_correct + 1; % if correct, add 1.
            fprintf("Correctly classified sample %i of song %i\n", j, i);
        end
        
        
        total_guesses = total_guesses +1;
    end
end

%Display results
fprintf("Using %i states, classified %i out of %i songs correctly: %f%%\n",... 
    nStates, num_correct, total_guesses, num_correct/total_guesses);


function data = ReadDataFromDirectory(dirname)
data = cell(8,2);   % 8x2 matrix containing a vector of data cells in the first column and and a vector with 
                    %length of the corresponding data cell in the second column
                    %Each data cell consists of 2 rows with the
                    %corresponding features

files = dir(dirname);
for i = 1:length(files)
    file = files(i);
    if endsWith(file.name, 'wav')
        [y,Fs] = audioread(file.name);
        frIsequence = GetMusicFeatures(y,Fs);
        features = FeatureExtractor(frIsequence);
        
        melody_number = GetMelodyNumber(file.name);
        data{melody_number,1}{end +1} = features; %Append the extraced features to the correct row
        data{melody_number,2}{end +1} = size(features,2);%Append the length of the extracted recording to the correct row
    end
end
%data{4,1}{3} = feature vectors for sample number 3 for melody number 4
%data{4,2}{3} = length of the recording of sample number 3 for melody number 4

function number = GetMelodyNumber(filename) %Assumes less than 10 melodies
number = str2num(filename(8));
return
