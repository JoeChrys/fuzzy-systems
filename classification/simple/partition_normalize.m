%% Partition data to 2 classes - Normalize Data

function [trnData,chkData,tstData] = partition_normalize(data)

    minmaxdiff = @(in_data, m_min, m_max) ...
        (in_data-repmat(m_min,[length(in_data) 1]))./(repmat(m_max,[length(in_data) 1])-repmat(m_min,[length(in_data) 1]));
   
    % Count number of elements in each class
    class1Count = sum(data(:,end) == 1);
    class2Count = sum(data(:,end) == 2);
    
    % Split data according to class
    class1Data = data(data(:,end) == 1,:);
    class2Data = data(data(:,end) == 2,:);
    
    % Add data from both classes to final subsets maintaining ratio
    trnData = [class1Data(1:round(class1Count*0.6), :); ...
        class2Data(1:round(class2Count*0.6), :)];
    chkData = [class1Data(round(class1Count*0.6)+1:round(class1Count*0.8), :); ...
        class2Data(round(class2Count*0.6)+1:round(class2Count*0.8), :)];
    tstData = [class1Data(round(class1Count*0.8)+1:end, :); ...
        class2Data(round(class2Count*0.8)+1:end, :)];

    % Add max-min values to prevent evaluation warnings
    % [~, maxIdx] = max(data(:,1:end-1));
    % [~, minIdx] = min(data(:,1:end-1));
    % for i=1:length(maxIdx)
    %     trnData = [trnData; data(maxIdx(i),:)];
    % end
    % for i=1:length(minIdx)
    %     trnData = [trnData; data(minIdx(i),:)];
    % end

    % Shuffle the subsets rows
    dataPerm = randperm(length(trnData));
    trnData = trnData(dataPerm, :);
    dataPerm = randperm(length(chkData));
    chkData = chkData(dataPerm, :);
    dataPerm = randperm(length(tstData));
    tstData = tstData(dataPerm, :);
    
    % Create copies of the data to be normalized
    trnX = trnData(:,1:end-1);
    chkX = chkData(:,1:end-1);
    tstX = tstData(:,1:end-1);
    
    xmin=min(trnX,[],1);
    xmax=max(trnX,[],1);
    trnX=minmaxdiff(trnX, xmin, xmax);
    chkX=minmaxdiff(chkX, xmin, xmax);
    tstX=minmaxdiff(tstX, xmin, xmax);
    
    
    % Form final subsets
    trnData=[trnX trnData(:, end)];
    chkData=[chkX chkData(:, end)];
    tstData=[tstX tstData(:, end)];

end