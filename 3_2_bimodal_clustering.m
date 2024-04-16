% script for bimodal hiararchical clustering of caudate 

loc_warped_data = '/Transformed_data_HD/';
first_atlas = niftiread(strcat(loc_warped_data, '100206_Parcellation_HCPMMP1_T1space.nii.gz'));

% location for 50 subject data
loc_data_50sub = strcat(loc_root, 'HCP_Proc_surf_DGM/50sub_proc_data/');
loc_50sub_mask = strcat(loc_data_50sub, '50sub_masks/Mask_50sub_HCP_ext/');

%% struct with subject names

Subnum.sub1 = '100206';
Subnum.sub2 = '100307';
Subnum.sub3 = '100408';
Subnum.sub4 = '100610';
Subnum.sub5 = '101006';
Subnum.sub6 = '101107';
Subnum.sub7 = '101309';
Subnum.sub8 = '101410';
Subnum.sub9 = '101915';
Subnum.sub10 = '102008';
Subnum.sub11 = '102109';
Subnum.sub12 = '102311';
Subnum.sub13 = '102513';
Subnum.sub14 = '102614';
Subnum.sub15 = '102715';
Subnum.sub16 = '102816';
Subnum.sub17 = '103010';
Subnum.sub18 = '103111';
Subnum.sub19 = '103212';
Subnum.sub20 = '103414';
Subnum.sub21 = '103515';
Subnum.sub22 = '103818';
Subnum.sub23 = '104012';
Subnum.sub24 = '104416';
Subnum.sub25 = '104820';
Subnum.sub26 = '105014';
Subnum.sub27 = '105115';
Subnum.sub28 = '105216';
Subnum.sub29 = '105620';
Subnum.sub30 = '105923';
Subnum.sub31 = '106016';
Subnum.sub32 = '106319';
Subnum.sub33 = '106521';
Subnum.sub34 = '106824';
Subnum.sub35 = '107018';
Subnum.sub36 = '107321';
Subnum.sub37 = '107422';
Subnum.sub38 = '107725';
Subnum.sub39 = '108020';
Subnum.sub40 = '108121';
Subnum.sub41 = '108222';
Subnum.sub42 = '108323';
Subnum.sub43 = '108525';
Subnum.sub44 = '108828';
Subnum.sub45 = '109123';
Subnum.sub46 = '109830';
Subnum.sub47 = '110007';
Subnum.sub48 = '110411';
Subnum.sub49 = '110613';
Subnum.sub50 = '111009';

%% location for saving data

DGM_seg_loc = strcat(loc_data_50sub, 'DGM_seg_50subs/');
DGM_seg_50sub_group = strcat(DGM_seg_loc, 'DGM_seg_50subs_pca_kmeans/');
DGM_seg_50sub_group_ext_mask = strcat(DGM_seg_50sub_group, 'ext_mask/');

%% read in the DGM atlas for making ROI masks for DGM structures 

mask_caudate_fastsurf_warped_abvp75 = single(niftiread(strcat(loc_50sub_mask, 'Mask_HCP_comb_caudate_abvp75_tail_extension_MD.nii')));
image_matrix_zero = single(zeros(size(mask_caudate_fastsurf_warped_abvp75)));

T1w_avg_space = single(niftiread(strcat(loc_warped_data, '100206_T1w_brain_hcp_f50_t1t2famd.nii.gz')));
nifti_info_T1w = niftiinfo(strcat(loc_warped_data, '100206_T1w_brain_hcp_f50_t1t2famd.nii.gz'));

%% Read in tckmap and vol data for specific subjects and extract data points for mask provided

matrix_tckmap_vol_data_all_subs = TA_get_tckmap_vol_50subs_4mask(mask_caudate_fastsurf_warped_abvp75, '10', ...
    loc_warped_data, loc_data_50sub, Subnum);

%% principal componenent analysis (pca) from matrix data

[coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_tckmap_vol_data_all_subs);  

%% choose how many principal components to be used for clustering (min 5% contribution from explained)

