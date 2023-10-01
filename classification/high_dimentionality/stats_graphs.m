function stats_graphs(valFIS, initFIS, chkData, trnError, valError)
    
    % Graph Generation
    figure
    plot([trnError valError],'LineWidth',2); grid on;
    xlabel('# of Iterations'); ylabel('Error');
    legend('Training Error','Validation Error');
    title('TSK - ANFIS Hybrid Training - Validation');
    
    figure
    hold on
    for i=1:(size(chkData,2) - 1)
        subplot((size(chkData,2) - 1), 1, i);
        plotmf(initFIS, 'input', i);
    end
    sgtitle('TSK - Initial Membership Functions');
    hold off
        
    figure
    hold on
    for i=1:(size(chkData,2) - 1)
        subplot((size(chkData,2) - 1), 1, i);
        plotmf(valFIS, 'input', i);
    end
    sgtitle('TSK - Final Membership Functions');
    hold off
    
end