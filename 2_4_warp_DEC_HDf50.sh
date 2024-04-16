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

	mrtransform -force ${fpath2}/${i}_DEC_no_weight.nii.gz -warp ${warppath}/${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif ${opath}/${i}_DEC_no_weight_${tplbase}.nii.gz


done

