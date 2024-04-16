%% definition of locations

loc_root = '/HCP_WM_DGM_seg/';

loc_atlases = '/Transformed_data_HD/';

first_atlas = niftiread(strcat(loc_atlases, '100206_Parcellation_HCPMMP1_T1space.nii.gz'));

% location for warped tckmaps
loc_data_50sub = strcat(loc_root, 'HCP_Proc_surf_DGM/50sub_proc_data/');
loc_50sub_mask = strcat(loc_data_50sub, '50sub_masks/');

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

%% Reading the masks warped to template space at 0.7mm iso

mask_warped_matrix(1, :, :, :) = niftiread(strcat(loc_atlases, '100206_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(2, :, :, :) = niftiread(strcat(loc_atlases, '100307_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(3, :, :, :) = niftiread(strcat(loc_atlases, '100408_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(4, :, :, :) = niftiread(strcat(loc_atlases, '100610_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(5, :, :, :) = niftiread(strcat(loc_atlases, '101006_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(6, :, :, :) = niftiread(strcat(loc_atlases, '101107_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(7, :, :, :) = niftiread(strcat(loc_atlases, '101309_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(8, :, :, :) = niftiread(strcat(loc_atlases, '101410_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(9, :, :, :) = niftiread(strcat(loc_atlases, '101915_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(10, :, :, :) = niftiread(strcat(loc_atlases, '102008_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(11, :, :, :) = niftiread(strcat(loc_atlases, '102109_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(12, :, :, :) = niftiread(strcat(loc_atlases, '102311_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(13, :, :, :) = niftiread(strcat(loc_atlases, '102513_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(14, :, :, :) = niftiread(strcat(loc_atlases, '102614_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(15, :, :, :) = niftiread(strcat(loc_atlases, '102715_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(16, :, :, :) = niftiread(strcat(loc_atlases, '102816_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(17, :, :, :) = niftiread(strcat(loc_atlases, '103010_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(18, :, :, :) = niftiread(strcat(loc_atlases, '103111_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(19, :, :, :) = niftiread(strcat(loc_atlases, '103212_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(20, :, :, :) = niftiread(strcat(loc_atlases, '103414_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(21, :, :, :) = niftiread(strcat(loc_atlases, '103515_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(22, :, :, :) = niftiread(strcat(loc_atlases, '103818_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(23, :, :, :) = niftiread(strcat(loc_atlases, '104012_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(24, :, :, :) = niftiread(strcat(loc_atlases, '104416_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(25, :, :, :) = niftiread(strcat(loc_atlases, '104820_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(26, :, :, :) = niftiread(strcat(loc_atlases, '105014_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(27, :, :, :) = niftiread(strcat(loc_atlases, '105115_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(28, :, :, :) = niftiread(strcat(loc_atlases, '105216_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(29, :, :, :) = niftiread(strcat(loc_atlases, '105620_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(30, :, :, :) = niftiread(strcat(loc_atlases, '105923_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(31, :, :, :) = niftiread(strcat(loc_atlases, '106016_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(32, :, :, :) = niftiread(strcat(loc_atlases, '106319_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(33, :, :, :) = niftiread(strcat(loc_atlases, '106521_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(34, :, :, :) = niftiread(strcat(loc_atlases, '106824_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(35, :, :, :) = niftiread(strcat(loc_atlases, '107018_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(36, :, :, :) = niftiread(strcat(loc_atlases, '107321_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(37, :, :, :) = niftiread(strcat(loc_atlases, '107422_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(38, :, :, :) = niftiread(strcat(loc_atlases, '107725_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(39, :, :, :) = niftiread(strcat(loc_atlases, '108020_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(40, :, :, :) = niftiread(strcat(loc_atlases, '108121_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(41, :, :, :) = niftiread(strcat(loc_atlases, '108222_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(42, :, :, :) = niftiread(strcat(loc_atlases, '108323_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(43, :, :, :) = niftiread(strcat(loc_atlases, '108525_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(44, :, :, :) = niftiread(strcat(loc_atlases, '108828_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(45, :, :, :) = niftiread(strcat(loc_atlases, '109123_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(46, :, :, :) = niftiread(strcat(loc_atlases, '109830_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(47, :, :, :) = niftiread(strcat(loc_atlases, '110007_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(48, :, :, :) = niftiread(strcat(loc_atlases, '110411_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(49, :, :, :) = niftiread(strcat(loc_atlases, '110613_Parcellation_HCPMMP1_T1space.nii.gz'));
mask_warped_matrix(50, :, :, :) = niftiread(strcat(loc_atlases, '111009_Parcellation_HCPMMP1_T1space.nii.gz'));

%%

firs_atlas_fastsurf_adj = flip(permute(first_atlas, [1 3 2]), 3);

T1w_avg_space = single(niftiread(strcat(loc_atlases, '100206_T1w_brain_hcp_f50_t1t2famd.nii.gz')));
nifti_info_T1w = niftiinfo(strcat(loc_atlases, '100206_T1w_brain_hcp_f50_t1t2famd.nii.gz'));

image_matrix_zero = single(zeros(size(firs_atlas_fastsurf_adj)));

%% masks for putamen
for i = 1:50
    mask_sub = squeeze(mask_warped_matrix (i, :, :, :));
    mask_adj = flip(permute(mask_sub, [1 3 2]), 3);   
    index_mask_left_putamen = find(mask_adj == 364);
    index_mask_right_putamen = find(mask_adj == 373);
    mask_comb_putamen = image_matrix_zero;
    mask_comb_putamen(index_mask_left_putamen) = 1;
    mask_comb_putamen(index_mask_right_putamen) = 1;
    mask_putamen_adj_matrix(i, :, :, :) = mask_comb_putamen;
end

%% Add putamen masks together and save
mask_comb_putamen_adj_mult = squeeze(prod(mask_putamen_adj_matrix, 1));
%
niftiwrite(mask_comb_putamen_adj_mult, strcat(loc_50sub_mask, 'Mask_HCP_comb_putamen_mult'), nifti_info_T1w);

%% Add putamen masks together and save
mask_comb_putamen_adj_added = squeeze(sum(mask_putamen_adj_matrix, 1)./50);
%
mask_comb_putamen_adj_abovep60 = image_matrix_zero;
index_putamen_abovep75 = find (mask_comb_putamen_adj_added > 0.75);
mask_comb_putamen_adj_abovep75 (index_putamen_abovep75) = 1;
niftiwrite(mask_comb_putamen_adj_abovep75, strcat(loc_50sub_mask, 'Mask_HCP_comb_putamen_abvp75'), nifti_info_T1w);
%% masks for pallidum
for i = 1:50
    mask_sub = squeeze(mask_warped_matrix (i, :, :, :));
    mask_adj = flip(permute(mask_sub, [1 3 2]), 3);   
    index_mask_left_pallidum = find(mask_adj == 365);
    index_mask_right_pallidum = find(mask_adj == 374);
    mask_comb_pallidum = image_matrix_zero;
    mask_comb_pallidum(index_mask_left_pallidum) = 1;
    mask_comb_pallidum(index_mask_right_pallidum) = 1;
    mask_pallidum_adj_matrix(i, :, :, :) = mask_comb_pallidum;
end

%% Add pallidum masks together and save
mask_comb_pallidum_adj_mult = squeeze(prod(mask_pallidum_adj_matrix, 1));
%
niftiwrite(mask_comb_pallidum_adj_mult, strcat(loc_50sub_mask, 'Mask_HCP_comb_pallidum_mult'), nifti_info_T1w);

%% Add pallidum masks together and save
mask_comb_pallidum_adj_added = squeeze(sum(mask_pallidum_adj_matrix, 1)./50);
%
mask_comb_pallidum_adj_abovep75 = image_matrix_zero;
index_pallidum_abovep75 = find (mask_comb_pallidum_adj_added > 0.75);
mask_comb_pallidum_adj_abovep75 (index_pallidum_abovep75) = 1;
niftiwrite(mask_comb_pallidum_adj_abovep75, strcat(loc_50sub_mask, 'Mask_HCP_comb_pallidum_abvp75'), nifti_info_T1w);
%% masks for caudate
for i = 1:50
    mask_sub = squeeze(mask_warped_matrix (i, :, :, :));
    mask_adj = flip(permute(mask_sub, [1 3 2]), 3);   
    index_mask_left_caudate = find(mask_adj == 363);
    index_mask_right_caudate = find(mask_adj == 372);
    mask_comb_caudate = image_matrix_zero;
    mask_comb_caudate(index_mask_left_caudate) = 1;
    mask_comb_caudate(index_mask_right_caudate) = 1;
    mask_caudate_adj_matrix(i, :, :, :) = mask_comb_caudate;
end

%% Add caudate masks together and save
mask_comb_caudate_adj_mult = squeeze(prod(mask_caudate_adj_matrix, 1));
%
niftiwrite(mask_comb_caudate_adj_mult, strcat(loc_50sub_mask, 'Mask_HCP_comb_caudate_mult'), nifti_info_T1w);

%% Add caudate masks together and save
mask_comb_caudate_adj_added = squeeze(sum(mask_caudate_adj_matrix, 1)./50);
%
mask_comb_caudate_adj_abovep75 = image_matrix_zero;
index_caudate_abovep75 = find (mask_comb_caudate_adj_added > 0.75);
mask_comb_caudate_adj_abovep75 (index_caudate_abovep75) = 1;
niftiwrite(mask_comb_caudate_adj_abovep75, strcat(loc_50sub_mask, 'Mask_HCP_comb_caudate_abvp75'), nifti_info_T1w);
%% masks for accumbens
for i = 1:50
    mask_sub = squeeze(mask_warped_matrix (i, :, :, :));
    mask_adj = flip(permute(mask_sub, [1 3 2]), 3);   
    index_mask_left_accumbens = find(mask_adj == 368);
    index_mask_right_accumbens = find(mask_adj == 377);
    mask_comb_accumbens = image_matrix_zero;
    mask_comb_accumbens(index_mask_left_accumbens) = 1;
    mask_comb_accumbens(index_mask_right_accumbens) = 1;
    mask_accumbens_adj_matrix(i, :, :, :) = mask_comb_accumbens;
end

%% Add accumbens masks together and save
mask_comb_accumbens_adj_mult = squeeze(prod(mask_accumbens_adj_matrix, 1));
%
niftiwrite(mask_comb_accumbens_adj_mult, strcat(loc_50sub_mask, 'Mask_HCP_comb_accumbens_mult'), nifti_info_T1w);

%% Add accumbens masks together and save
mask_comb_accumbens_adj_added = squeeze(sum(mask_accumbens_adj_matrix, 1)./50);
%
mask_comb_accumbens_adj_abovep75 = image_matrix_zero;
index_accumbens_abovep75 = find (mask_comb_accumbens_adj_added > 0.75);
mask_comb_accumbens_adj_abovep75 (index_accumbens_abovep75) = 1;
niftiwrite(mask_comb_accumbens_adj_abovep75, strcat(loc_50sub_mask, 'Mask_HCP_comb_accumbens_abvp75'), nifti_info_T1w);
%% masks for thalamus
for i = 1:50
    mask_sub = squeeze(mask_warped_matrix (i, :, :, :));
    mask_adj = flip(permute(mask_sub, [1 3 2]), 3);   
    index_mask_left_thalamus = find(mask_adj == 362);
    index_mask_right_thalamus = find(mask_adj == 371);
    mask_comb_thalamus = image_matrix_zero;
    mask_comb_thalamus(index_mask_left_thalamus) = 1;
    mask_comb_thalamus(index_mask_right_thalamus) = 1;
    mask_thalamus_adj_matrix(i, :, :, :) = mask_comb_thalamus;
end

%% Add putamen masks together and save
mask_comb_thalamus_adj_mult = squeeze(prod(mask_thalamus_adj_matrix, 1));
%
niftiwrite(mask_comb_thalamus_adj_mult, strcat(loc_50sub_mask, 'Mask_HCP_comb_thalamus_mult'), nifti_info_T1w);

%% Add thalamus masks together and save
mask_comb_thalamus_adj_added = squeeze(sum(mask_thalamus_adj_matrix, 1)./50);
%
mask_comb_thalamus_adj_abovep75 = image_matrix_zero;
index_thalamus_abovep75 = find (mask_comb_thalamus_adj_added > 0.75);
mask_comb_thalamus_adj_abovep75 (index_thalamus_abovep75) = 1;
niftiwrite(mask_comb_thalamus_adj_abovep75, strcat(loc_50sub_mask, 'Mask_HCP_comb_thalamus_abvp75'), nifti_info_T1w);
