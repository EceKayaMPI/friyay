

y = randi(100,50,1);
yclean = ofx_outlier_by_fitlm (y);

% sth new 

%% functions 
function yclean = ofx_outlier_by_fitlm (y)
yclean = y; % y = [T.ITIs]' ;
if ~isempty(y)
    
    x = 1:length(y); x = x';
    
    [~,bad]=rmoutliers(y);
    ysafe = y;
    ysafe(bad) = NaN;

    mdl = fitlm(x,ysafe);
    ypred = predict(mdl,x);
    
    outs = [];
    for i = 1:length(y)
        if y(i) > ypred(i)*1.5
            outs(i) = 1;
        elseif y(i) < ypred(i)*0.5
            outs(i) = 1;
        else
            outs(i) = 0;
        end
    end
    yclean = y(outs == 0);
end

end
