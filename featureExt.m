function [varER, meanER, maxER, minER, varNE, meanNE, maxNE, minNE, slopeER, slopeNE, parER, parNE, narER, narNE, tarER, tarNE, len] = featureExt(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event, fs, s_a)
    WSize = floor(WSize*fs);	    % length of each data frame
    nOlap = floor(Olap*WSize);   % overlap of successive frames, half of WSize
    hop = WSize-nOlap;	          % amount to advance for next data frame

    
    for channel = 1:16
        for i = 1:length(errorIndex)

            startSamp = event(errorIndex(i))-round(beforeTrig*fs);
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
                
                slopeER(frame,i,channel) = (segment(end) -segment(1))/length(segment);
                
                parER(frame,i,channel) = trapz(1/2*((segment) + abs(segment)));
%                 fun = @(x) 1/2*(s_a(x) - abs(s_a(x)));
                narER(frame,i,channel) = trapz(1/2*((segment) - abs(segment)));
                tarER(frame,i,channel) = parER( frame, i, channel)+narER(frame,i,channel);

            end         
        end
    end

    for channel = 1:16
        for f = 1:length(NEIndex)

            startSamp = event(NEIndex(f))-round(beforeTrig*fs)-1;
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
                
                slopeNE(frame,f,channel) = (segment(end) -segment(1))/length(segment);
                
                parNE(frame, f,channel) = trapz(1/2*((segment) + abs(segment)));
                narNE(frame,f,channel) = trapz(1/2*((segment) - abs(segment)));
                tarNE(frame,f,channel) = parNE(frame,f, channel)+narNE(frame,f,channel);


            end         
        end
    end
end