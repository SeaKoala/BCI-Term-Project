%% Feature Extraction 


%% Sliding window analysis parameters

% Sliding window parameters
% (WSize: 50,100,300ms) seconds -> (WSize: 0.05, 0.1, 0.3)
% (Olap: 0,0.25,0.75)
WSize = 0.1; % window size in s
Olap = 0; % overlap percentage
WSize = floor(WSize*fs);	    % length of each data frame
nOlap = floor(Olap*WSize);   % overlap of successive frames, half of WSize
hop = WSize-nOlap;	          % amount to advance for next data frame

% Set amount of sample to be extracted
beforeTrig = 0;
afterTrig = 1;

%% Trials with error
for channel = 1:16
    for i = 1:length(errorIndex)

        startSamp = event.position(errorIndex(i))-beforeTrig*fs;
        endSamp = event.position(errorIndex(i))+afterTrig*fs;
        trial = s_a(startSamp:endSamp,channel);
        
        % moving window
        nx = length(trial);	% length of input vector
        len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
        for frame = 1:len
            segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
            %figure;plot(segment);
            
            varVoltage_ER(frame,i,channel) = var(segment);
            
            [maxVal,maxLoc] = max(segment);
            maxVoltage_ER(frame,i,channel) = maxVal;
            maxLoc_ER(frame,i,channel) = maxLoc;
            
            [minVal,minLoc] = min(segment);
            minVoltage_ER(frame,i,channel) = minVal;
            minLoc_ER(frame,i,channel) = minLoc;
            
            meanVoltage_ER(frame,i,channel) = mean(segment);
            
        end         
    end
end

%%  Trials with NO error

for channel = 1:16
    for i = 1:length(NEIndex)

        startSamp = event.position(NEIndex(i))-beforeTrig*fs;
        endSamp = event.position(NEIndex(i))+afterTrig*fs;
        trial = s_a(startSamp:endSamp,channel);
        
        % moving window
        nx = length(trial);	% length of input vector
        len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
        for frame = 1:len
            segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
            % figure;plot(segment);
            
            varVoltage_NE(frame,i,channel) = var(segment);
            
            [maxVal,maxLoc] = max(segment);
            maxVoltage_NE(frame,i,channel) = maxVal;
            maxLoc_NE(frame,i,channel) = maxLoc;
            
            [minVal,minLoc] = min(segment);
            minVoltage_NE(frame,i,channel) = minVal;
            minLoc_NE(frame,i,channel) = minLoc;
            
            meanVoltage_NE(frame,i,channel) = mean(segment);
 
        end         
    end
end

%% Sliding grand average SNR
% 
% % Why are all channels the same snr??
% 
% % baseline: no error
% for channel = 1:16
%     % moving window
%     nx = length(GavgNE);	% length of input vector
%     len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
%     for frame = 1:len
%         segment_ER = GavgError(((frame-1)*hop+1):((frame-1)*hop+WSize));
%         segment_NE = GavgNE(((frame-1)*hop+1):((frame-1)*hop+WSize));
%         gavgSNR(frame,channel) = snr((segment_ER),(segment_NE));    
%     end
% end
