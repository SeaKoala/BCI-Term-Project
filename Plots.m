%% plots

%% heatmap of fischer score equivilant
figure;
heatmap(meanRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Mean")

figure;
heatmap(varRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Var")

figure;
heatmap(minRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Min")

figure;
heatmap(maxRanks);
xlabel('Channels')
ylabel('frame')
title("weights of Max")