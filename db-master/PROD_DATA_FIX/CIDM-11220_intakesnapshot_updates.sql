-- CIDM-11220 - Data cleanup in intakesnapshot table to correct SDM information

-- 1. Delete Duplicates for I231010520949, I221010317399
UPDATE intakesnapshot
	set activeflag = 0,
		updatedby = 'CIDM-11220-1',
		updatedon = now()
	WHERE intakesnapshotid IN (	'10b88473-d13e-48e4-a019-dfa6c54b9fe5',
							'eda73f37-3929-42f5-99d2-1653dab5fb3c',
							'309fc5e8-8e23-42b2-927f-2649b235ed69',
							'3f7217d4-b559-4178-9e38-9b321e49cfdf',
							'36237b0e-ae23-4d70-ba40-016ffb6ca5fe')
		and activeflag = 1;

		
-- 2. Supervisor Disposition Updates to set to ScreenOUT
UPDATE intakesnapshot
	set jsondata = jsonb_set(jsondata, '{disposition}',
						jsonb_set(jsondata->'disposition', '{0}',
						jsonb_set(jsondata->'disposition'->0, '{supDisposition}', '"ScreenOUT"'))),
		updatedby = 'CIDM-11220-2',
		updatedon = now()
	WHERE intakenumber IN (
						'I231011831088',
						'I202000261549',
						'I202000261521',
						'I202000165168',
						'I241012823779',
						'I201900155640',
						'I202000359111',
						'I202000462399',
						'I202000562561',
						'I202000267229')
	and activeflag = 1;
		
-- 3. Supervisor Disposition Updates to set to Scrnin
UPDATE intakesnapshot
	set jsondata = jsonb_set(jsondata, '{disposition}',
						jsonb_set(jsondata->'disposition', '{0}',
						jsonb_set(jsondata->'disposition'->0, '{supDisposition}', '"Scrnin"'))),
		updatedby = 'CIDM-11220-3',
		updatedon = now()
	WHERE intakenumber IN (	
					'I202000264474',
					'I202000266316',
					'I202000165188',
					'I202000363875',
					'I202000260428',
					'I202000364651',
					'I202000111792',
					'I202000564234',
					'I241012080898',
					'I202000160093',
					'I202000362306',
					'I211010183795',
					'I202000264577',
					'I202000166179')
		and activeflag = 1;							
	

