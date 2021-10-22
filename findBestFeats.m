%% Best Features
function [y, cnt_fr, unique_fr, cnt_ch, unique_ch] = findBestFeats(len, beforetrig, aftertrig, x)
y = [];
for(s =1:length(x(1,1,:)))
    for(f = 1:length(x(:,1,1)))
        for(c = 1:length(x(1,:,1)))
            if(x(f,c,s) >1)
                y(end+1,:) = [f;c;x(f,c,s)];
            end
        end
    end
end
if ~isempty(y)
    [cnt_fr, unique_fr] = hist(y(:,1),unique(y(:,1)));
    [cnt_ch, unique_ch] = hist(y(:,2),unique(y(:,2)));
end
end