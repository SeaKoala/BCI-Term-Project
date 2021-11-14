% function [data, results] = featExt2(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event, fs, s_a)
function [meanFeat, maxFeat, minFeat, parFeat, narFeat, tarFeat, zcFeat, len] = featExt2(WSize, Olap, beforeTrig, afterTrig, errorIndex, NEIndex, event, fs, s_a)

    WSize = floor(WSize*fs);	    % length of each data frame
    nOlap = floor(Olap*WSize);   % overlap of successive frames, half of WSize
    hop = WSize-nOlap;	          % amount to advance for next data frame

    
    for channel = 1:16
        for i = 1:length(errorIndex)

            startSamp = event(errorIndex(i))-round(beforeTrig*fs);
            endSamp = event(errorIndex(i))+round(afterTrig*fs);
            trial = s_a(startSamp:endSamp,channel);
%             if(i == 12 && channel ==4)
%                 figure
%                 plot(trial);
%             end

            % moving window
            nx = length(trial);	% length of input vector
            len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
            for frame = 1:len
                segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
                %figure;plot(segment);
                [maxVal,maxLoc] = max(segment);
                maxER(i, frame,channel) = maxVal;
                [minVal,minLoc] = min(segment);
                minER(i, frame,channel) = minVal;
                meanER(i, frame,channel) = mean(segment);
                parER(i, frame,channel) = trapz(1/2*((segment) + abs(segment)));
                narER(i, frame,channel) = trapz(1/2*((segment) - abs(segment)));
                tarER(i, frame,channel) = parER(i, frame,channel)+narER(i, frame,channel);
                zcd = dsp.ZeroCrossingDetector;
                zcER(i, frame,channel) =cast(zcd(segment),'double');
            end         
        end
    end

    for channel = 1:16
        for f = 1:length(NEIndex)

            startSamp = event(NEIndex(f))-round(beforeTrig*fs);
            endSamp = event(NEIndex(f))+round(afterTrig*fs);
            trial = s_a(startSamp:endSamp,channel);
%             if(f == 12 && channel ==4)
%                 figure
%                 plot(trial);
%             end
            % moving window
            nx = length(trial);	% length of input vector
            len = fix((nx - (WSize-hop))/hop);	% length of output vector = total frames
            for frame = 1:len
                segment = trial(((frame-1)*hop+1):((frame-1)*hop+WSize));
                [maxVal,maxLoc] = max(segment);
                maxNE(f, frame,channel) = maxVal;
                [minVal,minLoc] = min(segment);
                minNE(f, frame, channel) = minVal;
                meanNE(f, frame,channel) = mean(segment);
                parNE(f, frame,channel) = trapz(1/2*((segment) + abs(segment)));
                narNE(f, frame,channel) = trapz(1/2*((segment) - abs(segment)));
                tarNE(f, frame,channel) = parNE(f, frame,channel)+narNE(f, frame,channel);
                zcNE(f, frame,channel) =cast(zcd(segment),'double');
            end         
        end
    end
    meanFeat = [meanER; meanNE];
    maxFeat = [maxER; maxNE];
    minFeat = [minER; minNE];
    narFeat = [narER; narNE];
    parFeat = [parER; parNE];
    tarFeat = [tarER; tarNE];
    zcFeat = [zcER; zcNE];
end
