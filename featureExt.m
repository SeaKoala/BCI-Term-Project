function [varER, meanER, maxER, minER, varNE, meanNE, maxNE, minNE, len] = featureExt(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event, fs, s_a)
    WSize = floor(WSize*fs);	    % length of each data frame
    nOlap = floor(Olap*WSize);   % overlap of successive frames, half of WSize
    hop = WSize-nOlap;	          % amount to advance for next data frame

    
    for channel = 1:16
        for i = 1:length(errorIndex)

            startSamp = event(errorIndex(i))-beforeTrig*fs;
            endSamp = event(errorIndex(i))+afterTrig*fs;
            trial = s_a(startSamp:endSamp,channel);

            % moving window
            nx = length(trial);	% length of input vector
            len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
            for frame = 1:len
                segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
                %figure;plot(segment);

                varER(frame,i,channel) = var(segment);

                [maxVal,maxLoc] = max(segment);
                maxER(frame,i,channel) = maxVal;
                maxLoc_ER(frame,i,channel) = maxLoc;

                [minVal,minLoc] = min(segment);
                minER(frame,i,channel) = minVal;
                minLoc_ER(frame,i,channel) = minLoc;

                meanER(frame,i,channel) = mean(segment);

            end         
        end
    end

    for channel = 1:16
        for f = 1:length(NEIndex)

            startSamp = event(NEIndex(f))-beforeTrig*fs;
            endSamp = event(NEIndex(f))+afterTrig*fs;
            trial = s_a(startSamp:endSamp,channel);

            % moving window
            nx = length(trial);	% length of input vector
            len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
            for frame = 1:len
                segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
                % figure;plot(segment);

                varNE(frame,f,channel) = var(segment);

                [maxVal,maxLoc] = max(segment);
                maxNE(frame,f,channel) = maxVal;
                maxLoc_NE(frame,f,channel) = maxLoc;

                [minVal,minLoc] = min(segment);
                minNE(frame,f,channel) = minVal;
                minLoc_NE(frame,f,channel) = minLoc;

                meanNE(frame,f,channel) = mean(segment);

            end         
        end
    end
end