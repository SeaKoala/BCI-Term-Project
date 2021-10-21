%% plots

%% heatmap of fischer score equivilant
figure;
subplot(2,2,1)
heatmap(meanRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Mean")
subplot(2,2,2)
heatmap(varRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Var")
subplot(2,2,3)
heatmap(minRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Min")
subplot(2,2,4)
heatmap(maxRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Max")
%%
figure
subplot(1,2,1)
boxplot(maxER(4,:,14), "Er")
subplot(1,2,2)
boxplot(maxNE(4,:,14), "NE")






%%
% x = [maxNE(4,:,14), 1, length(NEIndex)); reshape(maxER(4,:,14), 1, length(errorIndex))];
