%% Feature Selection


%% SNR sliding window

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

% Trials with error
for channel = 1:16
    for i = 1:length(errorIndex)

        startSamp = event.position(errorIndex(i))-beforeTrig*fs;
        endSamp = event.position(errorIndex(i))+afterTrig*fs;
        trial = s_a(startSamp:endSamp,channel);
        
        % move window with certain overlap, calc SNR value
        nx = length(trial);	            % length of input vector
        len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
        for j = 1:len
            segment = trial(((i-1)*hop+1):((i-1)*hop+WSize));
            snrTrial(j,i,channel) = snr(segment/gAvgRest);
        end
        
        
    end
end