-- 4. Update Screening Recommendatation based on Abuse Checkboxes 	
-- 1431
Update intakesnapshot ins
	SET jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"screeningRecommend": "Scrnin"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-4'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
						ins.jsondata ->'sdm'->>'screeningRecommend' as screeningRecommend,
						ins.jsondata ->'sdm'->>'maltreatment' as providerInvolvedMaltreatment,  			-- yes, no
						ins.jsondata ->'sdm'->>'childfatality' as childfatality, 							-- yes, no
						ins.jsondata ->'sdm'->>'isseriousphysicalinjury' as isseriousphysicalinjury, 		-- true, false
						ins.jsondata ->'sdm'->>'confirmtrafficking' as confirmtrafficking, 					-- YES, NO
					-- PHYSICAL ABUSE
						ins.jsondata ->'sdm'->>'ismalpa_suspeciousdeath' as ismalpa_suspeciousdeath,  		-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_nonaccident' as ismalpa_nonaccident, 				-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_injuryinconsistent' as ismalpa_injuryinconsistent, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_insjury' as ismalpa_insjury, 						-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_childtoxic' as ismalpa_childtoxic, 					-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_caregiver' as ismalpa_caregiver, 					-- true, false/null
					-- 	SEXUAL ABUSE
						ins.jsondata ->'sdm'->>'ismalsa_sexualmolestation' as ismalsa_sexualmolestation, 	-- true, false/null	
						ins.jsondata ->'sdm'->>'ismalsa_sexualact' as ismalsa_sexualact, 					-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_sexualexploitation' as ismalsa_sexualexploitation, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_physicalindicators' as ismalsa_physicalindicators, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_sex_trafficking' as ismalsa_sex_trafficking, 		-- true, false/null	
					-- 	NEGLECT
						ins.jsondata ->'sdm'->>'isneggn_suspiciousdeath' as isneggn_suspiciousdeath, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_signsordiagnosis' as isneggn_signsordiagnosis, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequatefood' as isneggn_inadequatefood, 			-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_childdischarged' as isneggn_childdischarged, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_exposuretounsafe' as isneggn_exposuretounsafe,		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequateclothing' as isneggn_inadequateclothing, 	-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequatesupervision' as isneggn_inadequatesupervision, -- true, false/null	
						ins.jsondata ->'sdm'->>'isnegrh_treatmenthealthrisk' as isnegrh_treatmenthealthrisk, -- true, false/null
					-- Failure To Protect	
						ins.jsondata ->'sdm'->>'isnegfp_cargiverintervene' as isnegfp_cargiverintervene,	-- true, false/null
					-- Abandonment	
						ins.jsondata ->'sdm'->>'isnegab_abandoned' as isnegab_abandoned,					-- true, false/null
					-- Unattended Child
						ins.jsondata ->'sdm'->>'isneguc_leftunsupervised' as isneguc_leftunsupervised,		-- true, false/null
						ins.jsondata ->'sdm'->>'isneguc_leftaloneinappropriatecare' as isneguc_leftaloneinappropriatecare,	-- true, false/null
						ins.jsondata ->'sdm'->>'isneguc_leftalonewithoutsupport' as isneguc_leftalonewithoutsupport,	-- true, false/null
					-- Medical Neglect
						ins.jsondata ->'sdm'->>'isnegmn_unreasonabledelay' as isnegmn_unreasonabledelay,		-- true, false/null
					-- Mental Injury - Abuse
						ins.jsondata ->'sdm'->>'ismenab_psycologicalability' as ismenab_psycologicalability,	-- true, false/null
					-- Mental Injury - Neglect
						ins.jsondata ->'sdm'->>'ismenng_psycologicalability' as ismenng_psycologicalability,	-- true, false/null
					-- Mental Injury - RISK OF HARM
						ins.jsondata ->'sdm'->>'isnegrh_priordeath' as isnegrh_priordeath,						-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_exposednewborn' as isnegrh_exposednewborn,				-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_basicneedsunmet' as isnegrh_basicneedsunmet,			-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_sex_offender' as isnegrh_sex_offender,					-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_risk_dv' as isnegrh_risk_dv,							-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_sex_trafficking' as isnegrh_sex_trafficking,			-- true, false/null	
						ins.jsondata ->'sdm'->>'isnegrh_fatality_can' as isnegrh_fatality_can,					-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_indicated_unsub' as isnegrh_indicated_unsub,			-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_survivor' as isnegrh_survivor,							-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_birth_match' as isnegrh_birth_match						-- true, false/null
					--	*
					from intakesnapshot ins
					where ins.activeflag = 1	
						and ins.intakenumber not like 'CW%'
						and ins.jsondata ->'sdm'->>'screeningRecommend' <> 'Scrnin'
						-- Child Protective Services (CPS Cases Only)
						and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
						and exists 
							(select 1
								from intakedastaging ids
							where ids.intakenumber = ins.intakenumber
								and ids.activeflag  = 1
								and coalesce(ids.teamtypekey, 'CW') = 'CW'
							)
					) tab		
			where (--coalesce(providerInvolvedMaltreatment, 'no') = 'yes' or
			-- PHYSICAL ABUSE
				coalesce(ismalpa_suspeciousdeath, 'false') = 'true'
				or coalesce(ismalpa_nonaccident, 'false') = 'true'
				or coalesce(ismalpa_injuryinconsistent, 'false') = 'true'
				or coalesce(ismalpa_insjury, 'false') = 'true'
				or coalesce(ismalpa_childtoxic, 'false') = 'true'
				or coalesce(ismalpa_caregiver, 'false') = 'true'
			-- 	SEXUAL ABUSE
				or coalesce(ismalsa_sexualmolestation, 'false') = 'true'
				or coalesce(ismalsa_sexualact, 'false') = 'true'
				or coalesce(ismalsa_sexualexploitation, 'false') = 'true'
				or coalesce(ismalsa_physicalindicators, 'false') = 'true'
				or coalesce(ismalsa_sex_trafficking, 'false') = 'true'	
			-- 	NEGLECT
				or coalesce(isneggn_suspiciousdeath, 'false') = 'true'
				or coalesce(isneggn_signsordiagnosis, 'false') = 'true'
				or coalesce(isneggn_inadequatefood, 'false') = 'true'
				or coalesce(isneggn_childdischarged, 'false') = 'true'
				or coalesce(isneggn_exposuretounsafe, 'false') = 'true'
				or coalesce(isneggn_inadequateclothing, 'false') = 'true'
				or coalesce(isneggn_inadequatesupervision, 'false') = 'true'	
				or coalesce(isnegrh_treatmenthealthrisk, 'false') = 'true'
			-- Failure To Protect	
				or coalesce(isnegfp_cargiverintervene, 'false') = 'true'
			-- Abandonment	
				or coalesce(isnegab_abandoned, 'false') = 'true'
			-- Unattended Child
				or coalesce(isneguc_leftunsupervised, 'false') = 'true'
				or coalesce(isneguc_leftaloneinappropriatecare, 'false') = 'true'
				or coalesce(isneguc_leftalonewithoutsupport, 'false') = 'true'
			-- Medical Neglect
				or coalesce(isnegmn_unreasonabledelay, 'false') = 'true'
			-- Mental Injury - Abuse
				or coalesce(ismenab_psycologicalability, 'false') = 'true'
			-- Mental Injury - Neglect
				or coalesce(ismenng_psycologicalability, 'false') = 'true'));


