function [RMSE, R2, NMSE, NDEI] = stats_graphs(valFIS, chkData, tstData, trnError, valError, mfPlots)

    % Evaluation function
    Rsq = @(ypred,y) 1-sum((ypred-y).^2)/sum((y-mean(y)).^2);

    % Stats calculation
    Y = evalfis(valFIS, tstData(:,1:end-1));
    R2 = Rsq(Y, tstData(:,end));
    RMSE = sqrt(mse(Y,tstData(:,end)));
    NMSE = sum((Y - tstData(:,end)).^2) / sum((tstData(:,end) - mean(tstData(:,end))).^2);
    NDEI = sqrt(NMSE);
    
    % Graph Generation
    figure
    plot([trnError valError],'LineWidth',2); grid on;
    xlabel('# of Iterations'); ylabel('Error');
    legend('Training Error','Validation Error');
    title("ANFIS Hybrid Training - Validation");
    figure
    hold on
    if mfPlots == 1
        for i=1:(size(chkData,2) - 1)
            subplot(4,3,i);
            plotmf(valFIS, 'input', i);
        end
    end
    sgtitle("Final Membership Functions");
    hold off
    
    figure
    histogram(abs(Y - tstData(:,end)));
    title("Prediction Error");
    xlabel('Error');
    ylabel('Counts');
end

