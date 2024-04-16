#!/bin/bash -v


# definitions of path #
sub_id=id


# The HCP data/image to be used in this script #
DWI_orig=${subject_datapath}data.nii.gz
T1w_orig=${subject_datapath}T1w_acpc_dc_restore.nii.gz
T1w_brain_orig=${subject_datapath}T1w_acpc_dc_restore_brain.nii.gz
T2w_orig=${subject_datapath}T2w_acpc_dc_restore.nii.gz
T1wDivT2w_orig=${subject_datapath}T1wDividedByT2w.nii.gz
bvals=${subject_datapath}bvals
bvecs=${subject_datapath}bvecs

# Subject name and subject location to be used later in the script #
sub_recon=${sub_id}_recon
sub_recon_path=${recon_path}${sub_id}_recon

##############################
# DWI Processing in MRtrix   #
##############################

# Directory to save results obtained by this script #
dataproc_sfa_path=${rootpath_sfa}HCP_Proc_surf/${sub_id}/
dataproc_dgm_path=${rootpath_dgm}HCP_Proc_surf_DGM/${sub_id}/

mkdir ${dataproc_dgm_path}

dwi_preproc=${dataproc_dgm_path}${sub_id}_dwi_preproc.mif.gz
# Convert diffusion data to .mif for processing in Mrtrix # 
mrconvert ${DWI_orig} ${dwi_preproc} \
	-fslgrad ${bvecs} ${bvals}

diff_brainmask=${dataproc_dgm_path}${sub_id}_mask_preproc.mif.gz
# Create brain mask #
dwi2mask ${dwi_preproc} ${diff_brainmask} 

dwi_unbiased=${dataproc_dgm_path}${sub_id}_dwi_preproc_unb.mif.gz 
# Bias correction # 
dwibiascorrect ants ${dwi_preproc} ${dwi_unbiased} \
	-mask ${diff_brainmask} \
	-bias ${dataproc_dgm_path}${sub_id}_bias.mif.gz

# Tissue specific response function calculation #
dwi2response dhollander ${dwi_unbiased} \
 	${dataproc_dgm_path}${sub_id}_WM_dh.txt \
 	${dataproc_dgm_path}${sub_id}_GM_dh.txt \
 	${dataproc_dgm_path}${sub_id}_CSF_dh.txt \
	-voxels ${dataproc_dgm_path}${sub_id}_voxels_dh.mif.gz

dwi_hr=${dataproc_dgm_path}${sub_id}_dwi_preproc_unb_hr.mif.gz
# Upsample DWI to 0.7 mm iso for higher resolution in cosequtive processing #
mrgrid ${dwi_unbiased} regrid -vox 0.7 ${dwi_hr} 
	
diff_brainmask_hr=${dataproc_dgm_path}${sub_id}_mask_preproc_hr.mif.gz
# Create brain mask for upsampled DWI #
dwi2mask ${dwi_hr} ${diff_brainmask_hr}

# Fibre orientation distribution (FOD) estimation # 
dwi2fod msmt_csd ${dwi_hr} \
	-mask ${diff_brainmask_hr} \
	${dataproc_dgm_path}${sub_id}_WM_dh.txt ${dataproc_dgm_path}${sub_id}_WMfod_dh.mif.gz \
	${dataproc_dgm_path}${sub_id}_GM_dh.txt ${dataproc_dgm_path}${sub_id}_GMfod_dh.mif.gz \
  ${dataproc_dgm_path}${sub_id}_CSF_dh.txt ${dataproc_dgm_path}${sub_id}_CSFfod_dh.mif.gz

