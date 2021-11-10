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
for s=[1,2,3]
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
    signals = spatialFiltering(signals,fs,event,errorIndex,NEIndex);
    
    f_a = [1 10]; % alpha band
    f_b = [18 22]; % beta band
    N = 5; % filter order
    [A1, A2] = butter(N, [f_a(1) f_a(2)]*2 /fs);
    % [B1, B2] = butter(N, [f_b(1) f_b(2)]*2 /fs);
    s_a = filtfilt(A1, A2,signals);
    % s_b = filter(B1, B2,signals);
    
    rectSignal = s_a(:,:).^2; % signal power
    %% Grand Average
    beforeTrig = 0; % seconds of signal to be recorded before start of trial
    afterTrig = 1; % seconds of signal after trial start
    
    %     GavgError = zeros(round(fs*(beforeTrig+afterTrig)),16);
    %     GavgNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
    %     GavgRectError = zeros(round(fs*(beforeTrig+afterTrig)),16);
    %     GavgRectNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
    %     for(c =1:16) % for every channel
    %         for(i=1:length(errorIndex)) % for every trial in error trial index array
    %             for(j = 1:length(GavgError)) % for length of trial (endsample - start sample)
    %                 GavgError(j,c) = GavgError(j)+ s_a(event.position(errorIndex(i))-round(beforeTrig*fs)+j, c);
    %                 GavgRectError(j,c) = GavgRectError(j)+ rectSignal(event.position(errorIndex(i))-round(beforeTrig*fs)+j, c);
    %             end
    %         end
    %         for(i=1:length(NEIndex))
    %             for(j = 1:length(GavgNE))
    %                 GavgNE(j,c) = GavgNE(j)+ s_a(event.position(NEIndex(i))-round(beforeTrig*fs)+j, c);
    %                 GavgRectNE(j,c) = GavgRectNE(j)+ rectSignal(event.position(NEIndex(i))-round(beforeTrig*fs)+j, c);
    %             end
    %         end
    %         GavgError(:,c) = GavgError(:,c)./length(errorIndex);
    %         GavgNE(:,c) = GavgNE(:,c)./length(NEIndex);
    %         GavgRectError(:,c) = GavgRectError(:,c)./length(errorIndex);
    %         GavgRectNE(:,c) = GavgRectNE(:,c)./length(NEIndex);
    %     end
    % %     figure
    % %     for(i=1:16)
    % %         subplot(4,4,i)
    % %         hold on
    % %         plot(GavgError(:,i))
    % %         plot(GavgNE(:,i))
    % %         hold off
    % %     end
    % %     legend("Er", "NE");
    %
    %     i=0;
    
    %% Feature Extraction
    WSize = .25;
    Olap = .5;
    Y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];
    [meanFeat, maxFeat, minFeat, parFeat, narFeat, tarFeat, zcFeat, len] = featExt2(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event.position, fs, s_a);
    % [varER, meanER, maxER, minER, varNE, meanNE, maxNE, minNE, slopeER, slopeNE, parER, parNE, narER, narNE, tarER, tarNE, len] = featureExt(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event, fs, s_a)
    
    dataNew = [...
        reshape(maxFeat, length(Y),len*16), ...
        reshape(minFeat, length(Y),len*16), ...
        reshape(meanFeat, length(Y),len*16), ...
        reshape(tarFeat, length(Y),len*16)...
%         reshape(parFeat, length(Y),len*16), ...
%         reshape(narFeat, length(Y),len*16), ...

        %         reshape(zcFeat, length(Y),len*16)...
        ];
    
    data = [data; dataNew];
    results = [results; Y];
    for(i=1:length(results))
        if(results(i) == 1)
            results2(i) ="Error";
        else
            results2(i) = "No Error";
        end
    end
    results2 = results2';
    
    
    %% feature ranking
    
    %     meanRanks(:, :,s) = rankFeatures(len, meanFeat, Y);
    %     parRanks(:, :,s) = rankFeatures(len, parFeat, Y);
    %     narRanks(:, :,s) = rankFeatures(len, narFeat, Y);
    %     tarRanks(:, :,s) = rankFeatures(len, tarFeat, Y);
    %     maxRanks(:, :,s) = rankFeatures(len, maxFeat, Y);
    %     minRanks(:, :,s) = rankFeatures(len, minFeat, Y);
end
%%
% mdl = fscnca(data,results2);
results =0;
% ranks = reshape(mdl.FeatureWeights,[len,16]);
%% Find features with FS score > 1
% [meanSum, meanCount, meanMean] = findBestFeats(len, beforeTrig, afterTrig, meanRanks);
% [maxSum, maxCount, maxMean] = findBestFeats(len, beforeTrig, afterTrig, maxRanks);
% [minSum, minCount, minMean] = findBestFeats(len, beforeTrig, afterTrig, minRanks);
% [parSum, parCount, parMean] = findBestFeats(len, beforeTrig, afterTrig, parRanks);
% [narSum, narCount, narMean] = findBestFeats(len, beforeTrig, afterTrig, narRanks);
% [tarSum, tarCount, tarMean] = findBestFeats(len, beforeTrig, afterTrig, tarRanks);