% 2 clusters are chosen for this run
[Mask_idx_1, Mask_idx_2] = ...
    TA_do_bin_mask_2clus_steps_save_image(real(score_pca(:, 1:4)), DGM_seg_50sub_group_ext_mask, '50sub_', ...
    nifti_info_T1w, image_matrix_zero, mask_caudate_fastsurf_warped_abvp75, 'caudate');

%% Read in tckmap and vol data for specific subjects and extract data points for mask provided

clear matrix_tckmap_vol_data_all_subs;

matrix_tckmap_vol_data_all_subs = TA_get_tckmap_vol_50subs_4mask(Mask_idx_1, '10', ...
    loc_warped_data, loc_data_50sub, Subnum);

%% principal componenent analysis (pca) from matrix data
clear coeff_pca;
clear score_pca;
clear explained_pca;

[coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_tckmap_vol_data_all_subs);

%% choose how many principal components to be used for clustering (min 5% contribution from explained)

% 2 clusters are chosen for this run
[Mask_idx_1_1, Mask_idx_1_2] = ...
    TA_do_bin_mask_2clus_steps_save_image(real(score_pca(:, 1:4)), DGM_seg_50sub_group, '50sub_', ...
    nifti_info_T1w, image_matrix_zero, Mask_idx_1, 'caudate_1');

%% Read in tckmap and vol data for specific subjects and extract data points for mask provided

matrix_tckmap_vol_data_all_subs = TA_get_tckmap_vol_50subs_4mask(Mask_idx_2, '10', ...
    loc_warped_data, loc_data_50sub, Subnum);

%% principal componenent analysis (pca) from matrix data
clear coeff_pca;
clear score_pca;
clear explained_pca; 

[coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_tckmap_vol_data_all_subs);

%% choose how many principal components to be used for clustering (min 5% contribution from explained)
% this function should also save the clustered data at "loc_avg_seg_with_dir_4clus"

% 2 clusters are chosen for this run
[Mask_idx_2_1, Mask_idx_2_2] = ...
    TA_do_bin_mask_2clus_steps_save_image(real(score_pca(:, 1:4)), DGM_seg_50sub_group, '50sub_', ...
    nifti_info_T1w, image_matrix_zero, Mask_idx_2, 'caudate_2');

%% Read in tckmap and vol data for specific subjects and extract data points for mask provided


matrix_tckmap_vol_data_all_subs = TA_get_tckmap_vol_50subs_4mask(Mask_idx_2_1, '10', ...
    loc_warped_data, loc_data_50sub, Subnum);

%% principal componenent analysis (pca) from matrix data
clear coeff_pca;
clear score_pca;
clear explained_pca; 

[coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_tckmap_vol_data_all_subs);

%% choose how many principal components to be used for clustering (min 5% contribution from explained)
% this function should also save the clustered data at "loc_avg_seg_with_dir_4clus"

% 2 clusters are chosen for this run
[Mask_idx_2_1_1, Mask_idx_2_1_2] = ...
    TA_do_bin_mask_2clus_steps_save_image(real(score_pca(:, 1:3)), DGM_seg_50sub_group, '50sub_', ...
    nifti_info_T1w, image_matrix_zero, Mask_idx_2_1, 'caudate_2_1');

%% Read in tckmap and vol data for specific subjects and extract data points for mask provided

clear matrix_tckmap_vol_data_all_subs;

matrix_tckmap_vol_data_all_subs = TA_get_tckmap_vol_50subs_4mask(Mask_idx_1_2, '10', ...
    loc_warped_data, loc_data_50sub, Subnum);

%% principal componenent analysis (pca) from matrix data
clear coeff_pca;
clear score_pca;
clear explained_pca; 

[coeff_pca, score_pca, explained_pca] = compute_pca_anal(matrix_tckmap_vol_data_all_subs);

%% choose how many principal components to be used for clustering (min 5% contribution from explained)
% this function should also save the clustered data at "loc_avg_seg_with_dir_4clus"

% 2 clusters are chosen for this run
[Mask_idx_1_2_1, Mask_idx_1_2_2] = ...
    TA_do_bin_mask_2clus_steps_save_image(real(score_pca(:, 1:4)), DGM_seg_50sub_group, '50sub_', ...
    nifti_info_T1w, image_matrix_zero, Mask_idx_1_2, 'caudate_1_2');