-- 5. Update Screening Recommendatation based on Risk of Harm Checkboxes 			
-- 509
Update intakesnapshot ins
	SET jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"screeningRecommend": "accept_as_noncps"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-5'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
						ins.jsondata ->'sdm'->>'screeningRecommend' as screeningRecommend,
						ins.jsondata ->'sdm'->>'maltreatment' as providerInvolvedMaltreatment,  			-- yes, no
						ins.jsondata ->'sdm'->>'childfatality' as childfatality, 							-- yes, no
						ins.jsondata ->'sdm'->>'isseriousphysicalinjury' as isseriousphysicalinjury, 		-- true, false
						ins.jsondata ->'sdm'->>'confirmtrafficking' as confirmtrafficking, 					-- YES, NO
					-- PHYSICAL ABUSE
						ins.jsondata ->'sdm'->>'ismalpa_suspeciousdeath' as ismalpa_suspeciousdeath,  		-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_nonaccident' as ismalpa_nonaccident, 				-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_injuryinconsistent' as ismalpa_injuryinconsistent, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_insjury' as ismalpa_insjury, 						-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_childtoxic' as ismalpa_childtoxic, 					-- true, false/null
						ins.jsondata ->'sdm'->>'ismalpa_caregiver' as ismalpa_caregiver, 					-- true, false/null
					-- 	SEXUAL ABUSE
						ins.jsondata ->'sdm'->>'ismalsa_sexualmolestation' as ismalsa_sexualmolestation, 	-- true, false/null	
						ins.jsondata ->'sdm'->>'ismalsa_sexualact' as ismalsa_sexualact, 					-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_sexualexploitation' as ismalsa_sexualexploitation, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_physicalindicators' as ismalsa_physicalindicators, 	-- true, false/null
						ins.jsondata ->'sdm'->>'ismalsa_sex_trafficking' as ismalsa_sex_trafficking, 		-- true, false/null	
					-- 	NEGLECT
						ins.jsondata ->'sdm'->>'isneggn_suspiciousdeath' as isneggn_suspiciousdeath, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_signsordiagnosis' as isneggn_signsordiagnosis, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequatefood' as isneggn_inadequatefood, 			-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_childdischarged' as isneggn_childdischarged, 		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_exposuretounsafe' as isneggn_exposuretounsafe,		-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequateclothing' as isneggn_inadequateclothing, 	-- true, false/null
						ins.jsondata ->'sdm'->>'isneggn_inadequatesupervision' as isneggn_inadequatesupervision, -- true, false/null	
						ins.jsondata ->'sdm'->>'isnegrh_treatmenthealthrisk' as isnegrh_treatmenthealthrisk, -- true, false/null
					-- Failure To Protect	
						ins.jsondata ->'sdm'->>'isnegfp_cargiverintervene' as isnegfp_cargiverintervene,	-- true, false/null
					-- Abandonment	
						ins.jsondata ->'sdm'->>'isnegab_abandoned' as isnegab_abandoned,					-- true, false/null
					-- Unattended Child
						ins.jsondata ->'sdm'->>'isneguc_leftunsupervised' as isneguc_leftunsupervised,		-- true, false/null
						ins.jsondata ->'sdm'->>'isneguc_leftaloneinappropriatecare' as isneguc_leftaloneinappropriatecare,	-- true, false/null
						ins.jsondata ->'sdm'->>'isneguc_leftalonewithoutsupport' as isneguc_leftalonewithoutsupport,	-- true, false/null
					-- Medical Neglect
						ins.jsondata ->'sdm'->>'isnegmn_unreasonabledelay' as isnegmn_unreasonabledelay,		-- true, false/null
					-- Mental Injury - Abuse
						ins.jsondata ->'sdm'->>'ismenab_psycologicalability' as ismenab_psycologicalability,	-- true, false/null
					-- Mental Injury - Neglect
						ins.jsondata ->'sdm'->>'ismenng_psycologicalability' as ismenng_psycologicalability,	-- true, false/null
					-- Mental Injury - RISK OF HARM
						ins.jsondata ->'sdm'->>'isnegrh_priordeath' as isnegrh_priordeath,						-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_exposednewborn' as isnegrh_exposednewborn,				-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_basicneedsunmet' as isnegrh_basicneedsunmet,			-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_sex_offender' as isnegrh_sex_offender,					-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_risk_dv' as isnegrh_risk_dv,							-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_sex_trafficking' as isnegrh_sex_trafficking,			-- true, false/null	
						ins.jsondata ->'sdm'->>'isnegrh_fatality_can' as isnegrh_fatality_can,					-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_indicated_unsub' as isnegrh_indicated_unsub,			-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_survivor' as isnegrh_survivor,							-- true, false/null
						ins.jsondata ->'sdm'->>'isnegrh_birth_match' as isnegrh_birth_match						-- true, false/null
					--	*
					from intakesnapshot ins
					where ins.activeflag = 1	
						and ins.intakenumber not like 'CW%'
						and ins.jsondata ->'sdm'->>'screeningRecommend' <> 'accept_as_noncps'
						-- Child Protective Services (CPS Cases Only)
						and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
						and exists 
							(select 1
								from intakedastaging ids
							where ids.intakenumber = ins.intakenumber
								and ids.activeflag  = 1
								and coalesce(ids.teamtypekey, 'CW') = 'CW'
							)
					) tab		
			where (--coalesce(providerInvolvedMaltreatment, 'no') = 'no' and
				-- PHYSICAL ABUSE
					coalesce(ismalpa_suspeciousdeath, 'false') = 'false'
					and coalesce(ismalpa_nonaccident, 'false') = 'false'
					and coalesce(ismalpa_injuryinconsistent, 'false') = 'false'
					and coalesce(ismalpa_insjury, 'false') = 'false'
					and coalesce(ismalpa_childtoxic, 'false') = 'false'
					and coalesce(ismalpa_caregiver, 'false') = 'false'
				-- 	SEXUAL ABUSE
					and coalesce(ismalsa_sexualmolestation, 'false') = 'false'
					and coalesce(ismalsa_sexualact, 'false') = 'false'
					and coalesce(ismalsa_sexualexploitation, 'false') = 'false'
					and coalesce(ismalsa_physicalindicators, 'false') = 'false'
					and coalesce(ismalsa_sex_trafficking, 'false') = 'false'	
				-- 	NEGLECT
					and coalesce(isneggn_suspiciousdeath, 'false') = 'false'
					and coalesce(isneggn_signsordiagnosis, 'false') = 'false'
					and coalesce(isneggn_inadequatefood, 'false') = 'false'
					and coalesce(isneggn_childdischarged, 'false') = 'false'
					and coalesce(isneggn_exposuretounsafe, 'false') = 'false'
					and coalesce(isneggn_inadequateclothing, 'false') = 'false'
					and coalesce(isneggn_inadequatesupervision, 'false') = 'false'	
					and coalesce(isnegrh_treatmenthealthrisk, 'false') = 'false'
				-- Failure To Protect	
					and coalesce(isnegfp_cargiverintervene, 'false') = 'false'
				-- Abandonment	
					and coalesce(isnegab_abandoned, 'false') = 'false'
				-- Unattended Child
					and coalesce(isneguc_leftunsupervised, 'false') = 'false'
					and coalesce(isneguc_leftaloneinappropriatecare, 'false') = 'false'
					and coalesce(isneguc_leftalonewithoutsupport, 'false') = 'false'
				-- Medical Neglect
					and coalesce(isnegmn_unreasonabledelay, 'false') = 'false'
				-- Mental Injury - Abuse
					and coalesce(ismenab_psycologicalability, 'false') = 'false'
				-- Mental Injury - Neglect
					and coalesce(ismenng_psycologicalability, 'false') = 'false')
				and (
					coalesce(isnegrh_priordeath, 'false') = 'true'
					or coalesce(isnegrh_exposednewborn, 'false') = 'true'
					or coalesce(isnegrh_basicneedsunmet, 'false') = 'true'
					or coalesce(isnegrh_sex_offender, 'false') = 'true'
					or coalesce(isnegrh_risk_dv, 'false') = 'true'	
					or coalesce(isnegrh_sex_trafficking, 'false') = 'true'
					or coalesce(isnegrh_fatality_can, 'false') = 'true'
					or coalesce(isnegrh_indicated_unsub, 'false') = 'true'
					or coalesce(isnegrh_survivor, 'false') = 'true'
					or coalesce(isnegrh_birth_match, 'false') = 'true'
				));


