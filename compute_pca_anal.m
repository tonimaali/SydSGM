function [coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_data)

data_tckmap_vol_norm = normalize(matrix_data, 1);
    
% run pca 
[coeff, score, latent,tsquared, explained, mu] = pca(data_tckmap_vol_norm, ...
    'Algorithm', 'als');


coeff_pca = coeff;
score_pca = score;
explained_pca = explained;
