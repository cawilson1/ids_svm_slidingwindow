%recursive feature elim
numFeatures = 20;

features = 1:numFeatures;
features = features(:);
scoreCol = zeros(numFeatures,1);
features(:,2) = scoreCol;

features = simul_feat_score_func(features);%do first round before recursion

optimalFeatureSet = recursiveElim(features);


function optimalFeatures = recursiveElim(features);
    features = simul_feat_score_func(features);%get the simulated scores for this round
    
    if(size(features,1)==6)
        optimalFeatures = features;
    
    else

        for i = 1:size(features)
            if features(i,2)==min(features(:,2))
                features(i, :) = [];%delete the lowest row
                break;%only remove first instance of lowest score
            end
        end
        
        optimalFeatures = recursiveElim(features);
    end
end