-- 6) If Override Screenout description exists under 'Other (Specify)' checkbox and isscrnoutrecovr_otherspecify (Other (Specify)) is not true, set it to true
-- 1586
Update intakesnapshot ins
	set jsondata = jsonb_set(jsondata, '{sdm}',
						jsonb_set(jsondata->'sdm', '{screenOut}',
						jsonb_set(jsondata->'sdm'->'screenOut', '{isscrnoutrecovr_otherspecify}', '"true"'))),
		updatedon = now(),
		updatedby = 'CIDM-11220-6'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
						ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
						ins.jsondata ->'sdm'->'screenOut' ->> 'scrnout_description'as scrnout_description
					--	*
					from intakesnapshot ins
					where ins.activeflag = 1	
						and ins.intakenumber not like 'CW%'
						-- Child Protective Services (CPS Cases Only)
						and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
						and exists 
							(select 1
								from intakedastaging ids
							where ids.intakenumber = ins.intakenumber
								and ids.activeflag  = 1
								and coalesce(ids.teamtypekey, 'CW') = 'CW'
							)
				) tab
			where coalesce(scnRecommendOveride, '') = 'OvrScrnout'
				and trim(coalesce(scrnout_description, '')) <> ''
				and coalesce(isscrnoutrecovr_otherspecify, 'false') = 'false');

