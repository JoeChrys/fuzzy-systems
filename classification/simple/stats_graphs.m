function stats_graphs(id, valFIS, initFIS, chkData, trnError, valError)
    
    % Graph Generation
    figure
    plot([trnError valError],'LineWidth',2); grid on;
    xlabel('# of Iterations'); ylabel('Error');
    legend('Training Error','Validation Error');
    title(sprintf("TSK %d - ANFIS Hybrid Training - Validation", id));
    
    figure
    hold on
    for i=1:(size(chkData,2) - 1)
        subplot((size(chkData,2) - 1), 1, i);
        plotmf(initFIS, 'input', i);
    end
    sgtitle(sprintf("TSK %d - Initial Membership Functions", id));
    hold off
        
    figure
    hold on
    for i=1:(size(chkData,2) - 1)
        subplot((size(chkData,2) - 1), 1, i);
        plotmf(valFIS, 'input', i);
    end
    sgtitle(sprintf("TSK %d - Final Membership Functions", id));
    hold off
    
end