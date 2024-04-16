function [matrix_vol_warped] = TA_read_vol_data_warped_50subs_4mask(ROImask, loc_warped_data, loc_data_50sub, sub_id)

% vol_ad
vol_cad = single(niftiread(strcat(loc_data_50sub, '/', sub_id, '_ad_masked.nii.gz')));

% vol_adc
vol_cadc = single(niftiread(strcat(loc_warped_data, sub_id, '_adc_n_hcp_f50_t1t2famd.nii.gz')));

% vol_rd
vol_crd = single(niftiread(strcat(loc_data_50sub, '/', sub_id, '_rd_masked.nii.gz')));

% vol_cT1wDivT2w
vol_cT1wDivT2w = single(niftiread(strcat(loc_data_50sub, '/', sub_id, '/', sub_id, '_T1wDividedByT2w.nii.gz')));

% vol_fa
vol_cfa = single(niftiread(strcat(strcat(loc_warped_data, sub_id, '_fa_n_hcp_f50_t1t2famd.nii.gz'))));

% DEC
vol_DEC = single(niftiread(strcat(loc_warped_data, sub_id, '_DEC_no_weight_hcp_f50_t1t2famd.nii.gz')));

vol_DEC_col_1 = squeeze(vol_DEC(:, :, :, 1));
vol_DEC_col_2 = squeeze(vol_DEC(:, :, :, 2));
vol_DEC_col_3 = squeeze(vol_DEC(:, :, :, 3));

% sample data for selected indices at the mask and store in a matrix
data_idx = find(ROImask);

vol_cT1wDivT2w_array = vol_cT1wDivT2w(data_idx);
matrix_data(:, 1) = TA_mod_vec_pca(vol_cT1wDivT2w_array);

vol_cfa_array = vol_cfa(data_idx);
matrix_data(:, 2) = TA_mod_vec_pca(vol_cfa_array);

vol_cadc_array = vol_cadc(data_idx);
matrix_data(:, 3) = TA_mod_vec_pca(vol_cadc_array);

vol_cad_array = vol_cad(data_idx);
matrix_data(:, 4) = TA_mod_vec_pca(vol_cad_array);

vol_crd_array = vol_crd(data_idx);
matrix_data(:, 5) = TA_mod_vec_pca(vol_crd_array);

vol_DEC_col_1_array = vol_DEC_col_1(data_idx);
matrix_data(:, 6) = TA_mod_vec_pca(vol_DEC_col_1_array);

vol_DEC_col_2_array = vol_DEC_col_2(data_idx);
matrix_data(:, 7) = TA_mod_vec_pca(vol_DEC_col_2_array);

vol_DEC_col_3_array = vol_DEC_col_3(data_idx);
matrix_data(:, 8) = TA_mod_vec_pca(vol_DEC_col_3_array);

matrix_vol_warped = matrix_data;
