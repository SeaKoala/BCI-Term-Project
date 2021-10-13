%% HW2
path = 'ErrPSpeller\Subject1\Offline';
[signals, event] = loadData(path);
% [signal,H] = sload('ad4_raser_offline_offline_171110_170617.gdf');
signals = signals(:, 1:16);
fs = 512;

%% Filtering
f_a = [1 10]; % alpha band
f_b = [18 22]; % beta band
N = 5; % filter order
[A1, A2] = butter(N, [f_a(1) f_a(2)]*2 /fs);
[B1, B2] = butter(N, [f_b(1) f_b(2)]*2 /fs);
s_a = filter(A1, A2,signals); 
s_b = filter(B1, B2,signals); 

figure
hold on
plot((1:length(signals))./fs, signals)
plot((1:length(s_a))./fs, s_a)
title("Alpha on Raw")
hold off

%% Power

h = spectrum.welch; % creates the Welch spectrum estimator

% ext_prox=psd(h,emg(time(4):time(5), 1),'Fs',fs);
% ext_dist=psd(h,emg(time(4):time(5), 2),'Fs',fs);
% flx_prox=psd(h,emg(time(4):time(5), 3),'Fs',fs);
noError=psd(h,emg(time(5):time(6), 4),'Fs',fs); 
rest = psd(h,signals(:,4),'Fs',fs);
figure('units','normalized','Position',[0.2,0.65,0.3,0.3])
hold on
% plot(ext_prox);
% plot(ext_dist);
% plot(flx_prox);
plot(flx_dist);
plot(rest);
temp =get(gca);
temp.Children(1).Color = 'r'; %rest
temp.Children(2).Color = 'b'; %flx_dist
hold off
legend( 'Distal Flexor', 'Rest');
figure
hold on
plot(1:length(signals(:,1)), signals(:,1))
% plot((1:length(s_a))./fs, s_a)
title("Alpha on Raw")
hold off

%% Grouping
errorIndex = [];
NEIndex = [];
for i=1:length(event.type)
    if(event.type(i) == 1)
        errorIndex(end+1) = i; 
    else
        NEIndex(end+1) = i;
    end
end
%% sliding Window
avg = 10; % average window
A_mavg = (filter(ones(1, avg*fs)/avg/fs, 1, s_a));
B_mavg = (filter(ones(1, avg*fs)/avg/fs, 1, s_b));

figure
subplot(2,1,1)
plot(A_mavg(:))
title("Moving Average of Alpha Signal")
% plot((1:length(GavgA))./fs, GavgA)

%% Grand Average
GavgA = zeros(fs*(extrastart+extraend),1);
GavgB = zeros(fs*(extrastart+extraend),1);
for(i=1:length(trigger))
    for(j = 1:2000)
        GavgA(j) = GavgA(j)+ s_a(trigger2(i,2)-extrastart*fs+j);
        GavgB(j) = GavgB(j)+ s_b(trigger2(i,2)-extrastart*fs+j);
    end 
end
length(trigger)
GavgA = GavgA./length(trigger);
GavgB = GavgB./length(trigger);

figure
subplot(2,1,1)
plot(GavgA(:))
title("Grand Average of Alpha Signal")
% plot((1:length(GavgA))./fs, GavgA)

subplot(2,1,2)
plot(GavgB(:))
title("Grand Average of Beta Signal")