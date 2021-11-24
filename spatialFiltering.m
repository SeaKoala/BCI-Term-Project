%% Spatial Filtering

function [signal_CSP] = spatialFiltering(signal,fs,event,errorIndex,NEIndex)

%% CAR - Common Avg Reference
    channels = [1:16];
    for chan = 1:16  
        currentChanList =  channels(channels~=chan);  
        signal(:,chan) = signal(:,chan) - mean(signal(:,currentChanList),2);      
    end

    signal_CSP = signal;
% %% CSP 
% 
% beforeTrig = 0; % seconds of signal to be recorded before start of trial
% afterTrig = 1; % seconds of signal after trial start
% 
% % error class
% for channel = 1:16
%     for i = 1:length(errorIndex)
%         startSamp = event.position(errorIndex(i))-beforeTrig*fs;
%         endSamp = event.position(errorIndex(i))+afterTrig*fs;
%         trial_error(channel,:,i) = signal(startSamp:endSamp,channel);
%     end
% end
% 
% % NO error class
% for channel = 1:16
%     for i = 1:length(NEIndex)
%         startSamp = event.position(NEIndex(i))-beforeTrig*fs;
%         endSamp = event.position(NEIndex(i))+afterTrig*fs;
%         trial_NoError(channel,:,i) = signal(startSamp:endSamp,channel);
%     end
% end
% 
% 
% GAVG_error(:,:) = mean(trial_error,3);
% GAVG_NoError(:,:) = mean(trial_NoError,3);
% 
% % Perform CSP on grand average of classes to get filter weights
% [W, lambda, A] = csp(GAVG_error,GAVG_NoError);
% 
% % Apply filter to raw signal for spatial filtering
% % X_csp = W'*X;
% 
% signal_CSP = W'*signal';
% signal_CSP = signal_CSP';
% 
% end

