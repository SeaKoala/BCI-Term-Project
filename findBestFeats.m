%% Best Features
function [y, sums, counts, means] = findBestFeats(len, beforetrig, aftertrig, x)
thresh = .5;
y = zeros(len, 16);
frch = zeros(len, 16);
for(s =1:length(x(1,1,:)))
    for(f = 1:length(x(:,1,1)))
        for(c = 1:length(x(1,:,1)))
            if(x(f,c,s) >thresh)
                if(y(f,c,1)==0)
                    y(f,c,1) = x(f,c,s);
                    
%                     y(end+1,:) = [f;c;x(f,c,s)];
%                     frch(f,c)=1;
%                     y(
                end
                if(y(f,c,1)~=0)
                    y(f,c, end+1) = [x(f,c,s)];
                end
            end
        end
    end
end

%% find sum of FS score for all features above threshold
 sums = sum(y,3);
 %% find count of FS score for all features above threshold
 for(f=1:len)
   for(c=1:16)
      counts(f,c) = nnz(y(f,c,:));
   end
 end   
 %% find Mean of FS score for all features above threshold
for(f=1:len)
   for(c=1:16)
       if(sums(f,c) ~= 0)
           means(f,c) = sums(f,c)/counts(f,c);
       else
           means(f,c) = 0;
   end
end   

% 
%   for(f=1:len)
%    for(c=1:16)
%       means(f,c) = mean(y(f,c,:));
%    end
% end   
            

% if ~isempty(y)
%     [cnt_fr, unique_fr] = hist(y(:,1),unique(y(:,1)));
%     [cnt_ch, unique_ch] = hist(y(:,2),unique(y(:,2)));
% end
end

% if frame and channel combo arrives, check if greater than thresh(1), if
% not seen before add it to Y as new entry, flip frame channel flag to
% seen, 