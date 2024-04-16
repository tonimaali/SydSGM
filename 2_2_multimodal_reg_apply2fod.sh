tplpath='/home/jingleil/data_dell_lv/HCP_f50HD/Multi_modal/multi_modal_50sub_t1t2famd_correction'
tplbase='hcp_f50_t1t2famd'
fodpath='/home/jingleil/data_dell_lv/HCP_f50HD/HCP_f50_prep_correction_m3'
j=0
for i in 100206 103111 107018 100307 103212 107321 100408 103414 107422 100610 103515 107725 101006 103818 108020 101107 104012 108121 101309 104416 108222 101410 104820 108323 101915 105014 108525 102008 105115 108828 102109 105216 109123 102311 105620 109830 102513 105923 110007 102614 106016 110411 102715 106319 110613 102816 106521 111009 103010 106824
do
   	 echo $i
   	 k=0
   	 ((k=${j}*4 )) 
    	ants_warp=${tplpath}/${tplbase}${i}_T1w_brain${k}1Warp.nii.gz
	ants_affine=${tplpath}/${tplbase}${i}_T1w_brain${k}0GenericAffine.mat

	warpinit ${tplpath}/${tplbase}template0.nii.gz ./${i}_${tplbase}_SyN_identity_warp[].nii.gz -force

	for p in {0..2}
	do
	   WarpImageMultiTransform 3 ./${i}_${tplbase}_SyN_identity_warp${p}.nii.gz ./${i}_${tplbase}_SyN_mrtrix_warp${p}.nii.gz -R ${tplpath}/${tplbase}template0.nii.gz ${ants_warp} ${ants_affine}

	done

	warpcorrect ./${i}_${tplbase}_SyN_mrtrix_warp[].nii.gz ./${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif -force

	####################################################################
	echo "applying warp..."
        
	mrtransform -force ${fodpath}/${i}_wmfod_norm.mif -warp ./${i}_${tplbase}_SyN_mrtrix_warp_corrected.mif -reorient_fod 1 ./${i}_wmfod_norm_${tplbase}.mif   


    	((j += 1))
       	echo ${j}
    	echo $k
      	

done




