%% plots

%% heatmap of fischer score equivilant
   figure;
   sgtitle(path{s});
    subplot(2,2,1)
    h=heatmap(meanRanks);
    h.Colormap = hot;
    xlabel('Channels')
    ylabel('frame')
    title("weights of Mean")
    subplot(2,2,2)
    h= heatmap(varRanks);
        h.Colormap = hot;
    xlabel('Channels')
    ylabel('frame')
    title("weights of Var")
    subplot(2,2,3)
    h = heatmap(minRanks);
        h.Colormap = hot;
    xlabel('Channels')
    ylabel('frame')
    title("weights of Min")
    subplot(2,2,4)
    h = heatmap(maxRanks);
        h.Colormap = hot;
    xlabel('Channels')
    ylabel('frame')
    title("weights of Max")


%% Grand Average
    sgtitle(path{1})
    subplot(1,3,s)
    hold on
    plot(GavgNE(:,4))
    plot(GavgError(:,4))
    title(path{s});
    hold off


%% Box Plots
figure
sgtitle(path{s})
    subplot(1,3,1)
    x = [reshape(meanNE(4,:,1), length(NEIndex), 1); reshape(meanER(4,:,1), length(errorIndex), 1)];
    g1 = repmat({'NE'},length(NEIndex),1);
    g2 = repmat({'ER'},length(errorIndex),1);
    g = [g1; g2];
    m = [mean(meanNE(4,:,1)); mean(meanER(4,:,1))];
    hold on
    boxplot(x, g)
    plot(m, '*')
    hold off
    title('Mean Fr 4, Ch 1');

    subplot(1,3,2)
    x = [reshape(minNE(6,:,9), length(NEIndex), 1); reshape(minER(6,:,9), length(errorIndex), 1)];
    g1 = repmat({'NE'},length(NEIndex),1);
    g2 = repmat({'ER'},length(errorIndex),1);
    g = [g1; g2];
    m = [mean(minNE(6,:,9)); mean(minER(6,:,9))];
    hold on
    boxplot(x, g)
    plot(m, '*')
    hold off
    title('Min Fr 6, Ch 9');
    
    subplot(1,3,3)
    x = [reshape(maxNE(2,:,8), length(NEIndex), 1); reshape(maxER(2,:,8), length(errorIndex), 1)];
    g1 = repmat({'NE'},length(NEIndex),1);
    g2 = repmat({'ER'},length(errorIndex),1);
    g = [g1; g2];
    m = [mean(maxNE(2,:,8)); mean(maxER(2,:,8))];
    hold on
    boxplot(x, g)
    plot(m, '*')
    hold off
    title('Max Fr 2, Ch 8');

%% Topoplots
    t = s-9;
    subplot(3,2,2*t-1)
    sgtitle("Mean of time[300-400]ms")
    title(path{s} + ":   ER");
    topoplot(mean(meanER(4,:,:)), chanlocs16);
    colorbar
    subplot(3,2,2*t)
    title(path{s} + ":   NE");
    topoplot(mean(meanNE(4,:,:)), chanlocs16);
    colorbar

