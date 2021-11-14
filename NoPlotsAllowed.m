%% No Plots Allowed
clc
clear
close all
path = {'ErrPSpeller/Subject1/Offline', 'ErrPSpeller/Subject1/S2','ErrPSpeller/Subject1/S3', 'ErrPSpeller/Subject2/Offline', 'ErrPSpeller/Subject2/S2','ErrPSpeller/Subject2/S3', 'ErrPSpeller/Subject4/Offline', 'ErrPSpeller/Subject4/S2','ErrPSpeller/Subject4/S3', 'ErrPSpeller/Subject5/Offline', 'ErrPSpeller/Subject5/S2','ErrPSpeller/Subject5/S3'};
% path 1-3 subject 1
% path 4-6 subject 2
% path 7-9 subject 4
% path 10-12 subject 5
data = [];
results = [];

%% for each subject
for s=[1]
    % for s=[2,3,5,6,8,9,11,12] %,4,7,10]
    [signals, event] = loadData(path{s});
    signals = signals(:, 1:16);
    fs = 512;
    load chanlocs16.mat chanlocs16
    clc
    File = path{s}
    % Fz, FC3, FC1, FCz, FC2, FC4, C3, C1, Cz, C2, C4, CP3, CP1, CPz, CP2, CP4
    
    %% Sort data into classes
    errorIndex = []; % will contain trial number of every error trial
    NEIndex = []; % will contain trial number of every no error trial
    for i=1:length(event.type)
        if(event.type(i) == 1)
            errorIndex(end+1) = i;
        else
            NEIndex(end+1) = i;
        end
    end
    NEIndex = NEIndex(1:end-1);
    
    %% Filtering
    % Spatial filtering
    signals = spatialFiltering(signals,fs,event,errorIndex,NEIndex); % Returns Curently just CAR, see spatial filtering file for others,
    
    f_a = [1 10]; % alpha band
    f_b = [18 22]; % beta band
    N = 5; % filter order
    [A1, A2] = butter(N, [f_a(1) f_a(2)]*2 /fs);
    % [B1, B2] = butter(N, [f_b(1) f_b(2)]*2 /fs);
    s_a = filtfilt(A1, A2,signals);
    % s_b = filter(B1, B2,signals);
    
    rectSignal = s_a(:,:).^2; % signal power
    
    beforeTrig = 0; % seconds of signal to be recorded before start of trial
    afterTrig = 1; % seconds of signal after trial start
    
    %% Feature Extraction
    WSize = 1; % Hyperparameter
    Olap = 0;    % Hyperparameter
    Y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];
    [meanFeat, maxFeat, minFeat, parFeat, narFeat, tarFeat, zcFeat, len] = featExt2(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event.position, fs, s_a);
    
    dataNew = [... % coloumn stacked features
        reshape(maxFeat, length(Y),len*16), ...
        reshape(minFeat, length(Y),len*16), ...
        reshape(meanFeat, length(Y),len*16), ...
        reshape(tarFeat, length(Y),len*16)...
        reshape(parFeat, length(Y),len*16), ...
        reshape(narFeat, length(Y),len*16), ...
        
%         reshape(zcFeat, length(Y),len*16)...
        ];
    
    data = [data; dataNew];   % combines all sessions features into one matrix
    results = [results; Y];   % combines all sessions trials into one "error" "no Error" vector
    for(i=1:length(results))
        if(results(i) == 1)
            results2(i) ="Error";
        else
            results2(i) = "No Error";
        end
    end
    results2 = results2';
    
    
end

%%  Feature Scoring
mdl = fscnca(data,results2);  % fisher score equivilant, not sure how its different
figure
stem(mdl.FeatureWeights) %% shows feature weights for all features in data

