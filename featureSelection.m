%% Feature Selection

% Feature 1: amplitude 
% Feature 2: variance
% Feature 3: max
% Feature 4: min
% Feature 5: snr compared to gavg baseline
% Feature 6: theta bandpower 


featMatrix = [500, 10*1*1]; % number of trials, frames * channels * features types
y= [zeros(406,1);ones(94,1)];
for channel = 1:1
        for frame = 1:len
            for trial = 1:length(NEIndex)
            featMatrix(trial, frame)= maxVal_NE(len, trial, 1);
            end
            for trial = 1:length(errorIndex)
                featMatrix(trial+length(NEIndex), frame)= maxVal_ER(len, trial, 1);
            end
    end
end





%% mdl = fscnca(X,Y)

mdl = fscnca(featMatrix,y)


