%% plots

 %% Topoplots for spatial filtering evalution

figure;
sgtitle("SNR")

subplot(1,4,1)
topoplot(sigRatio_preSpatial, chanlocs16)
title("No spatial filtering");
hcb=colorbar;
hcb.Title.String = "SNR";
subplot(1,4,2)
topoplot(sigRatio_postCar, chanlocs16)
hcb=colorbar;
hcb.Title.String = "SNR";
title("CAR");
subplot(1,4,3)
topoplot(sigRatio_postCSP, chanlocs16)
title("CSP");
hcb=colorbar;
hcb.Title.String = "SNR";
subplot(1,4,4)
topoplot(sigRatio_postBoth, chanlocs16)
title("CAR & CSP");
hcb=colorbar;
hcb.Title.String = "SNR";












%%
figure
stem(mdl.FeatureWeights)
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
%     sgtitle(path{1})
%     subplot(1,3,s)
    figure
    hold on
    plot(GavgNE(:,5))
    plot(GavgError(:,5))
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
    
    %% plot histogram of best features
figure
sgtitle("offline only, .25 Wsize, 0 Olap, CAR, thresh = 1")
subplot(3,3,1)
heatmap(parSum)
title("Sums of mean features")
subplot(3,3,2)
heatmap(parCount)
title("Count of mean features")
subplot(3,3,3)
heatmap(parMean)
title("Mean of mean features")

subplot(3,3,4)
heatmap(narSum)
title("Sums of max features")
subplot(3,3,5)
heatmap(narCount)
title("Count of max features")
subplot(3,3,6)
heatmap(narMean)
title("Mean of max features")

subplot(3,3,7)
heatmap(tarSum)
title("Sums of min features")
subplot(3,3,8)
heatmap(tarCount)
title("Count of min features")
subplot(3,3,9)
heatmap(tarMean)
title("Mean of min features")
%% Topoplots

    figure
    sgtitle("Max SUM, Offline Only, 1/4 Wsize, 0 Olap, BOTH, thresh = .8");
    for f=1:len
    subplot(2,2,f);
    topoplot(maxSum(f,:), chanlocs16)
    colorbar
    end
    
    figure
    sgtitle("min SUM, Offline Only, 1/4 Wsize, 0 Olap, BOTH, thresh = .8");
    for f=1:len
    subplot(2,2,f);
    topoplot(minSum(f,:), chanlocs16)
    colorbar
    end


%     t = s-9;
%     subplot(3,2,2*t-1)
%     sgtitle("Mean of time[300-400]ms")
%     title(path{s} + ":   ER");
%     topoplot(mean(meanER(4,:,:)), chanlocs16);
%     colorbar
%     subplot(3,2,2*t)
%     title(path{s} + ":   NE");
%     topoplot(mean(meanNE(4,:,:)), chanlocs16);
%     colorbar

%% Plot feature weights

%% Sub 1
offMean = 1.2147;
offeMin = 1.1503;
offMax = 1.3688;
s2Mean = 0.21282;
s2Min= 0.7329;
s2Max= 0.7481;
s3Mean= 1.1956;
s3Min=0.4247;
s3Max=0.4692 ;

figure;
x = categorical({'Offline','S2','S3'});
x = reordercats(x,{'Offline','S2','S3'});
y_sub1 = [offMean,offeMin,offMax; s2Mean,s2Min,s2Max; s3Mean,s3Min,s3Max];
bar(x,y_sub1);
legend({'mean_f_r6_c_h16','min_f_r1_c_h14','max_f_r4_c_h14'});
title("Subject1 Feature Weights")
ylabel("fscnca feature weight")


%% Sub 2
offMean = 1.2155;
offeMin = 1.1280;
offMax = 1.5830;
s2Mean =0.3788;
s2Min= 0.4374;
s2Max= 1.8170e-07;
s3Mean= 6.4987e-07;
s3Min=2.8547e-06;
s3Max=0.2815;

figure;
x = categorical({'Offline','S2','S3'});
x = reordercats(x,{'Offline','S2','S3'});
y_sub1 = [offMean,offeMin,offMax; s2Mean,s2Min,s2Max; s3Mean,s3Min,s3Max];
bar(x,y_sub1);
legend({'mean_f_r2_c_h10','min_f_r5_c_h7','max_f_r5_c_h8'});
title("Subject2 Feature Weights")
ylabel("fscnca feature weight")


%% Sub 4
offMean = 1.3108;
offeMin = 0.9819;
offMax = 1.1638;
s2Mean =3.3223e-06;
s2Min= 0.5517;
s2Max= 3.5891e-09;
s3Mean= 0.7947;
s3Min=0.9401;
s3Max=1.0197;

figure;
x = categorical({'Offline','S2','S3'});
x = reordercats(x,{'Offline','S2','S3'});
y_sub1 = [offMean,offeMin,offMax; s2Mean,s2Min,s2Max; s3Mean,s3Min,s3Max];
bar(x,y_sub1);
legend({'mean_f_r5_c_h8','min_f_r5_c_h4','max_f_r2_c_h2'});
title("Subject4 Feature Weights")
ylabel("fscnca feature weight")

%% Sub 5
offMean = 1.4387;
offeMin = 1.2251;
offMax = 1.2689;
s2Mean =0.1121;
s2Min= 0.2199;
s2Max= 7.7887e-07 ;
s3Mean= 1.957e-08;
s3Min=1.2234e-06;
s3Max=1.0919 ;

figure;
x = categorical({'Offline','S2','S3'});
x = reordercats(x,{'Offline','S2','S3'});
y_sub1 = [offMean,offeMin,offMax; s2Mean,s2Min,s2Max; s3Mean,s3Min,s3Max];
bar(x,y_sub1);
legend({'mean_f_r4_c_h1','min_f_r6_c_h9','max_f_r2_c_h8'});
title("Subject5 Feature Weights")
ylabel("fscnca feature weight")
%%
C = confusionmat(results,yfit)


% figure
% sgtitle("Sub 1 Only, 1/4 Wsize, 0 Olap, BOTH, thresh = .8");
% heats(meanSum, meanCount, meanMean, maxSum, maxCount, maxMean, minSum, minCount, minMean);

function heats(meanSum, meanCount, meanMean, maxSum, maxCount, maxMean, minSum, minCount, minMean)
    subplot(3,3,1)
    heatmap(meanSum)
    title("Sums of mean features")
    subplot(3,3,2)
    heatmap(meanCount)
    title("Count of mean features")
    subplot(3,3,3)
    heatmap(meanMean)
    title("Mean of mean features")

    subplot(3,3,4)
    heatmap(maxSum)
    title("Sums of max features")
    subplot(3,3,5)
    heatmap(maxCount)
    title("Count of max features")
    subplot(3,3,6)
    heatmap(maxMean)
    title("Mean of max features")

    subplot(3,3,7)
    heatmap(minSum)
    title("Sums of min features")
    subplot(3,3,8)
    heatmap(minCount)
    title("Count of min features")
    subplot(3,3,9)
    heatmap(minMean)
    title("Mean of min features")
end

