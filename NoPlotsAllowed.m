%% No Plots Allowed
clc
clear
close all
path = {'ErrPSpeller/Subject1/Offline', 'ErrPSpeller/Subject1/S2','ErrPSpeller/Subject1/S3', 'ErrPSpeller/Subject2/Offline', 'ErrPSpeller/Subject2/S2','ErrPSpeller/Subject2/S3', 'ErrPSpeller/Subject4/Offline', 'ErrPSpeller/Subject4/S2','ErrPSpeller/Subject4/S3', 'ErrPSpeller/Subject5/Offline', 'ErrPSpeller/Subject5/S2','ErrPSpeller/Subject5/S3'};
% path = 'ErrPSpeller/Subject1/Offline';

%% for each subject
for s=1:length(path)
% for s = 10
    [signals, event] = loadData(path{s});
    signals = signals(:, 1:16);
    fs = 512;
    load chanlocs16.mat chanlocs16
    %% Fz, FC3, FC1, FCz, FC2, FC4, C3, C1, Cz, C2, C4, CP3, CP1, CPz, CP2, CP4
    %% Filtering
    f_a = [1 10]; % alpha band
    f_b = [18 22]; % beta band
    N = 5; % filter order
    [A1, A2] = butter(N, [f_a(1) f_a(2)]*2 /fs);
    % [B1, B2] = butter(N, [f_b(1) f_b(2)]*2 /fs);
    s_a = filter(A1, A2,signals); 
    % s_b = filter(B1, B2,signals); 

    rectSignal = s_a(:,:).^2; % signal power

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

    %% Feature Extraction
    WSize = .05;
    Olap = 0;
    [varER, meanER, maxER, minER, varNE, meanNE, maxNE, minNE, len] = featureExt(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event.position, fs, s_a);

    %% feature ranking
    Y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];
    meanRanks = rankFeatures(len, meanER, meanNE, errorIndex, NEIndex, Y);
    maxRanks = rankFeatures(len, maxER, maxNE, errorIndex, NEIndex, Y);
    minRanks = rankFeatures(len, minER, minNE, errorIndex, NEIndex, Y);
    varRanks = rankFeatures(len, varER, varNE, errorIndex, NEIndex, Y);
    
   %%
   figure;
   sgtitle(path{s});
    subplot(2,2,1)
    heatmap(meanRanks);
    xlabel('Channels')
    ylabel('frame')
    title("weights of Mean")
    subplot(2,2,2)
    heatmap(varRanks);
    xlabel('Channels')
    ylabel('frame')
    title("weights of Var")
    subplot(2,2,3)
    heatmap(minRanks);
    xlabel('Channels')
    ylabel('frame')
    title("weights of Min")
    subplot(2,2,4)
    heatmap(maxRanks);
    xlabel('Channels')
    ylabel('frame')
    title("weights of Max")
end