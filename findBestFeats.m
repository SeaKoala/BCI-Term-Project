%% Best Features
function [sums, counts, means] = findBestFeats(len, beforetrig, aftertrig, x)
thresh = 1; %% -----------Threshold-----------

%% find sum of FS score for all features above threshold
 sums = sum(x,3);
 %% find count of FS score for all features above threshold
 counts = zeros(len,16);
 for(f=1:len)
   for(c=1:16)
      counts(f,c) = length(find(x(f,c,:)>1));
   end
 end   
 %% find Mean of FS score for all features above threshold
 means= mean(x, 3);
end