-- 7) If Override Screenout description exists under 'Other (Specify)' checkbox and isscrnoutrecovr_otherspecify (Other (Specify)) is not true, set it to true and set scnRecommendOveride to OvrScrnout
-- 467
Update intakesnapshot ins
	SET jsondata = jsonb_set(
				jsonb_set(
					jsondata, 
					'{sdm, screenOut, isscrnoutrecovr_otherspecify}', 
					'true'::jsonb
				),
				'{sdm, scnRecommendOveride}', 
				'"OvrScrnout"'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-7'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
						ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
						ins.jsondata ->'sdm'->'screenOut' ->> 'scrnout_description'as scrnout_description
					--	*
					from intakesnapshot ins
					where ins.activeflag = 1	
						and ins.intakenumber not like 'CW%'
						-- Child Protective Services (CPS Cases Only)
						and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
						and exists 
							(select 1
								from intakedastaging ids
							where ids.intakenumber = ins.intakenumber
								and ids.activeflag  = 1
								and coalesce(ids.teamtypekey, 'CW') = 'CW'
							)
				) tab
			where coalesce(scnRecommendOveride, '') <> 'OvrScrnout'
				and trim(coalesce(scrnout_description, '')) <> ''
				and coalesce(isscrnoutrecovr_otherspecify, 'false') = 'false');

