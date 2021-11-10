%% Rank and Plot
% uses FSCNCA to rank features then plots their weights and a heatmap

function [ranks] = rankFeatures(len, feature, Y)
    for channel = 1:16
        for frame = 1:len
            for trial = 1:length(Y)
               featMatrix(trial,channel*len-len+frame) = feature(trial,frame, channel);
            end
%             for trial = 1:length(NEIndex)        
%                 featMatrix(trial+length(errorIndex),channel*len-len+frame) = featureNE(trial, frame,channel);      
%             end
        end  
    end

    mdl = fscnca(featMatrix,Y);
    ranks = reshape(mdl.FeatureWeights,[len,16]);
end
