# SydSGM_Parcellation
![SydSGM_Parcellation](https://github.com/tonimaali/SydSGM_Parcellation/assets/73574216/eff01369-40b1-4419-ab0b-97d41da59172)

This repository releases the code for the following paper.

Tonima Ali, Jinglei Lv, Mustafa Kassem et al. In-vivo parcellation of human subcortex by multi-modal MRI, 14 April 2024, PREPRINT (Version 1) available at Research Square [https://doi.org/10.21203/rs.3.rs-4203104/v1]

Our population template and subcortical parcellation is open source and can be found here: https://osf.io/pmuez/

Please cite this paper if you use any of the scripts, templates, and parcellation. CC0 1.0 Universal.

Instructions:
The parcellation comprises of 3 major segments: (1) generation of population template, (2) computation of parametric maps, and (3) Hierarchical bi-modal clustering. T1w, T2w and diffusion MRI, all obtained from Human Connectome Project (HCP) are used for this pipeline. Below are the steps to follow for these segments. These are pseudocodoes for the steps/scripts followed to attain eth parcellation.

Step 1_1: 1_1_preprocessing_template.sh 

Step 1_2: 1_2_calc_fod_tensor_fixel_ex_t1t2_template.sh

Step 1_3: 1_3_multimodal_template.sh

Step 2_1: 2_1_multimodal_reg_apply2fod.sh

Step 2_2: 2_2_compute_parametric_maps.sh

Step 2_3: 2_3_warp_images_HDf50*.sh

Step 2_4: 2_4_warp_DEC_HDf50.sh

Step 2_5: 2_5_Generate_fiber_warps_HD.sh

Step 2_6: 2_6_warp_fibres*.sh

Step 3_1: 3_1_compute_subcortical_mask.m

Step 3_2: 3_2_bimodal_clustering.m
