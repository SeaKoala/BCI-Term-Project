 %% Grand Average       
        GavgError = zeros(round(fs*(beforeTrig+afterTrig)),16);
        GavgNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
        GavgRectError = zeros(round(fs*(beforeTrig+afterTrig)),16);
        GavgRectNE = zeros(round(fs*(beforeTrig+afterTrig)),16);
        for(c =1:16) % for every channel
            for(i=1:length(errorIndex)) % for every trial in error trial index array
                for(j = 1:length(GavgError)) % for length of trial (endsample - start sample)
                    GavgError(j,c) = GavgError(j)+ s_a(event.position(errorIndex(i))-round(beforeTrig*fs)+j, c);
                    GavgRectError(j,c) = GavgRectError(j)+ rectSignal(event.position(errorIndex(i))-round(beforeTrig*fs)+j, c);
                end
            end
            for(i=1:length(NEIndex))
                for(j = 1:length(GavgNE))
                    GavgNE(j,c) = GavgNE(j)+ s_a(event.position(NEIndex(i))-round(beforeTrig*fs)+j, c);
                    GavgRectNE(j,c) = GavgRectNE(j)+ rectSignal(event.position(NEIndex(i))-round(beforeTrig*fs)+j, c);
                end
            end
            GavgError(:,c) = GavgError(:,c)/length(errorIndex);
            GavgNE(:,c) = GavgNE(:,c)/length(NEIndex);
            GavgRectError(:,c) = GavgRectError(:,c)./length(errorIndex);
            GavgRectNE(:,c) = GavgRectNE(:,c)./length(NEIndex);
        end
        figure
        for(i=1:16)
            subplot(4,4,i)
            hold on
            plot(GavgError(:,i))
            plot(GavgNE(:,i))
            hold off
        end
        legend("Er", "NE");
    
        i=0;
    