%% Split - Preprocess Data

function [trnData,chkData,tstData] = partition_normalize(data)

    minmaxdiff = @(in_data, m_min, m_max) (in_data-repmat(m_min,[length(in_data) 1]))./(repmat(m_max,[length(in_data) 1])-repmat(m_min,[length(in_data) 1]));

    idx=randperm(length(data));
    trnIdx=idx(1:round(length(idx)*0.6));
    chkIdx=idx(round(length(idx)*0.6)+1:round(length(idx)*0.8));
    tstIdx=idx(round(length(idx)*0.8)+1:end);

    trnX=data(trnIdx,1:end-1);
    chkX=data(chkIdx,1:end-1);
    tstX=data(tstIdx,1:end-1);

    xmin=min(trnX,[],1);
    xmax=max(trnX,[],1);
    trnX=minmaxdiff(trnX, xmin, xmax);
    chkX=minmaxdiff(chkX, xmin, xmax);
    tstX=minmaxdiff(tstX, xmin, xmax);
    
    trnData=[trnX data(trnIdx,end)];
    chkData=[chkX data(chkIdx,end)];
    tstData=[tstX data(tstIdx,end)];

end