-- 8)	If anyone overrides reason checkbox is selected.
-- Update -> Overrides decision -> “Screen out”
-- Update -> Final Screening Decision -> “Screen out”

--Total 12214 records (12963) (3 seconds)

Update intakesnapshot ins
	SET jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"scnRecommendOveride": "OvrScrnout", "isfinalscreenin": "false"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-8'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
						ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
						ins.jsondata ->'sdm'->'screenOut' ->> 'duplicatereportflag' as duplicatereportflag,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_information' as isscrnoutrecovr_information,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_insufficient' as isscrnoutrecovr_insufficient,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_historicalinformation' as isscrnoutrecovr_historicalinformation,
						ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
						ins.jsondata ->'sdm'->>'isfinalscreenin' as isfinalscreenin
					--	*
					from intakesnapshot ins
					where ins.activeflag = 1	
						and ins.intakenumber not like 'CW%'
						-- Child Protective Services (CPS Cases Only)
						and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
						and exists 
							(select 1
								from intakedastaging ids
							where ids.intakenumber = ins.intakenumber
								and ids.activeflag  = 1
								and coalesce(ids.teamtypekey, 'CW') = 'CW'
							)
				) tab		
			where coalesce(scnRecommendOveride, '') <> 'OvrScrnout'
				and ( coalesce(duplicatereportflag, '0') in ('1', 'true')
					or coalesce(isscrnoutrecovr_information, 'false') = 'true'
					or coalesce(isscrnoutrecovr_insufficient, 'false') = 'true'
					or coalesce(isscrnoutrecovr_historicalinformation, 'false') = 'true'
					or coalesce(isscrnoutrecovr_otherspecify, 'false') = 'true'));


-- 9)--I241013122375 - set Override Screenout reason to duplicatereport
Update intakesnapshot ins
	SET jsondata = jsonb_set(
			jsonb_set(jsondata, '{sdm, duplicatereportflag}', '1'::jsonb), 
			'{sdm, screenOut, duplicatereportflag}', '1'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-9'
	where intakenumber = 'I241013122375'
		and activeflag = 1;

-- 10)	If Initial Screening Recommendation = “Screen in” and No overrides apply
-- Update -> Final Screening Decision -> “Screen in”
--9965  -- 13614

Update intakesnapshot ins
	set jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"isfinalscreenin": "true"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-10'
	where intakenumber in ( 		
		select tab.intakenumber
			from (
				select ins.intakenumber,
					ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
					ins.jsondata ->'sdm'->'screenOut' ->> 'duplicatereportflag' as duplicatereportflag,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_information' as isscrnoutrecovr_information,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_insufficient' as isscrnoutrecovr_insufficient,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_historicalinformation' as isscrnoutrecovr_historicalinformation,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
					ins.jsondata ->'sdm'->>'isfinalscreenin' as isfinalscreenin
				--	*
				from intakesnapshot ins
				where ins.activeflag = 1	
					and ins.intakenumber not like 'CW%'
					and ins.jsondata ->'sdm'->>'screeningRecommend' = 'Scrnin'
					and coalesce(ins.jsondata ->'sdm'->>'isfinalscreenin','') <> 'true'
					-- Child Protective Services (CPS Cases Only)
					and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
					and exists 
						(select 1
							from intakedastaging ids
						where ids.intakenumber = ins.intakenumber
							and ids.activeflag  = 1
							and coalesce(ids.teamtypekey, 'CW') = 'CW'
						)
				) tab		
			where coalesce(scnRecommendOveride, '') <> 'OvrScrnout'
				and coalesce(duplicatereportflag, '0') not in ('1', 'true')
				and coalesce(isscrnoutrecovr_information, 'false') <> 'true'
				and coalesce(isscrnoutrecovr_insufficient, 'false') <> 'true'
				and coalesce(isscrnoutrecovr_historicalinformation, 'false') <> 'true'
				and coalesce(isscrnoutrecovr_otherspecify, 'false') <> 'true');
	