# Intensity Normalisation #
mtnormalise ${dataproc_dgm_path}${sub_id}_WMfod_dh.mif.gz ${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz \
	${dataproc_dgm_path}${sub_id}_GMfod_dh.mif.gz ${dataproc_dgm_path}${sub_id}_GMfod_dh_norm.mif.gz \
	${dataproc_dgm_path}${sub_id}_CSFfod_dh.mif.gz ${dataproc_dgm_path}${sub_id}_CSFfod_dh_norm.mif.gz \
	-mask ${diff_brainmask_hr} 

# Tensor fitting for the upsampled DWI #
dwi2tensor ${dwi_hr} \
	-mask ${diff_brainmask_hr} \
	${dataproc_dgm_path}${sub_id}_tensor.mif.gz

# Computation of parametric maps from tensors #
tensor2metric ${dataproc_dgm_path}${sub_id}_tensor.mif.gz \
  -fa ${dataproc_dgm_path}${sub_id}_fa.nii.gz	\
  -adc ${dataproc_dgm_path}${sub_id}_adc.nii.gz \
	-ad ${dataproc_dgm_path}${sub_id}_ad.nii.gz \
	-rd ${dataproc_dgm_path}${sub_id}_rd.nii.gz \
	-mask ${diff_brainmask_hr}

fa_nii=${dataproc_dgm_path}${sub_id}_fa.nii.gz

# Converting fod to fixel for generating complexity image
fod2fixel ${wmfod_norm} ${dataproc_dgm_path_sub}${sub_id}_fixel_dir \
    -afd ${sub_id}_fod2afd.mif.gz \
    -peak_amp ${sub_id}_fod2peak.mif.gz \
    -disp ${sub_id}_fod2disp.mif.gz \
    -fmls_no_thresholds \
    -mask ${T1w_brain_mask}
    
#####################################  
# Angle_maps calculated from fixels #
#####################################

# z-components #
# number 1 fixel #
fixel2peaks ${dataproc_dgm_path_sub}${sub_id}_fixel_dir -number 1 -nan - | mrconvert - -coord 3 2 - | mrcalc - -abs - | mrcalc - -acos - | mrcalc - 180 -mult 3.14159265 -div ${dataproc_dgm_path_50sub}${sub_id}_fixel1_zcomp_angle.nii.gz

# x-components #
# number 1 fixel #
fixel2peaks ${dataproc_dgm_path_sub}${sub_id}_fixel_dir -number 1 -nan - | mrconvert - -coord 3 0 - | mrcalc - -abs - | mrcalc - -acos - | mrcalc - 180 -mult 3.14159265 -div ${dataproc_dgm_path_50sub}${sub_id}_fixel1_xcomp_angle.nii.gz 

# y-components #
# number 1 fixel #
fixel2peaks ${dataproc_dgm_path_sub}${sub_id}_fixel_dir -number 1 -nan - | mrconvert - -coord 3 1 - | mrcalc - -abs - | mrcalc - -acos - | mrcalc - 180 -mult 3.14159265 -div ${dataproc_dgm_path_50sub}${sub_id}_fixel1_ycomp_angle.nii.gz

#extract mean b0 for registratin to T1
dwi_meanb0_nii=${dataproc_dgm_path}${sub_id}_dwi_b0_mean.nii.gz

dwiextract ${dwi_unbiased} - -bzero | mrmath - mean ${dwi_meanb0_nii} -axis 3

##########################################################################
# Computation of 5tt image                                               #
########################################################################
ftt_image_FS=${dataproc_dgm_path}${sub_id}_5tt_FS.mif.gz
ftt_image_reg=${dataproc_dgm_path}${sub_id}_5tt_reg.mif.gz
ftt_vis_image=${dataproc_dgm_path}${sub_id}_5tt_reg_vis.mif.gz

# Computation of 5tt image using freesurfer #
5ttgen hsvs $recon_path${sub_id}_recon  ${ftt_image_FS} \
    -white_stem \
    -nocrop \
    -sgm_amyg_hipp \
    -hippocampi aseg \
    -thalami aseg

# register mean_b0 to T1 image
epi_reg --epi=${dwi_meanb0_nii} \
        --t1=${T1w_orig} \
        --t1brain=${T1w_brain_orig} \
        --out=${dataproc_dgm_path}${sub_id}_b0mean_warped.nii.gz
        
#convert transformation matrix to mrtrix
transformconvert ${dataproc_dgm_path}${sub_id}_b0mean_warped.mat ${dwi_meanb0_nii} ${T1w_brain_orig} flirt_import ${dataproc_dgm_path}${sub_id}_diff2T1_mrtrix.txt

# apply mrtrix version of transform to 5tt image
mrtransform ${ftt_image_FS} ${ftt_image_reg} \
        -template ${dwi_meanb0_nii} \
        -linear ${dataproc_dgm_path}${sub_id}_diff2T1_mrtrix.txt \
        -inverse
        
5tt2vis ${ftt_image_reg} ${ftt_vis_image}

################################################################################

##########################################################
# Extracting tissue type volumes from 5tt (reg)          #
##########################################################
ftt_cor_GM=${dataproc_dgm_path}${sub_id}_cor_GM.mif.gz
ftt_subcor_GM=${dataproc_dgm_path}${sub_id}_subcor_GM.mif.gz
ftt_WM=${dataproc_dgm_path}${sub_id}_WM.mif.gz

mrconvert ${ftt_image_reg} -coord 3 0 -axes 0,1,2 ${ftt_cor_GM}
mrconvert ${ftt_image_reg} -coord 3 1 -axes 0,1,2 ${ftt_subcor_GM}
mrconvert ${ftt_image_reg} -coord 3 2 -axes 0,1,2 ${ftt_WM}

# Compute a binary mask by thresholding subcor_GM at 0.5 # 
subcor_GM_mask=${dataproc_dgm_path}${sub_id}_subcor_GM_mask.mif.gz
mrcalc ${ftt_subcor_GM} 0.5 -gt ${subcor_GM_mask}

# Upsampling subcortical GM map for tckmap
ftt_subcor_GM_0p7=${dataproc_dgm_path}${sub_id}_subcor_GM_0p7.mif.gz
mrgrid ${ftt_subcor_GM} regrid -size 260,311,260 ${ftt_subcor_GM_0p7} -fill nan

# Compute mask @0.5iso to be used for tckmap
subcor_GM_mask_0p7=${dataproc_dgm_path}${sub_id}_subcor_GM_mask_0p7.mif.gz
mrcalc ${ftt_subcor_GM_0p7} 0.5 -gt ${subcor_GM_mask_0p7}

# Downsampling subcortical GM map for tckmap
ftt_subcor_GM_1miso=${dataproc_dgm_path}${sub_id}_subcor_GM_1miso.mif.gz
mrgrid ${ftt_subcor_GM} regrid -size 182,218,182 ${ftt_subcor_GM_1miso} -fill nan

# Compute mask @1miso to be used for tckmap
subcor_GM_mask_1miso=${dataproc_dgm_path}${sub_id}_subcor_GM_mask_1miso.mif.gz
mrcalc ${ftt_subcor_GM_1miso} 0.5 -gt ${subcor_GM_mask_1miso}

# ##################################
# # Tractography and optimisation  #
# ##################################

# Limits and specs for tckgen # 
tckno=10M 
alg=iFOD2 
cutoff_value=0.06
min_length=1.4
max_length=250
max_attempts=2000

tck_dgm_file_fod_seed=${dataproc_dgm_path}${sub_id}_tracks_${tckno}_dyn_seed.tck

# tckgen with seeding from whole brain wmfod
# Whole image tckgen - streamlines seeded from wmfod #
tckgen ${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz \
	${tck_dgm_file_fod_seed} \
	-algorithm ${alg} \
	-select ${tckno} \
	-seed_dynamic ${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz \
	-act ${ftt_image_reg} \
	-backtrack \
	-cutoff ${cutoff_value} \
	-minlength ${min_length} \
	-maxlength ${max_length} \
	-max_attempts_per_seed ${max_attempts}
	
# tckgen with seeding from masked image
# Whole image tckgen - streamlines seeded from dgm mask #
tck_dgm_mask_seed_file=${dataproc_dgm_path}${sub_id}_tracks_${tckno}_dgm_mask_seed.tck

tckgen ${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz \
	${tck_dgm_mask_seed_file} \
	-algorithm ${alg} \
	-select ${tckno} \
	-seed_image ${subcor_GM_mask} \
	-act ${ftt_image_reg} \
	-backtrack \
	-cutoff ${cutoff_value} \
	-minlength ${min_length} \
	-maxlength ${max_length} \
	-max_attempts_per_seed 5000

############################################################
# combining tracks generated by separate seeding methods
############################################################
tck_comb_file=${dataproc_dgm_path}${sub_id}_comb_tracks_20M.tck
tckedit ${tck_dgm_file_fod_seed} ${tck_dgm_mask_seed_file} ${tck_comb_file}

tck_weights_comb=${dataproc_dgm_path}${sub_id}_comb_tracks_20M_weights.csv
# SIFT2 for optimisation by computing track weights # 
tcksift2 ${tck_comb_file} \
	${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz \
	${tck_weights_comb} 
 
##################################################################

#################################################################
# tckmap for entire field of view and for different contrasts  	#
#################################################################
# All tckmap computed at 0.7 mm iso resolution #
# All tckmap computed with FWHM of 10 mm #

# Paramters to be repeatedly used #
res_tckmap_0p7miso=0.7
fwhm_10=10
fa_image=${dataproc_dgm_path}${sub_id}_fa.nii.gz


####################################
# contrast: fod amplitude #
####################################

# avg for fwhm of 10 mm
fod_amp_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_cfod_amp_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${fod_amp_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast fod_amp -image ${dataproc_dgm_path}${sub_id}_WMfod_dh_norm.mif.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean -stat_tck mean -fwhm_tck ${fwhm_10}

####################################
# contrast: fa #
####################################

# avg for fwhm of 10 mm
fa_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_cfa_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${fa_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast scalar_map -image ${dataproc_dgm_path}${sub_id}_fa_masked.nii.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean -stat_tck mean -fwhm_tck ${fwhm_10}

####################################
# contrast: adc #
####################################

# avg for fwhm of 10 mm
adc_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_cadc_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${adc_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast scalar_map -image ${dataproc_dgm_path}${sub_id}_adc_masked.nii.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean -stat_tck mean -fwhm_tck ${fwhm_10}

####################################
# contrast: ad #
####################################
 
# avg for fwhm of 10 mm
ad_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_cad_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${ad_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast scalar_map -image ${dataproc_dgm_path}${sub_id}_ad_masked.nii.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean -stat_tck mean -fwhm_tck ${fwhm_10}

####################################
# contrast: rd #
####################################

# avg for fwhm of 10 mm
rd_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_crd_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${rd_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast scalar_map -image ${dataproc_dgm_path}${sub_id}_rd_masked.nii.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean -stat_tck mean -fwhm_tck ${fwhm_10}

####################################
# contrast: T1wDivT2w              #
####################################

T1wDivT2w_orig=${subject_datapath}T1wDividedByT2w.nii.gz

# Compute a binary mask by thresholding afd at 0 # 
mrcalc ${T1wDivT2w_orig} \
	10 -lt \
	${dataproc_dgm_path}${sub_id}_T1wDivT2w_orig_mask.nii.gz

# Multiply by the binary mask computed in order to null the outliers #
mrcalc ${T1wDivT2w_orig} \
	${dataproc_dgm_path}${sub_id}_T1wDivT2w_orig_mask.nii.gz -mult \
	${dataproc_dgm_path}${sub_id}_T1wDivT2w_masked.nii.gz

# avg for fwhm of 10 mm
T1wDivT2w_fwhm_10_tckmap_file_0p7miso=${vol2surf_multdepth_tckmap_0p7miso}${sub_id}_tckmap_tfa_cT1wDivT2w_10_fwhm.mif.gz
tckmap ${tck_comb_file} ${T1wDivT2w_fwhm_10_tckmap_file_0p7miso} -vox ${res_tckmap_0p7miso} -template ${fa_image} -contrast scalar_map -image ${dataproc_dgm_path}${sub_id}_T1wDivT2w_masked.nii.gz -tck_weights_in ${tck_weights_comb} -stat_vox mean  -stat_tck mean -fwhm_tck ${fwhm_10}
