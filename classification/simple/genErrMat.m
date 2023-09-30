% Gerenates error matrix
function errorMatrix = genErrMat(data, predictions)
    
    errorMatrix = zeros(max(data), max(data));
    
    for i=1:length(data)
       errorMatrix(predictions(i), data(i)) =  ...
           errorMatrix(predictions(i), data(i)) + 1;
    end
    
end