function [errorMat, accuracy, producerAcc, userAcc, k] = metrics(tstData, Y)
    
    errorMat = genErrMat(tstData(:,end), Y);
    accuracy = 100 * sum(Y == tstData(:,end)) / length(Y);
    producerAcc = zeros(max(tstData(:,end)), 1);
    userAcc = zeros(max(tstData(:,end)), 1);
    correctPredictions = sum(Y == tstData(:,end));
    kSumPart = 0;
    
    for i=1:length(producerAcc)
        producerAcc(i) = errorMat(i,i) / sum(errorMat(:,i));
        userAcc(i) = errorMat(i,i) / sum(errorMat(i,:));
        kSumPart = kSumPart + sum(errorMat(i,:)) * sum(errorMat(:,i));
    end
    
    userAcc = userAcc * 100;
    producerAcc = producerAcc * 100;
    k = (length(Y) * correctPredictions - kSumPart) / (length(Y)^2 - kSumPart);
end