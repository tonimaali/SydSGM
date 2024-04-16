tplpath='/home/jingleil/jingleil_CPU/HCP_f50_HD/multi_modal_50sub_t1t2famd_Correction_20iter'
tplbase='hcp_f50_t1t2famd'
fpath1='/home/jingleil/NAS_dell_data/jingleil/HCP_f50HD/HCP_f50_prep_correction_m3'
fpath2='/home/jingleil/NAS_dell_data/tonimaa/HCP_WM_DGM_seg/HCP_Proc_surf_DGM/50sub_proc_data'
opath='/home/jingleil/jingleil_NAS/Tonima_project/Transformed_data_HD'
warppath='/home/jingleil/jingleil_CPU/HCP_f50_HD/FOD2multi_modal_t1t2famd_Correction_20iter'

# /home/jingleil/NAS_dell_data/tonimaa/HCP_WM_DGM_seg/HCP_Proc_surf_DGM/${sub_id}/${sub_id}_comb_tracks_20M.tck

j=0
for i in 100206 103111 107018 100307 103212 107321 100408 103414 107422 100610 103515 107725 101006 103818 108020 101107 104012 108121 101309 104416 108222 101410 104820 108323 101915 105014 108525 102008 105115 108828 102109 105216 109123 102311 105620 109830 102513 105923 110007 102614 106016 110411 102715 106319 110613 102816 106521 111009 103010 106824
do
   	 echo $i


	#${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif

	####################################################################
	echo "applying warp..."
	# -interp nearest


	mrtransform -force ${fpath1}/${i}_T1w_brain.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_T1w_brain_${tplbase}.nii.gz
	mrtransform -force ${fpath1}/${i}_T2w_brain.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_T2w_brain_${tplbase}.nii.gz
	mrtransform -force ${fpath1}/${i}_wmfod_norm_l0_totalafd.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_wmfod_norm_l0_totalafd_${tplbase}.nii.gz
	mrtransform -force ${fpath1}/${i}_fa_n.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_fa_n_${tplbase}.nii.gz
	mrtransform -force ${fpath1}/${i}_adc_n.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_adc_n_${tplbase}.nii.gz
  
	mrtransform -force ${fpath2}/${i}_ad_masked.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_ad_masked_${tplbase}.nii.gz
	mrtransform -force ${fpath2}/${i}_rd_masked.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_rd_masked_${tplbase}.nii.gz
	mrtransform -force ${fpath2}/${i}_fixel1_zcomp_angle.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_fixel1_zcomp_angle_${tplbase}.nii.gz
	mrtransform -force ${fpath2}/${i}_fixel1_ycomp_angle.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_fixel1_ycomp_angle_${tplbase}.nii.gz
	mrtransform -force ${fpath2}/${i}_fixel1_xcomp_angle.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_fixel1_xcomp_angle_${tplbase}.nii.gz
        
	
	#tcktransform -force ${fpath2}/${i}_comb_tracks_20M.tck ./${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_comb_tracks_20M_t1t2mdfa.tck

	#mrtransform -force ${fodpath}/${i}_wmfod_norm.mif -warp ./${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif -reorient_fod 1 ./${i}_wmfod_norm_${tplbase}.mif   

done

