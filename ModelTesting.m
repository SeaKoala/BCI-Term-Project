% load trainedModel
%%
yfit = trainedModel.predictFcn(data);

C = confusionmat(results,yfit);
acc = 0;
for (i=1:length(results))
      if(yfit(i)==results(i))
          acc=acc+1;
      end
end
acc=acc/length(results)*100
figure
h = heatmap(C)
h.Title = acc;