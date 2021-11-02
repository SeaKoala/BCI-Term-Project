%% Spatial Filtering

function [car_signal] = spatialFiltering(signal,fs,event,errorIndex,NEIndex)

%% CAR - Common Avg Reference
    channels = [1:16];
    for chan = 1:16  
        currentChanList =  channels(channels~=chan);  
        car_signal(:,chan) = signal(:,chan) - mean(signal(:,currentChanList),2);      
    end

    
%% CSP 

beforeTrig = 0; % seconds of signal to be recorded before start of trial
afterTrig = 1; % seconds of signal after trial start

% error class
for channel = 1:16
    for i = 1:length(errorIndex)
        startSamp = event.position(errorIndex(i))-beforeTrig*fs;
        endSamp = event.position(errorIndex(i))+afterTrig*fs;
        trial_error(chan,:,i) = signal(startSamp:endSamp,channel);
    end
end

% NO error class
for channel = 1:16
    for i = 1:length(NEIndex)
        startSamp = event.position(NEIndex(i))-beforeTrig*fs;
        endSamp = event.position(NEIndex(i))+afterTrig*fs;
        trial_NoError(chan,:,i) = signal(startSamp:endSamp,channel);
    end
end



for trial = 1:length(errorIndex)
    [W, lambda, A] = csp(trial_error(:,:,trial), trial_NoError(:,:,trial));
    weights(:,:,trial) = W;
end


