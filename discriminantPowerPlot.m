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

