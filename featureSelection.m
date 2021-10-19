%% Feature Selection

%% Feature: mean voltage

for channel = 1:16
    for frame = 1:len
        for trial = 1:length(errorIndex)
           featMatrix_mean(trial,channel*len-len+frame) = meanVoltage_ER(frame,trial,channel);
        end
        for trial = 1:length(NEIndex)        
            featMatrix_mean(trial+length(errorIndex),channel*len-len+frame) = meanVoltage_NE(frame,trial,channel);      
        end
    end  
end

y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];

%% Feature ranking
mdl = fscnca(featMatrix_mean,y)
figure;
plot(mdl.FeatureWeights,'ro')
grid on
xlabel('Feature index')
ylabel('Feature weight')
title("weights of mean")
%% Heatmap
heat = reshape(mdl.FeatureWeights,[len,16]);
figure;
heatmap(heat);
xlabel('Frame')
title("weights of mean")

%% Feature: var voltage

for channel = 1:16
    for frame = 1:len
        for trial = 1:length(errorIndex)
           featMatrix_var(trial,channel*len-len+frame) = varVoltage_ER(frame,trial,channel);
        end
        for trial = 1:length(NEIndex)        
            featMatrix_var(trial+length(errorIndex),channel*len-len+frame) = varVoltage_NE(frame,trial,channel);      
        end
    end  
end

y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];

%% Feature ranking
mdl = fscnca(featMatrix_var,y)
figure;
plot(mdl.FeatureWeights,'ro')
grid on
xlabel('Feature index')
ylabel('Feature weight')
title("weights of var")

%% Heatmap
heat = reshape(mdl.FeatureWeights,[len,16]);
figure;
heatmap(heat);
xlabel('Frame')
title("weights of var")

%% Feature: max voltage

for channel = 1:16
    for frame = 1:len
        for trial = 1:length(errorIndex)
           featMatrix_max(trial,channel*len-len+frame) = maxVoltage_ER(frame,trial,channel);
        end
        for trial = 1:length(NEIndex)        
            featMatrix_max(trial+length(errorIndex),channel*len-len+frame) = maxVoltage_NE(frame,trial,channel);      
        end
    end  
end

y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];

%% Feature ranking
mdl = fscnca(featMatrix_max,y)
figure;
plot(mdl.FeatureWeights,'ro')
grid on
xlabel('Feature index')
ylabel('Feature weight')
title("weights of max")

%% Heatmap
heat = reshape(mdl.FeatureWeights,[len, 16]);
figure;
heatmap(heat);
xlabel('Frame')
title("weights of max")

%% Feature: min voltage

for channel = 1:16
    for frame = 1:len
        for trial = 1:length(errorIndex)
           featMatrix_min(trial,channel*len-len+frame) = minVoltage_ER(frame,trial,channel);
        end
        for trial = 1:length(NEIndex)        
            featMatrix_min(trial+length(errorIndex),channel*len-len+frame) = minVoltage_NE(frame,trial,channel);      
        end
    end  
end

y = [ones(length(errorIndex),1);zeros(length(NEIndex),1)];

%% Feature ranking
mdl = fscnca(featMatrix_min,y)
figure;
plot(mdl.FeatureWeights,'ro')
grid on
xlabel('Feature index')
ylabel('Feature weight')
title("weights of min")

%% Heatmap
heat = reshape(mdl.FeatureWeights,[len,16]);
figure;
heatmap(ranks);
xlabel('Channels')
ylabel('frame')
title("weights of mean")