-- 11)	 If Initial Screening Recommendation = “Accept as Non-CPS” and No overrides apply
-- Update -> Final Screening Decision -> “Accept as Non-CPS”
-- 24914 -- 25565

Update intakesnapshot ins
	set jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"isfinalscreenin": "Ovr_as_noncps"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-11'
	where intakenumber in (  	
		select tab.intakenumber
			from (
				select ins.intakenumber,
					ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
					ins.jsondata ->'sdm'->'screenOut' ->> 'duplicatereportflag' as duplicatereportflag,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_information' as isscrnoutrecovr_information,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_insufficient' as isscrnoutrecovr_insufficient,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_historicalinformation' as isscrnoutrecovr_historicalinformation,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
					ins.jsondata ->'sdm'->>'isfinalscreenin' as isfinalscreenin
				--	*
				from intakesnapshot ins
				where ins.activeflag = 1	
					and ins.intakenumber not like 'CW%'
					and ins.jsondata ->'sdm'->>'screeningRecommend' = 'accept_as_noncps'
					and coalesce(ins.jsondata ->'sdm'->>'isfinalscreenin','') <> 'Ovr_as_noncps'
					-- Child Protective Services (CPS Cases Only)
					and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
					and exists 
						(select 1
							from intakedastaging ids
						where ids.intakenumber = ins.intakenumber
							and ids.activeflag  = 1
							and coalesce(ids.teamtypekey, 'CW') = 'CW'
						)
				) tab		
			where coalesce(scnRecommendOveride, '') = '');
			

-- 12) If Oveeride Recommendation is 'OvrScrnout' set final screen in to false

Update intakesnapshot ins
	set jsondata = jsonb_set(jsondata, '{sdm}', 
		(jsondata->'sdm') || '{"isfinalscreenin": "false"}'::jsonb),
		updatedon = now(),
		updatedby = 'CIDM-11220-12'
	where intakenumber in ( 		
		select tab.intakenumber
			from (
				select ins.intakenumber,
					ins.jsondata ->'sdm'->>'scnRecommendOveride' as scnRecommendOveride,
					ins.jsondata ->'sdm'->'screenOut' ->> 'duplicatereportflag' as duplicatereportflag,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_information' as isscrnoutrecovr_information,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_insufficient' as isscrnoutrecovr_insufficient,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_historicalinformation' as isscrnoutrecovr_historicalinformation,
					ins.jsondata ->'sdm'->'screenOut' ->> 'isscrnoutrecovr_otherspecify'as isscrnoutrecovr_otherspecify,
					ins.jsondata ->'sdm'->>'isfinalscreenin' as isfinalscreenin
				--	*
				from intakesnapshot ins
				where ins.activeflag = 1	
					and ins.intakenumber not like 'CW%'
					and ins.jsondata ->'sdm'->>'scnRecommendOveride' = 'OvrScrnout'
					and coalesce(ins.jsondata ->'sdm'->>'isfinalscreenin','') <> 'false'
					-- Child Protective Services (CPS Cases Only)
					and replace(replace((ins.jsondata ->'General'->>'Purpose')::character varying, '~CW', ''), '~undefined', '') = '247a8b26-cdee-4ce8-b36e-b37e49fd0103'
					and exists 
						(select 1
							from intakedastaging ids
						where ids.intakenumber = ins.intakenumber
							and ids.activeflag  = 1
							and coalesce(ids.teamtypekey, 'CW') = 'CW'
						)
				) tab );
	

/*
To Test 

select ins.jsondata ->'sdm'->>'screeningRecommend', -- "SDM -Initial Screening Recommendation"
	ins.jsondata ->'sdm'->>'scnRecommendOveride', -- "SDM - Overrides"
	ins.jsondata ->'sdm'->>'isfinalscreenin' -- "SDM - Final Screening Decision (after consideration of overrides)" 
		-- 'false' is 'Screen OUT'
	,* 
from intakesnapshot ins 
where intakenumber in ('I261013672364', 'I251013518043', 'I251013341138')

*/
