%% Feature Selection

% Feature 1: amplitude 
% Feature 2: variance
% Feature 3: max
% Feature 4: min
% Feature 5: snr compared to gavg baseline
% Feature 6: theta bandpower 


channel = 4;

features_ER = mean(varVoltage_ER,2);
reatures_Ex = reshape(features_ER, [10,16]);

response = ones(16,1);





%% mdl = fscnca(X,Y)




