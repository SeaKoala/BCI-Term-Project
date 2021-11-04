%% No Plots Allowed
clc
clear
close all
path = {'ErrPSpeller/Subject1/Offline', 'ErrPSpeller/Subject1/S2','ErrPSpeller/Subject1/S3', 'ErrPSpeller/Subject2/Offline', 'ErrPSpeller/Subject2/S2','ErrPSpeller/Subject2/S3', 'ErrPSpeller/Subject4/Offline', 'ErrPSpeller/Subject4/S2','ErrPSpeller/Subject4/S3', 'ErrPSpeller/Subject5/Offline', 'ErrPSpeller/Subject5/S2','ErrPSpeller/Subject5/S3'};
% path = 'ErrPSpeller/Subject1/Offline';
% maxFeatures = zeros{4,3};
% minFeatures = zeros{4,3};
% varFeatures = zeros{4,3};
%% for each subject
for s=[1] %,4,7,10]
    [signals, event] = loadData(path{s});
    signals = signals(:, 1:16);
    fs = 512;
    load chanlocs16.mat chanlocs16
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
    signals = spatialFiltering(signals,fs,event,errorIndex,NEIndex);
    
    f_a = [1 10]; % alpha band
    f_b = [18 22]; % beta band
    N = 5; % filter order
    [A1, A2] = butter(N, [f_a(1) f_a(2)]*2 /fs);
    % [B1, B2] = butter(N, [f_b(1) f_b(2)]*2 /fs);
    s_a = filter(A1, A2,signals); 
    % s_b = filter(B1, B2,signals); 

    rectSignal = s_a(:,:).^2; % signal power
    %% Grand Average
    beforeTrig = 0; % seconds of signal to be recorded before start of trial
    afterTrig = 1; % seconds of signal after trial start

    GavgError = zeros(round(fs*(beforeTrig+afterTrig)),16);
    GavgNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
    GavgRectError = zeros(round(fs*(beforeTrig+afterTrig)),16);
    GavgRectNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
    for(c =1:16) % for every channel
        for(i=1:length(errorIndex)) % for every trial in error trial index array
            for(j = 1:length(GavgError)) % for length of trial (endsample - start sample)
                GavgError(j,c) = GavgError(j)+ s_a(event.position(errorIndex(i))-beforeTrig*fs+j, c);
                GavgRectError(j,c) = GavgRectError(j)+ rectSignal(event.position(errorIndex(i))-beforeTrig*fs+j, c);
            end 
        end
        for(i=1:length(NEIndex))
            for(j = 1:length(GavgNE))
                GavgNE(j,c) = GavgNE(j)+ s_a(event.position(NEIndex(i))-beforeTrig*fs+j, c);
                GavgRectNE(j,c) = GavgRectNE(j)+ rectSignal(event.position(NEIndex(i))-beforeTrig*fs+j, c);
            end 
        end
        GavgError(:,c) = GavgError(:,c)./length(errorIndex);
        GavgNE(:,c) = GavgNE(:,c)./length(NEIndex);
        GavgRectError(:,c) = GavgRectError(:,c)./length(errorIndex);
        GavgRectNE(:,c) = GavgRectNE(:,c)./length(NEIndex);
    end
    i=0;

    %% Feature Extraction
    WSize = .25;
    Olap = .5;
    [varER, meanER, maxER, minER, varNE, meanNE, maxNE, minNE, slopeER, slopeNE, len] = featureExt(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event.position, fs, s_a);
    
     
    %% feature ranking
    Y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];

     meanRanks(:, :,s) = rankFeatures(len, meanER, meanNE, errorIndex, NEIndex, Y);
     maxRanks(:, :,s) = rankFeatures(len, maxER, maxNE, errorIndex, NEIndex, Y);
     minRanks(:, :,s) = rankFeatures(len, minER, minNE, errorIndex, NEIndex, Y);
%     varRanks(:, :,s) = rankFeatures(len, varER, varNE, errorIndex, NEIndex, Y);
%    slopeRanks(:, :,s) = rankFeatures(len, slopeER, slopeNE, errorIndex, NEIndex, Y);
    


%     [maxBest(s}] = findBestFeats(len, beforeTrig, afterTrig, maxRanks);
%     [minBest(s}] = findBestFeats(len, beforeTrig, afterTrig, minRanks);

%     [varBest(s)] = findBestFeats(len, beforeTrig, afterTrig, varRanks);
  
    %% Find Best
    
    
%     meanBest = zeros(3,3);
%     varBest = zeros(3,3);
%     minBest = zeros(3,3);
%     maxBest = zeros(3,3);
%     for i =1:3
%         [meanBest(1,i), meanBest(2,i)] = find(ismember(meanRanks, max(meanRanks(:))));
%         meanBest(3,i) = max(meanRanks(:));
%         meanRanks(meanBest(1,i), meanBest(2,i)) = 0;
%         
%         [varBest(1,i), varBest(2,i)] = find(ismember(varRanks, max(varRanks(:))));
%         varBest(3,i) = max(varRanks(:));
%         varRanks(varBest(1,i), varBest(2,i)) = 0;
%         
%         [minBest(1,i), minBest(2,i)] = find(ismember(minRanks, max(minRanks(:))));
%         minBest(3,i) = max(minRanks(:));
%         minRanks(minBest(1,i), minBest(2,i)) = 0;
%         
%         [maxBest(1,i), maxBest(2,i)] = find(ismember(maxRanks, max(maxRanks(:))));
%         maxBest(3,i) = max(maxRanks(:));
%         maxRanks(maxBest(1,i), maxBest(2,i)) = 0;
%     end
    
%     meanBest = max(meanRanks(:));
%     minBest = max(minRanks, 3);
%     maxBest = max(maxRanks, 3);
%     varBest = max(varRanks, 3);
    
%     [rowsOfMaxes colsOfMaxes] = find(A == maxValue);
end
%%
     [meanFeatures] = findBestFeats(len, beforeTrig, afterTrig, meanRanks);
     [maxFeatures] = findBestFeats(len, beforeTrig, afterTrig, maxRanks);
     [minFeatures] = findBestFeats(len, beforeTrig, afterTrig, minRanks);
%     [varFeatures] = findBestFeats(len, beforeTrig, afterTrig, varRanks);
%    [slopeFeatures] = findBestFeats(len, beforeTrig, afterTrig, slopeRanks);