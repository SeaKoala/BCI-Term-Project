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