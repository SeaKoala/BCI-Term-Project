 %% SNR calculations -> Run Gavg first
    
    for chan = 1:16
        sig = GavgError(:,chan);
        noise = GavgNE(:,chan);
        sigRatio_preSpatial(chan) = snr(sig,noise);   
    end
    %% 
    for chan = 1:16
        sig = GavgError(:,chan);
        noise = GavgNE(:,chan);
        sigRatio_postCar(chan) = snr(sig,noise);   
    end
    %%
    for chan = 1:16
        sig = GavgError(:,chan);
        noise = GavgNE(:,chan);
        sigRatio_postCSP(chan) = snr(sig,noise);   
    end
    %%
    for chan = 1:16
        sig = GavgError(:,chan);
        noise = GavgNE(:,chan);
        sigRatio_postBoth(chan) = snr(sig,noise);   
    end
   