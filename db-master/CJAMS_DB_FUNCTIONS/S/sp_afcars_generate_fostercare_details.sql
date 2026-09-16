DROP FUNCTION if exists cjams.sp_afcars_generate_fostercare_details(character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.sp_afcars_generate_fostercare_details(	vdt_from character varying, 
																		vdt_to character varying
																	  )
 RETURNS void
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 04/05/2023
-- To Capture AFCARS Child data Multiple Removals, Living Arrangement /Placement etc. (CIDM-6942)

-- Revision(s)
-- 11/02/2023 - AFCARS 2.0 modification to resolve issues reported by AFC (CIDM-8011)
--				To report the bio client's all removal episodes on the AFCARS submission. 
--				To report each CPA home as a separate placement entry for private provider placements.
--     			To report the retroactively end dated removals for the reporting based on the transaction time. 
--				To update E124 as 3 (Kin) if E117 or E119 is 1 (Relative) 
-- 				To consider active 97 Disability Types for E23 
-- 				To exclude Respite care Living Arrangements

-- 01/24/2024 - AFCARS 2.0 modifications for Element 55: Foster Care Maintenance Payment New Logic (CIDM-8211) 
-- 04/30/2024 - Vineet Tirodkar - AFCARS 2.0 modifications (CIDM-8739)
--  To add check for Child removal date is prior to period end date. 
--  Changes to E133_foster_parent1_race_declined to default as Declined if no other race is selected.
--  Changes to read provider household marital status from marital_status_cd and family_structure_cd columns.
-- 09/25/2024 - Vineet Tirodkar - Modification to XML based on the new guidelines from NCWDMS (CIDM-9501)
-- 10/02/2024 - Vineet Tirodkar - Modification e155 Exit Reason - Live with other relative (LWOR) report as 2 (CIDM-9544) 
-- 11/19/2024 - Vineet Tirodkar - e57 & e58 logic corrections (CIDM-9817)
-- 03/19/2025 - Vineet Tirodkar - AFCARS Data Improvement defect fixes based on the ACF data analysis (CIDM-10187)
--				AFCARS modifications: Child removal <removal_2020> vs <removal_1993> logic fix
--				The person gender logic for newly added options.
-- 				Duplicate Child removal reporting issue fix and add the condition to exclude less than 24 hours removals 
-- 				New implementation to capture the submission data in the History tables (code is in the shell scripts)
-- 03/21/2025 - Vineet Tirodkar - Modifications to include the newly added removal_date, exit_date columns (CIDM-10253 - B-214951)
-- 05/01/2025 - Vineet Tirodkar - To fix 2025A Non-compliance errors (CIDM-10253 - B-214951)
-- 				1) Changes for newly added Kinship placement structures 531 Non-paid Kinship & 530 Kinship 
--				2) E113_foster_family_home = 0 (No) and E146_foster_parent2_sex must be null discrepancy
--				3) logic fix to get the Bio clients placements  	
--				To fix the data errors reported by SSA (CIDM-10422)
--				1) E35_school_enrollment & E37_school_special_education discrepancy
--				2) E46_support_assistance & E47_E55 discrepancy
--				3) E69_removal_date & E70_removal_transaction_date discrepancy (for adjusted removal start date records) 
--				4) Changes to E63_tpr_parent1, E64_tpr_parent2, E67_tpr_date_parent1 and E68_tpr_date_parent2 logic
-- 10/29/2025 - Vineet Tirodkar - To add logic for E120 - Qualified Residential Treatment Program (CIDM-10839)
-- 04/14/2026 - Vineet Tirodkar - Modification to the Court Petition date Elements E65 & E66 (Date of Petition for TPR) 
--								  and Siblings Element 56(Total Number of Siblings), 57 (Siblings in Foster Care)
--								  & 58 (Siblings in Living Arrangement) (CIDM-11316)
-- 04/23/2026 - Vineet Tirodkar - Modification to report Element 123: Marital Status of the Foster Parent 4 = Single adult for missing co-applicants. (CIDM-11353)		
------------------------------------------------------------------------
Declare sqlcode int default 0;
		
Declare vl_rel_cnt1	integer;	
Declare vl_rel_cnt2	integer;
Declare vl_sibling integer;	

Declare vl_fc_placemnt_cnt1 integer;	
Declare vl_fc_placemnt_cnt2 integer;	
Declare vl_fc_placemnt_sibling integer;	
Declare vl_cpahome_count integer;	
		
Declare vl_la_placemnt_cnt1 integer;	
Declare vl_la_placemnt_cnt2 integer;	
Declare vl_la_placemnt_sibling integer;	

Declare vl_fc_la_placemnt_sibling integer;	

Declare vl_ch_rem_sibling_cnt1 integer;
Declare vl_ch_rem_sibling_cnt2 integer;
Declare vl_ch_rem_sibling integer;	
		
Declare vd_removaldate Timestamp;
Declare vd_exitdate Timestamp;
Declare vd_pl_startdate Timestamp;
Declare vd_pl_enddate Timestamp;
Declare vd_cpahome_startdate Timestamp;
Declare vd_cpahome_enddate Timestamp;
 		
Declare vu_personid uuid;
Declare vu_servicecaseid uuid;
Declare vu_intakeservreqchildremovalid uuid;
Declare vu_placementid uuid;
Declare vu_permanencyplanid uuid;
Declare vu_progressnoteid uuid;
Declare vu_intakeservicerequestcourthearingid uuid;
Declare vu_gap_id uuid;
Declare vu_placementcpahomeid uuid;

-- 03/28
Declare vu_pcr_personid uuid;
Declare vu_scr_personid uuid;

Declare vs_client_id character varying;
Declare vs_caseid character varying;
Declare vs_servicecaseid character varying;

Declare vs_E9_recognized_tribes character varying;

Declare vs_E35_school_enrollment character varying;
Declare vs_E36_school_highest_completed character varying;
Declare vs_E37_school_special_education character varying;
Declare vs_E38_pregnant character varying;
Declare vs_E39_fathered_or_bore_child character varying;
Declare vs_E40_child_and_children_together character varying;
	
Declare vs_tpr_petition_date character varying;
Declare vs_is_trp_contested character varying;
		
Declare vs_afcarsfostercareid character varying;
Declare vs_recordno character varying;
Declare vs_removalid character varying;
Declare vs_current_period_removal_sw character varying;
Declare vs_child_removalid character varying;
Declare vs_e69_removal_date character varying;
Declare vs_e153_exit_date character varying;
Declare vs_e70_removal_transaction_date character varying;
Declare vs_e71_removal_environment character varying;
Declare vs_e154_exit_transaction_date character varying;
Declare vs_e155_exit_reason character varying;
Declare vs_removalcircumstances character varying;
Declare vs_e156_transfer_to_another_agency character varying;
Declare vs_E3_local_agency character varying;

Declare vs_e80_abandonment character varying;
Declare vs_e82_caretaker_alcohol_use character varying; 
Declare vs_e83_caretaker_drug_use character varying; 
Declare vs_e95_caretaker_impairment_cognitive character varying;
Declare vs_e94_caretaker_impairment_physical_emotional character varying; 
Declare vs_e84_child_alcohol_use character varying; 
Declare vs_e91_child_behavior_problem character varying; 
Declare vs_e85_child_drug_use character varying; 
Declare vs_e98_child_requested_placement character varying; 
Declare vs_e92_death_of_caretaker character varying;
Declare vs_e88_diagnosed_condition character varying; 
Declare vs_e79_domestic_violence character varying; 
Declare vs_e81_failure_to_return character varying; 
Declare vs_e101_family_conflict_gender_orientation character varying; 
Declare vs_e105_homelessness character varying; 
Declare vs_e89_inadequate_access_to_mental_health character varying; 
Declare vs_e90_inadequate_access_to_medical_service character varying; 
Declare vs_e96_inadequate_housing character varying; 
Declare vs_e93_incarceration_of_caretaker character varying; 
Declare vs_e78_medical_neglect character varying; 
Declare vs_e77_neglect character varying; 
Declare vs_e100_parental_immigration_detainment_deportation character varying; 
Declare vs_e74_physical_abuse character varying; 
Declare vs_e86_prenatal_alcohol_exposure character varying; 
Declare vs_e87_prenatal_drug_exposure character varying; 
Declare vs_e76_psychological_abuse character varying; 
Declare vs_e103_public_agency_title_iv_agreement character varying; 
Declare vs_e72_runaway character varying;
Declare vs_e75_sexual_abuse character varying;
Declare vs_e99_sex_trafficking character varying; 
Declare vs_e104_tribal_agreement character varying; 
Declare vs_e97_voluntary_adoption character varying; 
Declare vs_e73_whereabouts_unknown character varying;
Declare vs_e102_educational_neglect character varying;
					
Declare vs_E147_permanency_plan_date character varying;
Declare vs_E148_permanency_plan_type character varying;

Declare vs_E149_periodic_review_date character varying;

Declare vs_E150_permanency_hearing_date character varying;

Declare vs_E151_case_worker_visit_date character varying;
Declare vs_E152_case_worker_visit_location character varying;

Declare vs_placement_type character varying; 
Declare vs_e112_date_living_arrangement character varying; 
Declare vs_e113_foster_family_home character varying; 
Declare vs_e114_licensed_home character varying; 
Declare vs_e115_therapeutic_home character varying; 
Declare vs_e116_shelter_care_home character varying; 
Declare vs_e117_relative_foster_family character varying; 
Declare vs_e118_pre_adopt_home character varying; 
Declare vs_e119_kin_foster_family character varying; 
Declare vs_e120_other_living_arrangement_type character varying; 
Declare vs_e121_location_of_living_arrangement character varying; 
Declare vs_e122_jurisdiction_or_country character varying; 
Declare vs_e123_marital_status_of_foster_parents character varying; 
Declare vs_e124_relationship_to_foster_parents character varying; 
Declare vs_e125_foster_parent1_birth_year character varying; 
Declare vs_e126_foster_parent1_tribal_membership character varying; 
Declare vs_e127_foster_parent1_race_american_indian_alaska_native character varying; 
Declare vs_e128_foster_parent1_race_asian character varying; 
Declare vs_e129_foster_parent1_race_black character varying; 
Declare vs_e130_foster_parent1_race_native_hawaiian_pacific_islander character varying; 
Declare vs_e131_foster_parent1_race_white character varying; 
Declare vs_e132_foster_parent1_race_unknown character varying; 
Declare vs_e133_foster_parent1_race_declined character varying; 
Declare vs_e134_foster_parent1_hispanic_latino character varying; 
Declare vs_e135_foster_parent1_sex character varying; 
Declare vs_e136_foster_parent2_birth_year character varying; 
Declare vs_e137_foster_parent2_tribal_membership character varying; 
Declare vs_e138_foster_parent2_race_american_indian_alaska_native character varying; 
Declare vs_e139_foster_parent2_race_asian character varying; 
Declare vs_e140_foster_parent2_race_black character varying; 
Declare vs_e141_foster_parent2_race_native_hawaiian_pacific_islander character varying; 
Declare vs_e142_foster_parent2_race_white character varying; 
Declare vs_e143_foster_parent2_race_unknown character varying; 
Declare vs_e144_foster_parent2_race_declined character varying; 
Declare vs_e145_foster_parent2_hispanic_latino character varying; 
Declare vs_e146_foster_parent2_sex character varying;
Declare vs_family_structure_cd character varying;
Declare vs_marital_status_cd character varying;

Declare vl_adoption_client_id Bigint;
Declare vl_adop_casenumber Bigint;
Declare vl_altproviderid Bigint;
Declare vl_cpahome_altproviderid Bigint;
Declare vl_approval_person_id Bigint;
Declare vl_applicant_cjamspid Bigint;
Declare vl_coapplicant_cjamspid Bigint;
Declare vl_client_id Bigint;
Declare vl_post_adopt_id Bigint;
Declare vl_gap_provider_id Bigint;
Declare vl_gap_casenumber Bigint;
Declare vl_provider_approval_id Bigint;
Declare vl_address_id Bigint;
Declare vl_provider_cpa_adop_person_id Bigint;

Declare vl_adop_plan_id character varying;
Declare vl_adop_case_id character varying;
Declare vl_servicecaseid character varying;
Declare vs_E157_marital_status_of_adoptive_parents character varying;
Declare vl_adop_parent_id character varying;
Declare vl_family_structure character varying;
Declare vs_E160_relationship_to_adoptive_parents_non_relative character varying;
Declare vs_E158_relationship_to_adoptive_parents_relative character varying;
Declare vs_E159_relationship_to_adoptive_parents_kin  character varying;
Declare vs_E161_relationship_to_adoptive_parents_foster_parent character varying;
Declare vs_E185_assistance_agreement_type character varying;
Declare vl_mother_pid character varying; 
-- vl_intake_actor_id
Declare vs_E162_adoptive_parent1_birth_date character varying;
Declare vs_E163_adoptive_parent1_tribal_membership character varying;
Declare vs_E164_adoptive_parent1_race_american_indian_alaska_native character varying;
Declare vs_E165_adoptive_parent1_race_asian character varying;
Declare vs_E166_adoptive_parent1_race_black character varying;
Declare vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander character varying;
Declare vs_E168_adoptive_parent1_race_white character varying;
Declare vs_E169_adoptive_parent1_race_unknown character varying;
Declare vs_E170_adoptive_parent1_race_declined character varying;
Declare vs_E171_adoptive_parent1_hispanic_latino character varying;
Declare vs_E172_adoptive_parent1_sex character varying;
Declare vl_father_pid character varying; 
-- vl_intake_actor_id
Declare vs_E173_adoptive_parent2_birth_date character varying;
Declare vs_E174_adoptive_parent2_tribal_membership character varying;
Declare vs_E175_adoptive_parent2_race_american_indian_alaska_native character varying; 
Declare vs_E176_adoptive_parent2_race_asian character varying; 
Declare vs_E177_adoptive_parent2_race_black character varying; 
Declare vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander character varying;
Declare vs_E179_adoptive_parent2_race_white character varying; 
Declare vs_E180_adoptive_parent2_race_unknown character varying; 
Declare vs_E181_adoptive_parent2_race_declined character varying; 
Declare vs_E182_adoptive_parent2_hispanic_latino character varying; 
Declare vs_E183_adoptive_parent2_sex character varying;
Declare vs_E184_inter_intrajurisdictional_adoption character varying;
Declare vl_provider_id Bigint;
Declare vu_adoptionagreementid uuid;
Declare vs_E186_siblings_in_adoptive_home character varying;

Declare vs_E106_prior_victim_sex_trafficking character varying;
Declare vs_E107_prior_victim_sex_trafficking_reported character varying;
Declare vs_E108_prior_victim_sex_trafficking_reported_date character varying;
Declare vs_E109_victim_sex_trafficking character varying;
Declare vs_E110_victim_sex_trafficking_reported character varying;
Declare vs_E111_victim_sex_trafficking_reported_date character varying;

Declare vu_bio_intakeservreqchildremovalid uuid;
Declare vl_bio_cjamspid bigint;
Declare vl_bio_removalid bigint;
Declare vs_bio_removaldate character varying;
Declare vs_bio_exitdate character varying;
Declare vs_bio_servicecasenumber character varying;
Declare vs_bio_removalexitreason character varying;

-- E55
Declare vs_ivefostercareflag character varying;

Declare vs_ive_status_cd character varying;
Declare vs_ive_payment_check character varying;

Declare vd_entry_dt Timestamp;
Declare vd_exit_dt Timestamp;
Declare vd_qrtp_14day Timestamp;

Declare vl_2913_count integer;
Declare vl_service_id bigint;
Declare vl_qrtp_provider_org_id bigint;
Declare vl_qrtp_count integer;
Declare vl_ive_payment_count integer;
Declare vl_ive_stamping_count integer;

Declare vd_removal_1993_dt date;
Declare vu_bio_personid uuid;
Declare vs_adop_cjamspid character varying;
Declare vs_adop_afcarsfostercareid character varying;
Declare vs_adop_recordno character varying;
Declare vs_adop_e3_local_agency character varying;
Declare vs_bio_returntransts character varying;

-- for B-214951 - CIDM-10253 - Acceptance Criteria 2
Declare vd_removal_date timestamp;
Declare vd_exit_date timestamp;
Declare vd_bio_removal_date timestamp;
Declare vd_bio_exit_date timestamp;
Declare	vs_first_placementcpahomeid character varying;
Declare vs_first_placementid character varying;
Declare vs_first_qualifying_placement_date character varying;
Declare vs_fix_type character varying;

-- for B-214951 - CIDM-10253 - Acceptance Criteria 1 
Declare vs_livingarrangementtypekey character varying;
Declare vl_placement_sructure_id bigint;

Declare vs_mothertprdate character varying;
Declare vs_is_monther_trp_contested character varying;
Declare vs_fathertprdate character varying;
Declare vs_is_father_trp_contested character varying;

Declare vs_bio_cjamspid character varying;

-- CIDM-11316
Declare vl_pl_rank integer;
Declare vd_pl_start_dt timestamp;
Declare vd_pl_end_dt timestamp;
Declare vl_pl_provider_id bigint;
Declare vs_la_type character varying;
Declare vs_pl_type character varying;
Declare vs_caregiver_client_id character varying;
		
cur_afcars_client record;
cur_afcars_client_REFCURSOR REFCURSOR;
				
cur_child_removal record;
cur_child_removal_REFCURSOR REFCURSOR;

cur_la_placement record;
cur_la_placement_REFCURSOR REFCURSOR;

cur_permanency_plan record;
cur_permanency_plan_REFCURSOR REFCURSOR;

cur_caseworker_visit record;
cur_caseworker_visit_REFCURSOR REFCURSOR;

cur_periodic_review record;
cur_periodic_review_REFCURSOR REFCURSOR;

cur_permanency_hearing record;
cur_permanency_hearing_REFCURSOR REFCURSOR;

cur_federally_recognized_tribe record;
cur_federally_recognized_tribe_REFCURSOR REFCURSOR;

cur_bio_removals_record record;
cur_bio_removals_REFCURSOR REFCURSOR;

cur_cap_home_record record;
cur_cap_home_REFCURSOR REFCURSOR;

cur_ado_bio_clients record;
cur_ado_bio_clients_REFCURSOR REFCURSOR;

-- for B-214951 - CIDM-10253 
-- Acceptance Criteria 2 and 3
cur_removal_placement_data record;
cur_removal_placement_data_REFCURSOR  REFCURSOR;

cur_removal_placement_date_fix record;
cur_removal_placement_date_fix_REFCURSOR REFCURSOR;

-- Acceptance Criteria 6
cur_adop_parents record;
cur_adop_parents_REFCURSOR REFCURSOR;

BEGIN

	DROP TABLE IF EXISTS ttb_bio_client_removal;
	CREATE TEMP TABLE ttb_bio_client_removal
		( 	adop_cjamspid character varying,
			afcarsfostercareid character varying,
			recordno character varying, 
			e3_local_agency character varying
		);
	
	
	DROP TABLE IF EXISTS ttb_removal_placement_date_fix;
	CREATE TEMP TABLE ttb_removal_placement_date_fix
		( 	removalid character varying,
			fix_type character varying,
			e69_removal_date character varying,
			first_qualifying_placement_date character varying, 
			first_placementcpahomeid character varying, 
			first_placementid character varying
		);	
			
	-- Clear prior run data
	DELETE FROM cjams.afcars_fc_child_removals;	
	DELETE FROM cjams.afcars_fc_client_data;
	DELETE FROM cjams.afcars_fc_recognized_tribes;
	DELETE FROM cjams.afcars_fc_placements;
	DELETE FROM cjams.afcars_fc_permanency_plans;
	DELETE FROM cjams.afcars_fc_caseworker_visits;
	DELETE FROM cjams.afcars_fc_periodic_reviews;
	DELETE FROM cjams.afcars_fc_permanency_hearings;
	DELETE FROM cjams.afcars_fc_adoptive_parents_info;
	DELETE FROM cjams.afcars_fc_sex_trafficking;
	
	-- Get date to Classify Child removals under <removal_1993> 
	select settingvalue::date  
		into vd_removal_1993_dt
	from cjams.settings 
	where settingname = 'afcars_1993_removal';	
	
	-- Capture Child Removal Details
	OPEN cur_afcars_client_REFCURSOR FOR
		select afc.fk_id, 
			afc.afcarsfostercareid,
			afc.recordno,
			afc.removalid,
			afc.caseid,
			pr.personid
		from cjams.afcarsfostercare_new afc,
			person pr
		where afc.fk_id::bigint = pr.cjamspid
			and afc.activeflag = '1' 
			-- Unit Test
			-- and pr.cjamspid in ( 2581397, 4403634, 3928221, 1912434, 3502578)
			-- and pr.cjamspid = 2090149
			-- and pr.cjamspid = 4403634
			-- and pr.cjamspid = 3928221
			-- and pr.cjamspid = 1912434
			-- and pr.cjamspid = 3502578
			/*
			and pr.cjamspid in (
					-- For Fewer removals in 23A, compared to ARCARS 1.0 Element # 19 Prior removals.
					-- Code Fix to report Bio client removals
					3841235, 3974379, 3974380, 3908430, 3908431, 3915275, 3924335, 3941725, 3953329, 3099949,
					3195299, 3112645, 3134327, 3163056, 3166074, 3209531, 3231758, 3231759, 3232890, 3260685,
					3379165, 3336126, 3367357, 3367093, 3367186, 3475390, 3478555, 3506275, 3697681, 3729038, 
					3738530, 3741192, 4091101, 4025894, 4028435, 4040404, 4057650, 4145715, 4200145, 1728846,
					2802276, 2960379, 2195925, 2111284, 2145907, 2150332, 2150333, 2291306, 2316802, 2633987,
					2640181, 2712191, 2744632 
 					-- Dropped Removals in 23A
					-- Code Fix to report removal based on the exit transaction time 
					,3820379, 4064588, 4146728, 4287651, 4203803, 4440440, 4456862, 1789867, 2153452, 200836372,
					200836371, 200923463, 200923464, 200923466, 200146725
					
					-- For Fewer living arrangements in 23A, compared to ARCARS 1.0 Element # 24 LAs/Placements
					-- Code Fix to report each CPA home as a separate placement entry
					,3899819, 3810637, 3823039, 3843819, 3843821, 3869705, 3972581, 3909246, 3920372, 3933855,
					3945957, 3961446, 3961447, 3036781, 3199500, 3130149, 3147392, 3159889, 3285743, 3232703,
					3372278, 3315940, 3340392, 3419686, 3592843, 3532037, 3673922, 3619436, 3610356, 3668905,
					3783833, 3701188, 3739311, 3768464, 3769476, 4047438, 4189245, 4135940, 4130154, 4143122,
					4143121, 4149405, 4243124, 4258672, 4313209, 4418840, 1885853, 1898110, 1862300, 1864992,
					1902808, 1959453, 1004421, 1015571, 1583157, 1516155, 1678538, 1680991, 1680945, 1665485,
					1715407, 1720286, 1720302, 1720303, 1737107, 1737100, 2911156, 2052805, 2186050, 2279167,
					2306116, 2353695, 2508895, 2606258, 2620656, 2661927, 2720435, 200014719
							   )
			-- and afc.removalid = '198800'
			*/
		;
	loop
		fetch cur_afcars_client_REFCURSOR into cur_afcars_client;
		exit when not found;
	
		-- Reset
		vs_client_id := NULL;
		vs_afcarsfostercareid := NULL;
		vs_recordno := NULL;
		vs_removalid := NULL;
		vu_personid := NULL;
		vs_servicecaseid := NULL;
		
		vs_client_id := cur_afcars_client.fk_id;
		vs_afcarsfostercareid := cur_afcars_client.afcarsfostercareid;
		vs_recordno := cur_afcars_client.recordno;
		vs_removalid := cur_afcars_client.removalid;
		vs_servicecaseid := cur_afcars_client.caseid;
		vu_personid := cur_afcars_client.personid;
		
		-- RAISE NOTICE 'vs_client_id >> %',vs_client_id;
		
		-- Get Client Level Data
		vs_E35_school_enrollment := NULL; 
		vs_E36_school_highest_completed := NULL; 
		vs_E37_school_special_education := NULL;	
		vs_E38_pregnant := NULL;	
		vs_E39_fathered_or_bore_child := NULL;	 
		vs_E40_child_and_children_together := NULL;	
					
		select (case when ped.schoolenrolltypekey = 'NTE' then -- Not Enrolled
					'0' --  Not enrolled
				when ped.schoolenrolltypekey = 'NTSA' then -- Not school-age
					'1' -- Not school age
				when ped.schoolenrolltypekey = 'ELSC' then-- Elementary school
					'2' -- Elementary school
				when ped.schoolenrolltypekey = 'SESC' then -- Secondary school
					'3' -- Secondary school
				when ped.schoolenrolltypekey = 'PSEOT' then -- Post-secondary education or training
					'4' --Postsecondary education or training
				when ped.schoolenrolltypekey = 'COLLG' then	-- College
					'5' --  College 
				end) as E35_school_enrollment , 
				-- currentgradetypekey, 
				(case when ped.highestgradetypekey = 'PSHS' then --	Pre School / Head Start
					'16' -- Not school age
				when ped.highestgradetypekey = 'KDGN' then -- Kindergarten
					'0' --  Kindergarten
				when ped.highestgradetypekey = 'GDO' then -- Grade 1
					'1' -- First grade
				when ped.highestgradetypekey = 'GDTW' then -- Grade 2
					'2' -- Second grade
				when ped.highestgradetypekey = 'GDTH' then -- Grade 3
					'3' -- Third grade
				when ped.highestgradetypekey = 'GDFO' then -- Grade 4
					'4' -- Fourth grade
				when ped.highestgradetypekey = 'GDFI' then -- Grade 5
					'5' -- Fifth grade
				when ped.highestgradetypekey = 'GDSI' then -- Grade 6
					'6' -- Sixth grade
				when ped.highestgradetypekey = 'GDSE' then -- Grade 7
					'7' -- Seventh grade
				when ped.highestgradetypekey = 'GDEI' then -- Grade 8
					'8' -- Eight grade
				when ped.highestgradetypekey = 'GDNI' then -- Grade 9
					'9' -- Ninth grade
				when ped.highestgradetypekey = 'GDTE' then -- Grade 10
					'10' -- 10th grade
				when ped.highestgradetypekey = 'GDEL' then -- Grade 11
					'11' -- 11th grade 
				when ped.highestgradetypekey = 'GDTWL' then -- Grade 12
					'12' -- 12th grade
				when ped.highestgradetypekey = 'PSET' then -- Post Secondary Education or Training
					'14' -- Postsecondary
				when ped.highestgradetypekey = 'COL' then -- College
					'15' -- College
				when ped.highestgradetypekey = 'UNK' then -- Unknown 
					null
				when ped.highestgradetypekey = 'NIS' then -- Not In School
					'16' -- Not school age
				when ped.highestgradetypekey = 'GED' then -- GED
					'13' -- GED
				end) as E36_school_highest_completed,	 
				(case when isspecialeducation = 'true' then
					'1' -- Yes
				 else
					'0' -- No
				 end) as E37_school_special_education
		into vs_E35_school_enrollment, 
			vs_E36_school_highest_completed, 
			vs_E37_school_special_education	 
		from personeducation ped,
			referencevalues rv 
		where ped.highestgradetypekey = rv.ref_key
			and ped.personid = vu_personid
			and ped.activeflag = 1
			and rv.activeflag = 1
			and rv.referencetypeid = 185
		-- 04/17/2025	
		-- order by rv.displayorder desc 
		order by (case when rv.ref_key = 'NIS' then 
					0
				  when rv.ref_key = 'UNK' then 
					-1 
				  else 
					rv.displayorder
				 end) desc
		limit 1;	
		
		select (case when psx.ispregnant = true then
						'1' -- Yes
				else
					'0' -- No
				end ) as E38_pregnant, 
				(case when psx.isfatheredachild = true then
					'1' -- Yes	
				else
					'0' -- No
				end		
				) as E39_fathered_or_bore_child,
				(case when psx.currentlyparenting = true then
					'1' -- Yes	
				else
					'0' -- No
				end	) as E40_child_and_children_together 
		into vs_E38_pregnant,
			vs_E39_fathered_or_bore_child, 
			vs_E40_child_and_children_together
		from personsexualinfo psx 
		where psx.personid = vu_personid
			and psx.activeflag = 1
		order by psx.insertedon desc 
		limit 1;	
		
		
		-- Get Siblings
		vl_rel_cnt1	:= 0;	
		vl_rel_cnt2	:= 0;
		vl_sibling	:= 0;			
		
		/*
		select count(distinct ac1.person2id) 
			into vl_rel_cnt1
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and ac1.person1id = vu_personid 
			and ac1.person2id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 ;		
	
		select count(distinct ac1.person1id) 
			into vl_rel_cnt2
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
			and ac1.person2id = vu_personid	
			and ac1.person1id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 ;
		
		vl_sibling := coalesce(vl_rel_cnt1) + coalesce(vl_rel_cnt2) ;
		*/
		
		select count(distinct sbl_personid)
			into vl_sibling
		from (
			select ac1.person2id as sbl_personid
			from actorrelationship ac1
			where ac1.servicecaseid
				= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
				and ac1.person1id = vu_personid 
				and ac1.person2id <> vu_personid
				and ac1.relationshiptypekey 
					in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
					'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
					'stepsibling', 'siblingadp', 'fostersibling'
				   )
			and ac1.activeflag = 1 
			union all 
			select ac1.person1id as sbl_personid
			from actorrelationship ac1
			where ac1.servicecaseid
				= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
				and ac1.person2id = vu_personid	
				and ac1.person1id <> vu_personid
				and ac1.relationshiptypekey 
					in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
					'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
					'stepsibling', 'siblingadp', 'fostersibling'
				   )
			and ac1.activeflag = 1 
		) tb_sbl;
		
		-- For e57 siblings child removals 
		vl_ch_rem_sibling := 0;
		vl_ch_rem_sibling_cnt1 := 0;
		vl_ch_rem_sibling_cnt2 := 0;
				
		/*
		select sum(( select count(*)
				from intakeservreqchildremoval rm
				where rm.personid = ac1.person2id
				and rm.servicecaseid = ac1.servicecaseid
				and rm.removaldate is not null
				-- 02/26/2025
				and ( case when rm.exitdate is not null then 	
						rm.removaldate::date <> rm.exitdate::date
					else 
						true
					end)	
				and (
						(rm.removaldate::DATE >=  vdt_from::date  AND rm.removaldate::DATE <= vdt_to::DATE) 
						OR
						(
							(
								(case when rm.exitdate is not null then -- 10/29/2025
									nullif(rm.returntransts,'1900-01-01')::date >= vdt_from::date 
									OR 
									nullif(rm.returntransts,'1900-01-01') is null
								else
									true
								end)	
							) 
							and rm.removaltransts::date <= vdt_to::DATE
						) 
						AND 
							(case when rm.exitdate is not null then -- 10/29/2025
								(((rm.removaltime is null  or rm.returntime is null) 
									and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE 
									+ interval '1 day' ) <> rm.removaltransts::date )
								or ( (rm.removaltime is not null and rm.returntime is not null)
									and
									((((rm.exitdate::date - rm.removaldate::date ) * 24 ) 
										- COALESCE(EXTRACT(hour from rm.removaltime),0)  
										+ COALESCE(EXTRACT(hour from rm.returntime),0))  
										-  COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
										+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
										-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
										+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001) >= 24
								))
							else
								true
							end)		
					)
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'CHRR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = rm.intakeservreqchildremovalid::character varying::text
					 ) > 0 
				))
		into vl_ch_rem_sibling_cnt1
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and ac1.person1id = vu_personid 
			and ac1.person2id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
			and ac1.activeflag = 1 ;		

		select sum(( select count(*)
				from intakeservreqchildremoval rm
				where rm.personid = ac1.person2id
				and rm.servicecaseid = ac1.servicecaseid
				and rm.removaldate is not null
				-- 02/26/2025
				and ( case when rm.exitdate is not null then 	
						rm.removaldate::date <> rm.exitdate::date
					else 
						true
					end)	
				and (
						(rm.removaldate::DATE >=  vdt_from::date  AND rm.removaldate::DATE <= vdt_to::DATE) 
						OR
						(
							(
								(case when rm.exitdate is not null then -- 10/29/2025
									nullif(rm.returntransts,'1900-01-01')::date >= vdt_from::date 
									OR 
									nullif(rm.returntransts,'1900-01-01') is null
								else
									true
								end)	
							) 
							and rm.removaltransts::date <= vdt_to::DATE
						) 
						AND 
						(case when rm.exitdate is not null then -- 10/29/2025
							(((rm.removaltime is null  or rm.returntime is null) 
								and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE 
								+ interval '1 day' ) <> rm.removaltransts::date )
							or ( (rm.removaltime is not null and rm.returntime is not null)
								and
								((((rm.exitdate::date - rm.removaldate::date ) * 24 ) 
									- COALESCE(EXTRACT(hour from rm.removaltime),0)  
									+ COALESCE(EXTRACT(hour from rm.returntime),0))  
									-  COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
									+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
									-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
									+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001) >= 24
							))
						else
							true
						end)	
					)
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'CHRR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = rm.intakeservreqchildremovalid::character varying::text
					 ) > 0 
				))
		into vl_ch_rem_sibling_cnt2
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
			and ac1.person2id = vu_personid	
			and ac1.person1id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 ;

		vl_ch_rem_sibling := coalesce(vl_ch_rem_sibling_cnt1, 0) + coalesce(vl_ch_rem_sibling_cnt2, 0) ;
		
		*/
		
		select count(distinct slb_personid)
			into vl_ch_rem_sibling
		from (
		select ( select distinct rm.personid  as slb_personid
					from intakeservreqchildremoval rm
				where rm.personid = ac1.person2id
					and rm.servicecaseid = ac1.servicecaseid
					and rm.removaldate is not null
					-- 02/26/2025
					and ( case when rm.exitdate is not null then 	
							rm.removaldate::date <> rm.exitdate::date
						else 
							true
						end)	
					and (
							(rm.removaldate::DATE >=  vdt_from::date  AND rm.removaldate::DATE <= vdt_to::DATE) 
							OR
							(
								(
									(case when rm.exitdate is not null then -- 10/29/2025
										nullif(rm.returntransts,'1900-01-01')::date >= vdt_from::date 
										OR 
										nullif(rm.returntransts,'1900-01-01') is null
									else
										true
									end)	
								) 
								and rm.removaltransts::date <= vdt_to::DATE
							) 
							AND 
								(case when rm.exitdate is not null then -- 10/29/2025
									(((rm.removaltime is null  or rm.returntime is null) 
										and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE 
										+ interval '1 day' ) <> rm.removaltransts::date )
									or ( (rm.removaltime is not null and rm.returntime is not null)
										and
										((((rm.exitdate::date - rm.removaldate::date ) * 24 ) 
											- COALESCE(EXTRACT(hour from rm.removaltime),0)  
											+ COALESCE(EXTRACT(hour from rm.returntime),0))  
											-  COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
											+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
											-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
											+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001) >= 24
									))
								else
									true
								end)		
						)
					and ( select count(*)
							   from routing
						  where routing.routingstatustypeid = 16 
							and routing.eventcode::text = 'CHRR'::text 
							and routing.activeflag = 1 
							and routing.objectid::text = rm.intakeservreqchildremovalid::character varying::text
						 ) > 0 
				)
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and ac1.person1id = vu_personid 
			and ac1.person2id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
			and ac1.activeflag = 1 
		union all 
		select ( select distinct rm.personid  as slb_personid
					from intakeservreqchildremoval rm
				where rm.personid = ac1.person1id
					and rm.servicecaseid = ac1.servicecaseid
					and rm.removaldate is not null
					-- 02/26/2025
					and ( case when rm.exitdate is not null then 	
							rm.removaldate::date <> rm.exitdate::date
						else 
							true
						end)	
					and (
							(rm.removaldate::DATE >=  vdt_from::date  AND rm.removaldate::DATE <= vdt_to::DATE) 
							OR
							(
								(
									(case when rm.exitdate is not null then -- 10/29/2025
										nullif(rm.returntransts,'1900-01-01')::date >= vdt_from::date 
										OR 
										nullif(rm.returntransts,'1900-01-01') is null
									else
										true
									end)	
								) 
								and rm.removaltransts::date <= vdt_to::DATE
							) 
							AND 
							(case when rm.exitdate is not null then -- 10/29/2025
								(((rm.removaltime is null  or rm.returntime is null) 
									and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE 
									+ interval '1 day' ) <> rm.removaltransts::date )
								or ( (rm.removaltime is not null and rm.returntime is not null)
									and
									((((rm.exitdate::date - rm.removaldate::date ) * 24 ) 
										- COALESCE(EXTRACT(hour from rm.removaltime),0)  
										+ COALESCE(EXTRACT(hour from rm.returntime),0))  
										-  COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
										+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
										-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
										+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001) >= 24
								))
							else
								true
							end)	
						)
					and ( select count(*)
							   from routing
						  where routing.routingstatustypeid = 16 
							and routing.eventcode::text = 'CHRR'::text 
							and routing.activeflag = 1 
							and routing.objectid::text = rm.intakeservreqchildremovalid::character varying::text
						 ) > 0 
					)
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
			and ac1.person2id = vu_personid	
			and ac1.person1id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 
		) slb_removals
		; 
		
		-- for E58 siblings Provider placements and Living Arrangements
		
		-- Get client's last removal 
		-- Reset
		vu_intakeservreqchildremovalid := null;
		vd_removaldate := null;
		vd_exitdate := null;
			
		select rm.intakeservreqchildremovalid,
			rm.removaldate,
			rm.exitdate 
		into vu_intakeservreqchildremovalid,
			vd_removaldate,
			vd_exitdate
		from intakeservreqchildremoval rm
			join servicecase sc on sc.servicecaseid = rm.servicecaseid 
				and sc.activeflag = 1
		where rm.activeflag = 1
		   and rm.personid = vu_personid
		   and rm.removaldate is not null
		   and rm.removaldate <= vdt_to::DATE
		   -- and rm.exitdate::date <= vdt_from::date
		   -- 02/26/2025
		   and ( case when rm.exitdate is not null then 	
					rm.removaldate::date <> rm.exitdate::date
				else 
					true
				end)	
		   and ( select count(*) 
					from routing rur
				  where rur.objectid = rm.intakeservreqchildremovalid::character varying
					and rur.eventcode = 'CHRR'
					and rur.activeflag = 1
					and rur.routingstatustypeid = '16'
				) > 0
		   -- To exclude removals less than 1 day (24 hours)
			AND (case when rm.exitdate is not null then -- 10/29/2025
					(
						(
							(rm.removaltime is null  or rm.returntime is null) 
							and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE + interval '1 day' ) 
										<> rm.removaltransts::date 
						)
						or 
						( 
							(rm.removaltime is not null and rm.returntime is not null)
							and
							(
								(
									((rm.exitdate::date - rm.removaldate::date ) * 24 )  
										- COALESCE(EXTRACT(hour from rm.removaltime),0)  
										+ COALESCE(EXTRACT(hour from rm.returntime),0)
								)  
								-  
								COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
									+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
									-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
									+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001
							) >= 24
						)
					)	
				else
					true
				end)	
		order by rm.removaldate desc
		limit 1;
			
		-- Find AFCARS Client's last placement during the reporting period  
		vl_pl_rank := null;
		vd_pl_start_dt := null;
		vd_pl_end_dt := null;
		vl_pl_provider_id := null;
		vs_la_type := null;
		vs_pl_type := null;
		vs_caregiver_client_id := null;
		
		vl_fc_la_placemnt_sibling := null;
		
		select pl_rank,
			pl_start_dt::date,
			pl_end_dt::date,
			pl_provider_id,
			la_type,
			pl_type,
			caregiver_client_id
		into vl_pl_rank,
			vd_pl_start_dt,
			vd_pl_end_dt,
			vl_pl_provider_id,
			vs_la_type,
			vs_pl_type,
			vs_caregiver_client_id
		from (
			-- Provider Placement 
			select 2 as pl_rank,
				pl.startdatetime as pl_start_dt, 
				pl.enddatetime as pl_end_dt,
				pl.altproviderid as pl_provider_id, 
				null as la_type,
				'PRPL' as pl_type,
				null::character varying as caregiver_client_id
			from placement pl 
			where pl.personid = vu_personid
				and pl.intakeservreqchildremovalid = vu_intakeservreqchildremovalid
				and pl.activeflag = 1
				-- and la.activeflag = 1
				and pl.altproviderid is not null
				and COALESCE(pl.isvoided, 0) <> 1
				and ( SELECT count(*) AS count
						   FROM routing
					  WHERE routing.routingstatustypeid = 16 
						AND routing.eventcode::text = 'PLTR'::text 
						AND routing.activeflag = 1 
						AND routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				and pl.service_id not in (503, 501)	 
				and ( pl.startdatetime::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
					  or
					  ( pl.startdatetime::date <= coalesce(vd_exitdate, vdt_to::date)::date
						and
						( case when pl.enddatetime is not null then 
							pl.enddatetime::date > vd_removaldate::date
						  else
							True
						end)
					  )	
					)  
				and ( case when pl.enddatetime is not null then   
						pl.startdatetime::date <> pl.enddatetime::date
					  else
						true
					 end) 
				-- NO CPA homes
				and (select count(*) 
						from placementcpahomes cpa 
					where cpa.placementid = pl.placementid 
						and cpa.activeflag = 1
						and cpa.altproviderid is not null
						and cpa.entrydt is not null
						and cpa.entrydt::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
						and ( case when cpa.exitdt is not null then   
								cpa.entrydt::date <> cpa.exitdt::date
							  else
								true
							 end) 
					) = 0	 	 
			union all 
			-- CPA home Placement
			select 1 as pl_rank,
				cpa.entrydt as pl_start_dt, 
				cpa.exitdt as pl_end_dt,
				cpa.altproviderid as pl_provider_id, 
				null as la_type,
				'CPAHM' as pl_type,
				null::character varying as caregiver_client_id
			from placement pl,
				placementcpahomes cpa
			where pl.personid = vu_personid
				and cpa.placementid = pl.placementid 
				and pl.intakeservreqchildremovalid = vu_intakeservreqchildremovalid
				and pl.activeflag = 1
				-- and la.activeflag = 1
				and pl.altproviderid is not null
				and COALESCE(pl.isvoided, 0) <> 1
				and cpa.activeflag = 1
				and cpa.altproviderid is not null
				and cpa.entrydt is not null
				and cpa.entrydt::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
				and ( case when cpa.exitdt is not null then   
						cpa.entrydt::date <> cpa.exitdt::date
					  else
						true
					  end) 
				and ( SELECT count(*) AS count
						   FROM routing
					  WHERE routing.routingstatustypeid = 16 
						AND routing.eventcode::text = 'PLTR'::text 
						AND routing.activeflag = 1 
						AND routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				and pl.service_id not in (503, 501)	 
				and ( pl.startdatetime::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
					  or
					  ( pl.startdatetime::date <= coalesce(vd_exitdate, vdt_to::date)::date
						and
						( case when pl.enddatetime is not null then 
							pl.enddatetime::date > vd_removaldate::date
						  else
							True
						end)
					  )	
					)  
				and ( case when pl.enddatetime is not null then   
						pl.startdatetime::date <> pl.enddatetime::date
					  else
						true
					 end) 
			union all
			-- LA
			select 3 as pl_rank,
				pl.startdatetime as pl_start_dt, 
				pl.enddatetime as pl_end_dt,
				null as pl_provider_id, 
				btrim(la.livingarrangementtypekey) as la_type,
				'LA' as pl_type,
				la.caregiverclientid::character varying as caregiver_client_id
			from placement pl,
				livingarrangement la 
				-- left join person pcr on pcr.personid = la.caregiverclientid and pcr.activeflag= 1 
				-- left join person scr on scr.personid = la.partnerid and scr.activeflag= 1
			where pl.placementid = la.placementid
				and pl.activeflag = 1
				and la.activeflag = 1
				and pl.altproviderid is null
				and pl.personid = vu_personid
				and ( SELECT count(*) AS count
						   FROM routing
					  WHERE routing.routingstatustypeid = 16 
						AND routing.eventcode::text = 'PLTR'::text 
						AND routing.activeflag = 1 
						AND routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				and ( pl.startdatetime::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
					  or
					  ( pl.startdatetime::date <= coalesce(vd_exitdate, vdt_to::date)::date
						and
						( case when pl.enddatetime is not null then 
							pl.enddatetime::date > vd_removaldate::date
						  else
							True
						end)
					  )	
					)  
				and ( case when pl.enddatetime is not null then  
						pl.startdatetime::date <> pl.enddatetime::date
					  else
						true
					 end) 
				and btrim(la.livingarrangementtypekey) 
					NOT In (
								'32944', 'PLMT', 'REC', 'ADPN'
								'FSMPH', -- Father and Step Mother/Paramour Home 
								'FH', -- Father's Home
								'MOFH', -- Mother and Father's Home
								'MOSFPH', -- Mother and Step Father/Paramour Home
								'MOH', -- Mother's Home
								'TVH', -- Trial Visit Home
								'73', -- After care room and board
								'BP', -- Biological Parent
								-- # 2
								'ERM', -- ER Medical
								'IMC', -- Inpatient Medical Care
								'IMCNA', -- Inpatient Medical Care Non-Acute
								'MH', -- Medical Hospital
								'ERP', -- ER Psychiatric 
								'PSYH', -- Inpatient Psychiatric Hospital
								'IPC', -- Inpatient Psychiatric Care
								'ACI', -- Adult Correctional Institution
								'DJS', -- DJS Funded Facility/not detention
								'SJD' -- Secure Juvenile Detention	
							) -- Placement, Respite Care and Adoption ??? 03/04
		) tab	
		order by pl_start_dt::date desc, pl_rank
		limit 1 ;

		If vd_pl_start_dt is not null then
			if vs_pl_type = 'PRPL' and vl_pl_provider_id > 0 then
				select count(distinct pl.personid)
						into vl_fc_la_placemnt_sibling
					from placement pl 
				where pl.activeflag = 1
					and pl.altproviderid = vl_pl_provider_id
					and COALESCE(pl.isvoided, 0) <> 1
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					and pl.service_id not in (503, 501)	 
					and ( pl.startdatetime::date <= coalesce(vd_pl_end_dt, vdt_to::date)::date
							and
							( case when pl.enddatetime is not null then 
								pl.enddatetime::date > vd_pl_start_dt::date
								and 
								pl.enddatetime::date >= vdt_to::date
							  else
								True
							end)
						)	
					and ( case when pl.enddatetime is not null then   
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end) 
					-- NO CPA homes
					and (select count(*) 
							from placementcpahomes cpa 
						where cpa.placementid = pl.placementid 
							and cpa.activeflag = 1
							and cpa.altproviderid is not null
							and cpa.entrydt is not null
						) = 0	
				and pl.personid in 
						(	
							select sbl_personid
							from (
								select ac1.person2id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
									and ac1.person1id = vu_personid 
									and ac1.person2id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								union all 
								select ac1.person1id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
									and ac1.person2id = vu_personid	
									and ac1.person1id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								) 
						); 
							
			elseif vs_pl_type = 'CPAHM' and vl_pl_provider_id > 0 then
				select count(distinct pl.personid)
					into vl_fc_la_placemnt_sibling
				from placement pl,
					placementcpahomes cpa
				where cpa.placementid = pl.placementid 
					and pl.activeflag = 1
					and pl.altproviderid is not null 
					and COALESCE(pl.isvoided, 0) <> 1
					and cpa.activeflag = 1
					and cpa.altproviderid = vl_pl_provider_id
					and cpa.entrydt is not null
					and ( cpa.entrydt::date <= coalesce(vd_pl_end_dt, vdt_to::date)::date
					and
						( case when cpa.exitdt is not null then 
							cpa.exitdt::date > vd_pl_start_dt::date
							and 
							cpa.exitdt::date >= vdt_to::date
						  else
							True
						end)
						  )	
					and ( case when cpa.exitdt is not null then  
							cpa.entrydt::date <> cpa.exitdt::date
						  else
							true
						 end) 
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					and pl.service_id not in (503, 501)	 
					and ( pl.startdatetime::date <= coalesce(vd_pl_end_dt, vdt_to::date)::date
						and
						( case when pl.enddatetime is not null then 
							pl.enddatetime::date > vd_pl_start_dt::date
							and 
							pl.enddatetime::date >= vdt_to::date
						  else
							True
						end)
					  )	
					and ( case when pl.enddatetime is not null then   
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end)	
					and pl.personid in 
						(	
							select sbl_personid
							from (
								select ac1.person2id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
									and ac1.person1id = vu_personid 
									and ac1.person2id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								union all 
								select ac1.person1id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
									and ac1.person2id = vu_personid	
									and ac1.person1id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								) 
						);	
			elseif -- vs_la_type is not null and 
				vs_caregiver_client_id is not null 
				and vs_caregiver_client_id <> '00000000-0000-0000-0000-000000000000' then -- LA
				select count(distinct pl.personid)
					into vl_fc_la_placemnt_sibling
				from placement pl,
					livingarrangement la 
					-- left join person pcr on pcr.personid = la.caregiverclientid and pcr.activeflag= 1 
					-- left join person scr on scr.personid = la.partnerid and scr.activeflag= 1
				where pl.placementid = la.placementid
					and pl.activeflag = 1
					and la.activeflag = 1
					and pl.altproviderid is null
					-- and btrim(la.livingarrangementtypekey) = vs_la_type
					and la.caregiverclientid::character varying  = vs_caregiver_client_id::character varying
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					and ( pl.startdatetime::date <= coalesce(vd_pl_end_dt, vdt_to::date)::date
							and
							( case when pl.enddatetime is not null then 
								pl.enddatetime::date > vd_pl_start_dt::date
								and 
								pl.enddatetime::date >= vdt_to::date
							  else
								True
							end)
						  )	
					and ( case when pl.enddatetime is not null then  
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end) 
					and pl.personid in 
						(	
							select sbl_personid
							from (
								select ac1.person2id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
									and ac1.person1id = vu_personid 
									and ac1.person2id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								union all 
								select ac1.person1id as sbl_personid
								from actorrelationship ac1
								where ac1.servicecaseid
									= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
									and ac1.person2id = vu_personid	
									and ac1.person1id <> vu_personid
									and ac1.relationshiptypekey 
										in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
										'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
										'stepsibling', 'siblingadp', 'fostersibling'
									   )
								and ac1.activeflag = 1 
								) 
						);
			end if;	
		-- else
		--	vl_fc_la_placemnt_sibling := null;
		end if;
		
		if vl_sibling = 0 Then
			vl_fc_la_placemnt_sibling := null;
		else	
			If vl_fc_la_placemnt_sibling is null then 
				vl_fc_la_placemnt_sibling := 0;
			end if;	
		end if;
		
		-- Reset
		vu_intakeservreqchildremovalid := null;
		vd_removaldate := null;
		vd_exitdate := null;
		
		/*
		-- for E58 siblings Provider placements and Living Arrangements
		vl_fc_placemnt_cnt1	:= 0;	
		vl_fc_placemnt_cnt2	:= 0;
		vl_fc_placemnt_sibling := 0;
		
		vl_la_placemnt_cnt1	:= 0;	
		vl_la_placemnt_cnt2	:= 0;
		vl_la_placemnt_sibling:= 0;
		
		select sum(( select count(*)
				from placement pl
				where pl.personid = ac1.person2id
				and pl.servicecaseid = ac1.servicecaseid
				and pl.startdatetime is not null
				and pl.enddatetime is null
				and pl.altproviderid is not null
				and coalesce(pl.isvoided, 0) <> 1
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'PLTR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				)),
				sum(( select count(*)
				from placement pl
				where pl.personid = ac1.person2id
				and pl.servicecaseid = ac1.servicecaseid
				and pl.startdatetime is not null
				and pl.enddatetime is null
				and pl.altproviderid is null
				and coalesce(pl.isvoided, 0) <> 1
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'PLTR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				))
		into vl_fc_placemnt_cnt1,
			vl_la_placemnt_cnt1
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and ac1.person1id = vu_personid 
			and ac1.person2id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 ;		
	
		select sum(( select count(*)
				from placement pl
				where pl.personid = ac1.person1id
				and pl.servicecaseid = ac1.servicecaseid
				and pl.startdatetime is not null
				and pl.enddatetime is null
				and pl.altproviderid is not null
				and coalesce(pl.isvoided, 0) <> 1
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'PLTR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				)),
				sum(( select count(*)
				from placement pl
				where pl.personid = ac1.person1id
				and pl.servicecaseid = ac1.servicecaseid
				and pl.startdatetime is not null
				and pl.enddatetime is null
				and pl.altproviderid is null
				and coalesce(pl.isvoided, 0) <> 1
				and ( select count(*)
						   from routing
					  where routing.routingstatustypeid = 16 
						and routing.eventcode::text = 'PLTR'::text 
						and routing.activeflag = 1 
						and routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				))
		into vl_fc_placemnt_cnt2,
			vl_la_placemnt_cnt2
		from actorrelationship ac1
		where ac1.servicecaseid
			= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
			and ac1.person2id = vu_personid	
			and ac1.person1id <> vu_personid
			and ac1.relationshiptypekey 
				in ('HLFBR', 'BIOBR', 'LEGLBR', 'STPBR', 'BGSISTR', 
				'HLFSISTR', 'LGLSISTR', 'STPSISTR', 'halfsibling', 'naturalsibling',
				'stepsibling', 'siblingadp', 'fostersibling'
			   )
		and ac1.activeflag = 1 ;
		
		vl_fc_placemnt_sibling := coalesce(vl_fc_placemnt_cnt1, 0) + coalesce(vl_fc_placemnt_cnt2, 0) ;
		vl_la_placemnt_sibling := coalesce(vl_la_placemnt_cnt1, 0) + coalesce(vl_la_placemnt_cnt2, 0) ;
		
		
		vl_fc_la_placemnt_sibling := coalesce(vl_fc_placemnt_sibling, 0) + coalesce(vl_la_placemnt_sibling, 0);
		*/
		
		-- TPR Petition Date
		vs_tpr_petition_date := NULL;
		vs_is_trp_contested := NULL; 
		
				
		SELECT cpt.petitiondate::date -- New vs_tpr_petition_date 04/2026
			-- isrch.hearingdatetime::date -- vs_tpr_petition_date
			,(case when isrch.hearingtype::jsonb ? 'TGC' then '2' else '1' end) as is_trp_contested -- 2 = Involuntary
		into vs_tpr_petition_date
			, vs_is_trp_contested
		from intakeservicerequestcourthearing isrch
			inner join intakeservicerequestpetition cpt on cpt.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid
			inner join hearingclients hc on hc.courthearingid = isrch.intakeservicerequestcourthearingid 
			inner join intakeservicerequestpetition isrp 
				on isrch.intakeservicerequestpetitionid = isrp.intakeservicerequestpetitionid 
					and isrch.activeflag=1 
			inner join 
				(	select isrhoc.hearingoutcometypekey as hearingoutcometypekey, 
						isrco.courtorderdate as courtorderdate, 
						isrco.servicecaseid as servicecaseid
					from intakeservreqcourtorder isrco 
						join Intakeservreqcohearingoutcome isrhoc 
							on isrco.intakeservreqcourtorderid = isrhoc.intakeservreqcourtorderid 
								and isrhoc.activeflag = 1 
								and isrhoc.hearingoutcometypekey in ('TPRGRA', 'TPRDEN')
					where servicecaseid 
						= (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
					order by isrco.updatedon desc limit 1
				) as isrco1 on isrco1.servicecaseid = isrch.servicecaseid
			left join hearingstatustype hst on hst.hearingstatustypekey = isrch.hearingstatustypekey 
				and hst.activeflag = 1
			left join petitiontype pt on pt.petitiontypekey = isrp.petitiontypekey 
				and pt.activeflag=1    
			left join hearingtype ht ON (	ht.hearingtypekey = isrch.hearingtypekey 
											OR 
											isrch.hearingtype ? ht.hearingtypekey
										) 
				and ht.activeflag=1 						
			left join referencevalues rfv on rfv.ref_key = isrco1.hearingoutcometypekey 
				and rfv.activeflag = 1 
				and rfv.referencetypeid = 32
			left join person p ON p.personid = isrch.intakeservicerequestpetitionid 
				and p.activeflag = 1     
		where isrch.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and hc.personid = vu_personid
			and (isrch.hearingtype::jsonb ? 'TGC' or isrch.hearingtype ::jsonb ? 'TGU')
			and hc.otherclientflag = 0
		order by isrch.updatedon desc
		limit 1 ;
		
		/*
		select ch.hearingdatetime::date
			into vs_tpr_petition_date
		from intakeservicerequestcourthearing ch,
			hearingclients chl,
			intakeservreqcourtorder crt,
			Intakeservreqcohearingoutcome isrhoc
		where ch.intakeservicerequestcourthearingid = chl.courthearingid
			and chl.courthearingid = crt.intakeservicerequesthearingid
			and crt.intakeservicerequesthearingid = ch.intakeservicerequestcourthearingid
			and isrhoc.intakeservreqcourtorderid = crt.intakeservreqcourtorderid
			and ch.servicecaseid = 
				(select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )
			and ch.activeflag = 1
			and chl.activeflag = 1
			and crt.activeflag = 1
			and isrhoc.activeflag = 1
			and chl.personid = vu_personid
			and isrhoc.hearingoutcometypekey = 'TPRGRA' -- TPR Granted
			and ch.hearingdatetime::date >= vdt_from::date -- and vdt_to::date
		order by ch.hearingdatetime::date desc
		limit 1 ;
		*/
		
		-- Get Monther TPR info
		vs_mothertprdate := NULL;
		vs_is_monther_trp_contested := NULL;
		
		select to_char(td.tprdecisiondate::date, 'YYYYMMDD'), 
			(case when td.iscontested = true then '2' else '1' end)
		into vs_mothertprdate,
			vs_is_monther_trp_contested
		FROM tprdetails td
			INNER JOIN tprrecommendation tpr ON tpr.tprrecommendationid = td.tprrecommendationid
				and 
				 -- case when coalesce(vu_personid::character varying, '') <> '' 
				--	then
						tpr.intakeservicerequestactorid in 
							(select i.intakeservicerequestactorid from intakeservicerequestactor i 
							where i.personid = vu_personid::uuid)
				--	else 1 = 1 
				-- end
			INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = td.intakeservicerequestactorid 
			INNER JOIN intakeservicerequestactor isra1 ON isra1.intakeservicerequestactorid = tpr.intakeservicerequestactorid 
			INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
			INNER JOIN (	
				SELECT DISTINCT ira.personid
					FROM   permanencyplan pp
						   INNER JOIN intakeservicerequestactor ira 
							ON ira.intakeservicerequestactorid = pp.intakeservicerequestactorid
					WHERE  pp.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
					) as cp ON cp.personid = isra1.personid
				LEFT JOIN servicetype st ON st.servicetypekey=td.servicetypekey AND st.activeflag=1
				LEFT JOIN actortype at on at.actortype = isra.intakeservicerequestpersontypekey
		WHERE (td.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
		   OR td.servicecaseid = (SELECT 	biologicalcaseid
								FROM 	biologicaladoptionlink bio
										INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = bio.preadoptivecaseid
								WHERE 	ap.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )	
		   )) 
		   AND td.activeflag = 1
		   and ( td.relationshiptypekey = 'BGMTHR' or p.gendertypekey in ('F', 'TGIM') ) 
		   -- and td.isgranted = true
		order by td.insertedon desc limit 1
 	    ;  
		   
		
		-- Get Father TPR info
		vs_fathertprdate := NULL;
		vs_is_father_trp_contested := NULL;
		
		select to_char(td.tprdecisiondate::date, 'YYYYMMDD'), 
			(case when td.iscontested = true then '2' else '1' end)
		into vs_fathertprdate,
			vs_is_father_trp_contested
		FROM tprdetails td
			INNER JOIN tprrecommendation tpr ON tpr.tprrecommendationid = td.tprrecommendationid
				and 
				 -- case when coalesce(vu_personid, '') <> '' 
				--	then
						tpr.intakeservicerequestactorid in 
							(select i.intakeservicerequestactorid from intakeservicerequestactor i 
							where i.personid = vu_personid::uuid)
				--	else 1 = 1 
				-- end
			INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = td.intakeservicerequestactorid 
			INNER JOIN intakeservicerequestactor isra1 ON isra1.intakeservicerequestactorid = tpr.intakeservicerequestactorid 
			INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
			INNER JOIN (	
				SELECT DISTINCT ira.personid
					FROM   permanencyplan pp
						   INNER JOIN intakeservicerequestactor ira 
							ON ira.intakeservicerequestactorid = pp.intakeservicerequestactorid
					WHERE  pp.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
					) as cp ON cp.personid = isra1.personid
				LEFT JOIN servicetype st ON st.servicetypekey=td.servicetypekey AND st.activeflag=1
				LEFT JOIN actortype at on at.actortype = isra.intakeservicerequestpersontypekey
		WHERE (td.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid ) 
		   OR td.servicecaseid = (SELECT 	biologicalcaseid
								FROM 	biologicaladoptionlink bio
										INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = bio.preadoptivecaseid
								WHERE 	ap.servicecaseid = (select servicecaseid from servicecase where servicecasenumber = vs_servicecaseid )	
		   )) 
		   AND td.activeflag = 1
		   and ( td.relationshiptypekey = 'BGFTHR' or p.gendertypekey in ('M', 'TGIF') ) 
		   -- and td.isgranted = true
		order by td.insertedon desc limit 1
 	    ;  
		   
		-- CIDM-8211- New E55 Logic - Start
		vs_ivefostercareflag := NULL;
		vs_ive_status_cd := NULL;
		vs_ive_payment_check := 'N';
		
		vd_entry_dt := NULL;
		vd_exit_dt := NULL;
		vd_qrtp_14day := NULL;
		
		vl_2913_count := NULL;
		vl_service_id := NULL;
		vl_qrtp_provider_org_id := NULL;
		vl_qrtp_count := NULL;
		
		vl_ive_payment_count := NULL;
		vl_ive_stamping_count := NULL;
		
		-- Check for most recent entered determination status
		select btrim(ep.status_cd) 
			into vs_ive_status_cd
			from tb_eligibility_period ep
		where ep.delete_sw = 'N'
			and ep.status_cd is not null
			and btrim(ep.status_cd) <> ''
			and ep.eligibility_id 
				in ( select eligibility_id
						from tb_client_eligibility ce
					where ce.client_id = vs_client_id::bigint
						and ce.delete_sw = 'N'
					order by ce.start_dt desc, eligibility_id desc
					-- limit 1
				)
		order by ep.create_ts desc
		limit 1;	

		-- Check if the client was eligible for any determination during the same AFCARS period
		select count(*)
			into vl_2913_count
		from tb_eligibility_period ep
		where ep.delete_sw = 'N'
			and btrim(ep.status_cd) = '2913' -- Eligible Reimbursable
			and ep.start_dt <= vdt_to::date 
			and (ep.end_dt::date >= vdt_from::date OR ep.end_dt IS NULL) 
			and ep.eligibility_id 
				in (	select eligibility_id
						from tb_client_eligibility ce
					where ce.client_id = vs_client_id::bigint
						and ce.delete_sw = 'N'
					order by ce.start_dt desc, eligibility_id desc
					-- limit 1
					);

		if vs_ive_status_cd = '2913' or vl_2913_count > 0 then
			-- Check client's most recent Provider Placement 
			select pl.service_id, 
				-- pl.altproviderid,
				pl.providerorganizationid,
				pl.startdatetime::date,
				pl.enddatetime::date,
				pl.startdatetime::date + interval '14 days'
			into vl_service_id,
				vl_qrtp_provider_org_id,
				vd_entry_dt,
				vd_exit_dt,
				vd_qrtp_14day
			from placement pl 
			where pl.personid = vu_personid
				and pl.activeflag = 1
				and pl.altproviderid is not null
				and COALESCE(pl.isvoided, 0) <> 1
				and ( SELECT count(*) AS count
						   FROM routing
					  WHERE routing.routingstatustypeid = 16 
						AND routing.eventcode::text = 'PLTR'::text 
						AND routing.activeflag = 1 
						AND routing.objectid::text = pl.placementid::character varying::text
					 ) > 0 
				and ( case when pl.enddatetime is not null then   
						pl.startdatetime::date <> pl.enddatetime::date
					  else
						true
					 end) 
				and pl.startdatetime::date <= vdt_to::date 
				and ( pl.enddatetime is null or pl.enddatetime::date >= vdt_from::date )
			order by pl.startdatetime desc
			limit 1	;
			
			-- 14	Residential Group Homes
			-- 167	Therapeutic Group Homes

			if vl_service_id in ( 14, 167 ) and vl_qrtp_provider_org_id is not null then
				-- If the placement started prior to 10/1/19 and is still active
				if vd_entry_dt < '2019-10-01'::date and vd_exit_dt is not null then
					-- proceed to payment check step
					vs_ive_payment_check := 'Y';
				else
					-- RAISE NOTICE 'QRTP check vs_client_id >> %',vs_client_id;
					
					-- If the placement started on or after 10/1/19, check the provider
					-- If the provider is one of the following 
					select count(*) 
						into vl_qrtp_count
					from cjams.afcars_fc_qrtp_providers qrtp
					where qrtp.activeflag = 1
						and qrtp.provider_id = vl_qrtp_provider_org_id;
					
					if vl_qrtp_count > 0 then 
						-- RAISE NOTICE 'QRTP Provider vl_qrtp_provider_org_id >> %',vl_qrtp_provider_org_id;
					
						-- at least one day of the first 14 days of the placement falls during the AFCARS report period, 
						if vd_entry_dt <= vdt_to::date 
							and vd_qrtp_14day >= vdt_from::date then
							-- Proceed to the payment check 
							vs_ive_payment_check := 'Y';
						else
							vs_ivefostercareflag := '0'; -- E55 mark as 0	
						end if;		
					else
						vs_ivefostercareflag := '0'; -- E55 mark as 0	
					end if;	
				end if;	
			else
				-- Proceed to the payment check 
				vs_ive_payment_check := 'Y';
			end if;
			
			
			if vs_ive_payment_check = 'Y' then
				-- check for least one maintenance payment (coded 21XX) during the AFCARS report period
				-- or any payment which was re-stamped with 21xx code in the same reporting period
				
				-- 21xx Payment check
				select count(*)
					into vl_ive_payment_count
				from tb_payment_header ph,
					tb_payment_detail pd,
					tb_payment_status ps		
				where ph.payment_id = pd.payment_id 	
					and ph.payment_id = ps.payment_id
					and ph.payment_type_cd = '6' -- Maintenance
					and pd.client_id = vs_client_id::bigint
					and ph.delete_sw = 'N'
					and pd.delete_sw = 'N'
					and ps.delete_sw = 'N'
					and pd.placement_id is not null
					and pd.final_amount_no > 0
					and ps.payment_status_cd = '1636'
					and pd.final_service_start_dt::date <= vdt_to::date
					and pd.final_service_end_dt::date >= vdt_from::date 
					and btrim(pd.final_fiscal_category_cd) like '21%'
					-- To exclude 21 payments if re-stammped to 71 
					and (select count(*)
							from tb_fund_allocation_master fm
						where fm.payment_detail_id = pd.payment_detail_id
							and fm.delete_sw = 'N'
							and fm.ive_funding_amt = 0 -- <> 21xx 
						) = 0	
				;
					
				-- 21xx Payment Stamping check
				select count(*)
					into vl_ive_stamping_count
				from tb_payment_header ph,
					tb_payment_detail pd,
					tb_payment_status ps,
					tb_fund_allocation_master fm
				where ph.payment_id = pd.payment_id 	
					and ph.payment_id = ps.payment_id
					and pd.payment_detail_id = fm.payment_detail_id 
					and ph.payment_type_cd = '6' -- Maintenance
					and pd.client_id = vs_client_id::bigint
					and ph.delete_sw = 'N'
					and pd.delete_sw = 'N'
					and ps.delete_sw = 'N'
					and fm.delete_sw = 'N'
					and pd.placement_id is not null
					and pd.final_amount_no > 0
					and ps.payment_status_cd = '1636'
					and pd.final_service_start_dt::date <= vdt_to::date
					and pd.final_service_end_dt::date >= vdt_from::date 
					and fm.fund_allocation_date::date between vdt_from::date and vdt_to::date -- Stamping Date
					and fm.ive_funding_amt > 0 -- 21xx
				;	
								
				if vl_ive_payment_count > 0 or vl_ive_stamping_count > 0 then
					vs_ivefostercareflag := '1'; -- E55 mark as 1			
				else
					vs_ivefostercareflag := '0'; -- E55 mark as 0			
				end if;
			else -- exception ???
				vs_ivefostercareflag := '0'; -- E55 mark as 0			
			end if;
		else
			vs_ivefostercareflag := '0'; -- E55 mark as 0			
		end if;
		-- CIDM-8211- New E55 Logic - End
		
		INSERT INTO cjams.afcars_fc_client_data
			(	afcarsfostercareid, 
				recordno, 
				cjamspid, 
				e1_title_iv_agency, 
				e2_report_date, 
				e3_local_agency, 
				e4_child_record_number, 
				e5_date_of_birth, 
				e6_sex, 
				e7_agency_made_inquiries, 
				e8_tribal_membership, 
				e10_icwa, 
				e11_icwa_date, 
				e12_icwa_notification, 
				e13_child_race_american_indian_alaska_native, 
				e14_child_race_asian, 
				e15_child_race_black, 
				e16_child_race_native_hawaiian_pacific_islander, 
				e17_child_race_white, 
				e18_child_race_unknown, 
				e19_child_race_abandoned, 
				e20_child_race_declined, 
				e21_child_hispanic_latino, 
				e22_health_assessment, 
				e23_health_conditions, 
				e24_health_intellectual_disability, 
				e25_health_autism_spectrum_disorder, 
				e26_health_visual_impairment, 
				e27_health_hearing_impairment, 
				e28_health_orthopedic_impairment, 
				e29_health_mental_disorder, 
				e30_health_adhd_add, 
				e31_health_serious_mental_disorder,
				e32_health_developmental_delay, 
				e33_health_developmental_disability, 
				e34_health_other_condition, 
				e35_school_enrollment, 
				e36_school_highest_completed, 
				e37_school_special_education, 
				e38_pregnant, 
				e39_fathered_or_bore_child, 
				e40_child_and_children_together, 
				e41_prior_adoption, 
				e42_prior_adoption_date, 
				e43_prior_adoption_intercountry, 
				e44_prior_guardianship, 
				e45_prior_guardianship_date, 
				e46_support_assistance, 
				e47_state_tribal_adoption_assistance, 
				e48_state_tribal_foster_care, 
				e49_adoption_subsidy,
				e50_guardianship_assistance, 
				e51_tanf_assistance, 
				e52_title_iv_b, 
				e53_chafee_foster_program, 
				e54_other_financial_support, 
				e55_foster_care_payment, 
				e56_total_siblings, 
				e57_siblings_in_foster_care, 
				e58_siblings_in_living_arrangement, 
				e59_first_parent_birth_year, 
				e60_second_parent_birth_year, 
				e61_tribal_membership_mother, 
				e62_tribal_membership_father, 
				e63_tpr_parent1, 
				e64_tpr_parent2, 
				e65_tpr_petition_date_parent1, 
				e66_tpr_petition_date_parent2, 
				e67_tpr_date_parent1, 
				e68_tpr_date_parent2
			)
		select afc1.afcarsfostercareid,
			afc1.recordno,
			afc1.fk_id,
			afc1.statetypekey as e1_title_iv_agency,
			afc1.reportpdenddate as e2_report_date, 	
			afc1.localagencytypekey as e3_local_agency,
			afc1.recordno as e4_child_record_number,
			coalesce( substring( afc1.childdob::varchar, 1,4 )
				||	substring( afc1.childdob::varchar, 6,2 )
				|| 	substring( afc1.childdob::varchar, 9,2 ),' ' ) as e5_date_of_birth,
			
			(case when btrim(pr1.gendertypekey) = 'M' Then	-- Male
				'1' -- Male 
			when btrim(pr1.gendertypekey) = 'TGIF' Then -- Transgender- Identifies as Female
				'1' -- Male 
			when btrim(pr1.gendertypekey) = 'TGIM' Then -- Transgender- Identifies as Male
				'2' -- Female 
			when btrim(pr1.gendertypekey) = 'F' Then -- Female	
				'2' -- Female 
			-- Changes for newly added gender type/substype 
			when btrim(pr1.gendertypekey) = 'O' and pr1.othergendertypekey = 0 then -- Assigned Male at Birth *
				'1' -- Male 
			when btrim(pr1.gendertypekey) = 'O' and pr1.othergendertypekey = 1 then -- Assigned Female at Birth *
				'2' -- Female 
			else
				null -- O Other
			end ) as e6_sex, -- afc1.gendertypekey 

			(case when upper(pr1.icwastatusinquiry) = 'YES' then 
				'1' -- Yes 
			 when upper(pr1.icwastatusinquiry) = 'NO' then
				'0' -- No 
			 else
				'0' -- No -- For Compliance cannot be Empty
			end) as e7_agency_made_inquiries,
			(case when upper(pr1.icwaeligibleformembership) = 'YES' then 
				'1' -- Yes 
			 when upper(pr1.icwaeligibleformembership) = 'NO' then
				'0' -- No 
			 else
				'9' -- Unknown
			end) as e8_tribal_membership, 
			-- e9_recognized_tribes (Child table)
			(case when upper(pr1.icwaunderdefinition) = 'YES' then 
				'1' -- Yes 
			 when upper(pr1.icwaunderdefinition) = 'NO' then
				'0' -- No 
			 else
				'9' -- Unknown
			end) as e10_icwa,  
			(case when upper(pr1.icwaunderdefinition) = 'YES' then 
				pr1.icwanotification 
			else
				null
			end) as e11_icwa_date, 
			(case when upper(pr1.icwaunderdefinition) = 'YES' then 
				(case when upper(pr1.icwatribelegalnotice) = 'YES' then
					'1' -- Yes
				else
					'0' -- No 	
				end)	
			else
				NULL -- For Compliance send NULL (Not applicable)
			end) as e12_icwa_notification,
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key in ('AI', 'AN' )
			) as e13_child_race_american_indian_alaska_native, -- afc1.raceaitypekey
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'AS'
			) as e14_child_race_asian, -- afc1.raceasiantypekey
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'BA'
			) as e15_child_race_black, -- afc1.raceblacktypekey
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'PI'
			) as e16_child_race_native_hawaiian_pacific_islander, -- afc1.racehawaiiantypekey 
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'WH'
			) as e17_child_race_white, -- afc1.racewhitetypekey 
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'UN'
			) as e18_child_race_unknown, -- afc1.raceuntypekey 
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'AB'
			) as vs_e19_child_race_abandoned, 
			
			(select (case when count(*) > 0 then '1' else '0' end) 
				from personracetypemap prt,
					referencevalues race 
				where race.ref_key = prt.racetypekey
					and prt.personid = pr1.personid
					and prt.activeflag = 1
					and race.referencetypeid = 171
					and race.ref_key = 'DC'
			) as vs_e20_child_race_declined,
			
			(case when btrim(pr1.ethnicgrouptypekey) = 'H' then -- Hispanic or Latino
				'1' 
			 when btrim(pr1.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
				'0'
			 when btrim(pr1.ethnicgrouptypekey) = 'D' then  
				'8'
			 else 
				'9' -- Unknown
			 end ) as e21_child_hispanic_latino, -- afc1.hispanictypekey
						
			(select (case when count(*) > 0 then '1' else '0' end)
				from personexamination pat
			 where pat.personid = pr1.personid
				-- and appoinmentdate::date is not null
				and btrim(pat.examinationtypekey) in ( '3255', '3256', '7833' )
				and pat.activeflag = 1
			) as e22_health_assessment,	
			
			-- 3255	Initial Health Screening Examination
			-- 3256	Comprehensive Health Examination
			-- 7833	Well child examination (EPSDT)
			(case when 
				(select count(*)
					from persondisability pds,
						referencevalues rfn
				where btrim(pds.disabilitytypekey) = btrim(rfn.ref_key)  
					and pds.personid = pr1.personid
					and rfn.referencetypeid  = 97
					and coalesce(rfn.teamtypekey, 'CW') = 'CW'
					and pds.activeflag = 1
					and rfn.activeflag = 1
				) = 0  then 
				'0' -- No exam or assessment conducted
			when 
				(select count(*)
					from persondisability pds,
						referencevalues rfn
				where btrim(pds.disabilitytypekey) = btrim(rfn.ref_key)  
					and pds.personid = pr1.personid
					and rfn.referencetypeid = 97
					and coalesce(rfn.teamtypekey, 'CW') = 'CW'
					and pds.activeflag = 1
					and rfn.activeflag = 1
					and lower(coalesce(pds.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then 
				'1' -- Child has a diagnosed condition
			when 
				(select count(*)
					from persondisability pds,
						referencevalues rfn
				where btrim(pds.disabilitytypekey) = btrim(rfn.ref_key)  
					and pds.personid = pr1.personid
					and rfn.referencetypeid = 97
					and coalesce(rfn.teamtypekey, 'CW') = 'CW'
					and pds.activeflag = 1
					and rfn.activeflag = 1
					and lower(coalesce(pds.disabilityconditiontypekey, 'unknown')) not in ('unknown', 'yes')
				) = 0 then
				'2' -- Exam or assessment conducted and none of the conditions apply
			else 
				'0' -- No exam or assessment conducted 	-- For Compliance cannot be missing or empty.
			-- No mapping for ??
			-- 3 = Exam or assessment conducted but results not received
			end ) as e23_health_conditions,
			
					
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'INDIS' -- Intellectual Disability
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e24_health_intellectual_disability,
			
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)						
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'AUTDIS' -- Autism Spectrum Disorder
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e25_health_autism_spectrum_disorder, 
			
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)		
				from persondisability pds
			where personid = pr1.personid
				and pds.disabilitytypekey = 'VIDY' -- Visual Impairment and Blindness
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e26_health_visual_impairment, 
			
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)		
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'HDY' -- Hearing Impairment and Deafness
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e27_health_hearing_impairment, 
			
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'PYDY' -- Orthopedic Impairment or Other Physical Condition
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e28_health_orthopedic_impairment, 
			
			coalesce(
			(select ( case when coalesce(doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'EMDY' -- Mental/Emotions Disorder
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e29_health_mental_disorder, 
			
			coalesce(
			(select ( case when coalesce(pds.doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(pds.existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(pds.previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'ADHDS' -- Attention Deficit Hyperactivity Disorder
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e30_health_adhd_add, 
			
			coalesce(
			(select ( case when coalesce(pds.doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(pds.existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(pds.previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'SMD' -- Serious Mental Disorders
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e31_health_serious_mental_disorder,
			
			coalesce(
			(select ( case when coalesce(pds.doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					when coalesce(pds.existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(pds.previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)	
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'MRD' -- Developmental Delay
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e32_health_developmental_delay, 
			
			coalesce(
			(select ( case when coalesce(pds.doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(pds.existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(pds.previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)		
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'DEVD' -- Developmental Disability
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e33_health_developmental_disability, 
			
			coalesce(
			(select ( case when coalesce(pds.doesnotapply, 'false') = 'true' then
						'0' --Does not apply
					 when coalesce(pds.existingcondition, 'false') = 'true' then	
						'1' -- Existing condition
					when coalesce(pds.previouscondition, 'false') = 'true' then	
						'2' -- Previous condition
					else
						null
					end)		
				from persondisability pds
			where pds.personid = pr1.personid
				and pds.disabilitytypekey = 'ODY' -- Other Diagnosed Condition
				and pds.activeflag = 1
			order by pds.insertedon desc
			limit 1	
			),
			( case when 
				(select count(*)
					from persondisability pds1
				 where pds1.personid = pr1.personid
					and pds1.activeflag = 1
					and lower(coalesce(pds1.disabilityconditiontypekey, 'unknown')) = 'yes'
				) > 0 then '0' else null 
			end)
			) as e34_health_other_condition, 
			
			-- 04/21/2025	
			/*
			(case when vs_E36_school_highest_completed = '16' then -- Not school age
				'1' -- Not school age 
			else
				coalesce(vs_E35_school_enrollment, '0')  -- 0 Not enrolled
			end) as vs_E35_school_enrollment, -- For Compliance Not enrolled
			*/
			coalesce(vs_E35_school_enrollment, '0') as vs_E35_school_enrollment, 
			
			vs_E36_school_highest_completed, 
			
			coalesce(vs_E37_school_special_education, '0') as vs_E37_school_special_education, -- For Compliance No
			
			(case when btrim(pr1.gendertypekey) = 'F' -- Female	
					or btrim(pr1.gendertypekey) = 'TGIM' 
					or ( btrim(pr1.gendertypekey) = 'O' and pr1.othergendertypekey = 1 ) -- Assigned Female at Birth *
					Then -- Transgender- Identifies as Male
				coalesce(vs_E38_pregnant, '0') -- NO For Compliance 
			 else
				NULL -- Male
			end) as vs_E38_pregnant,
			
			coalesce(vs_E39_fathered_or_bore_child, '0') as vs_E39_fathered_or_bore_child, -- For Compliance No 
				
			(case when coalesce(vs_E39_fathered_or_bore_child, '0') = '0' then
				'9' -- Not applicable For Compliance
			else
				coalesce(vs_E40_child_and_children_together, '9') 
			end) as vs_E40_child_and_children_together,
			
			(case when pr1.everbeenadoptedflag = 1 then
				'1' -- Yes
			when pr1.everbeenadoptedflag = 0 then
				'0' -- No 
			when pr1.everbeenadoptedflag = 2 then	
				'7' -- Abandoned
			end) as E41_prior_adoption,
			
			(case when pr1.everbeenadoptedflag = 1 then
				pr1.preadoptiondate
			else
				NULL
			end) as E42_prior_adoption_date, 
			
			(case when pr1.everbeenadoptedflag = 1 then
				(case when pr1.intercountryadoption = 1 then
					'1' -- Yes	
				else
					'0' --No
				end)
			else
				NULL
			end) as e43_prior_adoption_intercountry,
			
			(case when pr1.priorlegalguardianship = 1 then
				'1' -- Yes
			when pr1.priorlegalguardianship = 0 then
				'0' -- No 
			when pr1.priorlegalguardianship = 2 then	
				'7' -- Abandoned
			else
				'0' -- For Compliance No 
			end) as e44_prior_guardianship, 
			
			(case when pr1.priorlegalguardianship = 1 then
				pr1.preplacementguardianshipdate
			else
				NULL
			end) as e45_prior_guardianship_date, 
			
			-- 'New' 
			-- IF e47 to e55 any one is Yes
			(case when vs_ivefostercareflag = '1' -- afc1.ivefostercareflag = '1' 
					or afc1.iveadoptionflag = '1'
					or afc1.ivaflag = '1' 
					-- or afc1.ivdflag = '1' -- 04/17/2025 
					or afc1.xixflag = '1'  
					or afc1.ssiorssaflag = '1' 
					or afc1.nofederalsupportflag = '1'
					-- or afc1.fostercarepaymentamt <> '0' -- 04/17/2025 
					then 
				'1' -- Received support/financial assistance 
			else
				'0' -- No support/assistance received 
			end) as e46_support_assistance,  -- e46 ?? 
			
			-- 'Revised'
			'0' as e47_state_tribal_adoption_assistance, -- e47 ?? For Compliance Does not apply 

			vs_ivefostercareflag as e48_state_tribal_foster_care, -- e48 ?? For Compliance Does not apply 
			-- afc1.ivefostercareflag 
			
			afc1.iveadoptionflag as e49_adoption_subsidy,
			
			-- 'Revised'
			'0' as e50_guardianship_assistance, -- e50 ?? -- Does not apply
			
			afc1.ivaflag as e51_tanf_assistance, 
			
			-- 'Revised'
			'0' as e52_title_iv_b, -- afc1.ivdflag e52 ?? -- Does not apply 
			'0' as e53_chafee_foster_program, -- afc1.xixflag e53 ?? -- Does not apply 
			
			(case when afc1.ivaflag = '1'
				or afc1.xixflag = '1'
				-- afc1.fostercarepaymentamt <> '0' 
				or afc1.ssiorssaflag = '1' 
				or afc1.nofederalsupportflag = '1' then
				'1'
			 else	
				'0' 
			end) as e54_other_financial_support, -- e54 ?? -- Does not apply 
						
			-- (case when coalesce(afc1.fostercarepaymentamt,'0') <> '0' then
			coalesce(vs_ivefostercareflag,'0') as e55_foster_care_payment,
			/*
			(case when coalesce(afc1.ivefostercareflag,'0') <> '0' then -- Eligible Reimbursable
				'1' -- Yes
			else
				'0' -- No 
			end ) as e55_foster_care_payment, 
			*/
			
			coalesce(vl_sibling::character varying,'0') as e56_total_siblings, 
			
			(case when coalesce(vl_sibling::character varying,'0') = '0' then
				NULL -- For Compliance Not applicable
			else
				coalesce(vl_ch_rem_sibling::character varying,'0')
				-- coalesce(vl_fc_placemnt_sibling::character varying,'0')
			end) as e57_siblings_in_foster_care, 
			
			(case when coalesce(vl_sibling::character varying,'0') = '0' 
				or coalesce(vl_ch_rem_sibling::character varying,'0') = '0' -- Need to comment on 04/08/2026 ???
				then
				NULL -- For Compliance Not applicable
			else
				coalesce(vl_fc_la_placemnt_sibling::character varying,'0') 
				-- coalesce(vl_la_placemnt_sibling::character varying,'0') 
			end) as e58_siblings_in_living_arrangement, 
	
			caretaker1birthyear as e59_first_parent_birth_year, 
			coalesce(caretaker2birthyear, '9999') as e60_second_parent_birth_year, -- For Compliance Not applicable
			
			(select (case when upper(coalesce(p.icwaeligibleformembership,'')) = 'YES' then 
						'1' -- Yes 
					when upper(coalesce(p.icwaeligibleformembership,'')) = 'NO' then
						'0' -- No 
					else 
						'9' -- Unknown
					end) 
			from intakeservreqchildremoval ir,
				person p
			where ir.primarycaregiveractorid = p.personid 
				and ir.activeflag = 1
				and ir.removalid = vs_removalid::bigint 
			) as e61_tribal_membership_mother,	

			(select (case when upper(coalesce(p.icwaeligibleformembership,'')) = 'YES' then 
						'1' -- Yes 
					when upper(coalesce(p.icwaeligibleformembership,'')) = 'NO' then
						'0' -- No 
					else 
						'9' -- Unknown
					end) 
			from intakeservreqchildremoval ir,
				person p
			where ir.seccaregiveractorid = p.personid 
				and ir.activeflag = 1
				and ir.removalid = vs_removalid::bigint   
			) as e62_tribal_membership_father, 	
			
			(case when vs_mothertprdate is null and afc1.mothertprdate is null then 
				'0' -- Not applicable if there is no TPR 
			else
				(case when vs_mothertprdate is not null then 
					(case when coalesce(vs_is_monther_trp_contested, '1') = '2' then -- vs_is_trp_contested
						'2' -- Involuntary
					else
						'1' -- Voluntary	
					end) 
				else
					(case when coalesce(vs_is_trp_contested, '1') = '2' then
						'2' -- Involuntary
					else
						'1' -- Voluntary	
					end) 
				end)	
			end ) as e63_tpr_parent1, 
			
			(case when vs_fathertprdate is null and afc1.fathertprdate is null then 
				'0' -- Not applicable if there is no TPR 
			else
				(case when vs_fathertprdate is not null then 
					(case when coalesce(vs_is_father_trp_contested, '1') = '2' then 
						'2' -- Involuntary
					else
						'1' -- Voluntary	
					end) 
				else
					(case when coalesce(vs_is_trp_contested, '1') = '2' then
						'2' -- Involuntary
					else
						'1' -- Voluntary	
					end) 
				end)	
			end ) as e64_tpr_parent2, 
			
			to_char(vs_tpr_petition_date::date, 'YYYYMMDD') as e65_tpr_petition_date_parent1, -- e65 ??
			to_char(vs_tpr_petition_date::date, 'YYYYMMDD') as e66_tpr_petition_date_parent2, -- e66 ??
			
			-- YYYYMMDD
			-- 66666666 = Deceased
			-- Null = Not applicable 
			
			coalesce(vs_mothertprdate, to_char(afc1.mothertprdate::date, 'YYYYMMDD')) as e67_tpr_date_parent1, 
			coalesce(vs_fathertprdate, to_char(afc1.fathertprdate::date, 'YYYYMMDD')) as e68_tpr_date_parent2 
		from cjams.afcarsfostercare_new afc1,
			person pr1
		where afc1.fk_id::bigint = pr1.cjamspid
			and afc1.activeflag = '1' 
			and afc1.afcarsfostercareid = vs_afcarsfostercareid ;
		
		-- Capture Federally Recognized Tribe (Need child table) 
		OPEN cur_federally_recognized_tribe_REFCURSOR FOR
			select unnest(string_to_array(pr.icwatribename, ',')) as E9_recognized_tribes
				from person pr
			where cjamspid = vs_client_id::bigint
				and pr.activeflag = 1
				and pr.icwatribename is not null ;
		LOOP
			fetch cur_federally_recognized_tribe_REFCURSOR into cur_federally_recognized_tribe;
			exit when not found;
		
			-- Reset
			vs_E9_recognized_tribes := NULL;
			
			vs_E9_recognized_tribes := cur_federally_recognized_tribe.E9_recognized_tribes; 
			
			if  vs_E9_recognized_tribes is not null and Btrim(vs_E9_recognized_tribes) <> '' then
				INSERT INTO cjams.afcars_fc_recognized_tribes
					(	afcarsfostercareid,
						recordno,
						cjamspid,
						E9_recognized_tribes
					)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_client_id, 
						vs_E9_recognized_tribes
					);
			end if;		
		END LOOP;	
		close cur_federally_recognized_tribe_REFCURSOR;	
		
		-- Get All Removals
		OPEN cur_child_removal_REFCURSOR FOR
			select rm.intakeservreqchildremovalid,
				rm.removalid as child_removalid,
				rm.removaldate,
				coalesce (rm.removaltransts, rm.insertedon) as removaltransts,
				(case when rm.exitdate::date > vdt_to::date then 
					Null
				else
					rm.exitdate
				end) as exitdate,
				-- To fix E154
				(case when rm.exitdate::date > vdt_to::date then 
					Null
				else
					(case when rm.exitdate is not null 
						then
						(case when 
								(select count(*)
									from routing ro
								where ro.objectid = rm.intakeservreqchildremovalid::character varying
									and ro.eventcode = 'CHRR'
									and ro.routingstatustypeid = 15
								) > 1
							and -- last apporval date is greater or equal to than exit date 	
								(select ro.insertedon 
									from routing ro
								where ro.objectid = rm.intakeservreqchildremovalid::character varying
									and ro.eventcode = 'CHRR'
									and ro.routingstatustypeid = 15
								order by ro.insertedon desc
								limit 1
								)::date >= rm.exitdate::date 
							and  -- last apporval date is greater than exit trasaction date 		
								(select ro.insertedon 
									from routing ro
								where ro.objectid = rm.intakeservreqchildremovalid::character varying
									and ro.eventcode = 'CHRR'
									and ro.routingstatustypeid = 15
								order by ro.insertedon desc
								limit 1
								)::date > rm.returntransts::date then 
									(select ro.insertedon 
											from routing ro
										where ro.objectid = rm.intakeservreqchildremovalid::character varying
											and ro.eventcode = 'CHRR'
											and ro.routingstatustypeid = 15
										order by ro.insertedon desc
										limit 1
									)::character varying 
						else
							(case when (rm.returntransts is not null and rm.returntransts::date != '1900-01-01'::date) then  
								(rm.returntransts::date)::character varying 
							else 
								(rm.updatedon::date)::character varying 
							end)
						end)		
					else
						null::character varying  
					end)
				end) as returntransts,
				-- V0.0
				/*
				(case when (rm.returntransts is not null and rm.returntransts::date != '1900-01-01'::date) then  
					(rm.returntransts::date)::character varying 
				else 
					(rm.updatedon::date)::character varying 
				end) as returntransts, 
				*/
				
				-- Child Removal End Reason: referencetypeid = 343
				--  Reunify with parent or legal guardian
				(case when rm.removalexitreason 
					in ('REUNIF', 'CHREUNIFWF', 'RUF', 'CORHADR', 'CORHA', 'CIDP', 'CINC', 'CINSR', 'CISR',
						'PSPC', 'PSTHV', 'PII', 'RFS', 'REFSERV', 'RIMT' ) then '1' 
					/*
					1 REUNIF		Reunify with Parent or legal guardian
					1 CHREUNIFWF	Child reunified with parents/Family - X
					1 RUF			Reunification - X
					1 CORHADR		Court ordered return home against DSS recommendation
					1 CORHA			Court ordered return home against DSS recommendation - X
					1 CIDP			Child Issue: Dissatisfaction with provider - X
					1 CINC			Child Issue: Needs have changed - X
					1 CINSR			Child Issue: Needs less Structured/Restricted Environment - X
					1 CISR			Child Issue: Needs more Structured/Restricted Environment - X
					1 PSPC			Permanency Step: Placement Closer to Home
					1 PSTHV			Permanency Step: Trial Home Visit - X
					1 PII			Provider Issue: Investigation (CPS, APS, Criminal) - X
					1 RFS			Refused Service - X
					1 REFSERV		Refused Service - X
					1 RIMT			Resource Issue: Move from Short Term Placement - X
					*/
					-- Live with other relative
					when rm.removalexitreason in ('OTRL', 'OTHERREL', 'PSPR', 'LWOR') then '2' 
					/*
					2 OTRL			Other Relative - X
					2 OTHERREL		Other Relative - X
					Removed on 03/28 ???
					2 LWOR			Live with other relative
					2 PSPR			Permanency Step: Placement with Relative - X
					2 COCTRADR		Court ordered custody to a relative against DSS recommendation
					Added back 10/02/2024
					2 LWOR			Live with other relative
					*/
					-- Adoption
					when rm.removalexitreason 
						in ('ADNRE', 'ADRE', 'AF', 'ADPFIN', 'ADPL', 'CADOFIN', 'PSAP', 'ADPDIS', 'ADP') then '3' 
					/*
					3 ADNRE			Adoption Non-relative
					3 ADRE			Adoption Relative
					3 AF			Adoption Finalization - X
					3 ADPFIN		Adoption Finalization - X
					3 ADPL			Adoptive Placement - X
					3 CADOFIN		Child adoption finalized - X
					3 PSAP			Permanency Step: Adoptive or pre-adoptive Placement - X
					3 ADPDIS		Adoption Disruption - X
					3 ADP			Adoption Disruption
					*/
					-- Emancipation
					when rm.removalexitreason 
						in ('EMANIND', 'MRG', 'EMANMAR', 'EMANMIL', 'EMI', 'MILY', 'PSEV') then '4' 
					/*
					4 EMANIND		Emancipation-Independence
					4 EMANMAR, MRG	Emancipation-Marriage
					4 EMANMIL, MILY	Emancipation-Military
					4 EMI			Emancipation-Independence - X
					4 PSEV			Permanency Step: Educational/Vocational Placement - X
					*/
					-- Guardianship
					when rm.removalexitreason in (
						'GNONREL', 'GUARDR', 'CGPGAP', 'CUSNONR', 'CGNR', 'CGUARDNR', 'CGR', 
						'CGUARDREL', 'CCOP', 'COCTRADR', 'CNR', 'GNR', 'RGS', 'RGSUS' ) then '5' 
					/*
					5 GNONREL		Guardianship Non-Relative
					5 GUARDR		Guardianship Relative
					5 CGPGAP		Childs guardianship program approved - X
					5 CUSNONR		Custody Non-Relative - X
					5 CGNR			Custody/Guardianship - Non-Relative - X
					5 CGUARDNR		Custody/Guardianship - Non-Relative - X
					5 CGR			Custody/Guardianship - Relative - X
					5 CGUARDREL		Custody/Guardianship - Relative - X
					5 CCOP			Court: Court Ordered Placement Change
					5 COCTRADR		Court Ordered custody to a relative against DSS Recommendation
					5 CNR			Custody Non-Relative
					5 GNR			Guardianship Non-Relative
					5 RGS			Remove GAP suspension
					5 RGSUS			Remove GAP suspension - X
					Removed 10/02/2024
					5 LWOR			Live with Other Relative
					
					*/
					-- Runaway or whereabouts unknown
					when rm.removalexitreason in ('RNAWAY', 'RNWY', 'CIR', 'OTR', 'OTHER') then '6' 
					/*
					6 RNAWAY		Runaway or Whereabouts Unknown
					6 RNWY			Runaway - X
					6 CIR			Child Issue: Runaway - X
					6 OTR			Other - X
					6 OTHER			Other - X
					*/
					-- Death of child
					when rm.removalexitreason in ('DEATHOC', 'DOC') then '7' 
					/*
					7 DEATHOC		Death of Child
					7 DOC			Death of Child - X
					*/
					-- Transfer to another agency
					when rm.removalexitreason in ('TTONDA', 'TON', 'CIPDA') then '8' 
					/*
					8 TTONDA		Transfer to another Agency
					8 TON			Transfer to Other Non-DHR Agency - X
					8 CIPDA			Child Issue: Behavior (Property Destruction, Aggression to Others, Defiance) - X
					*/
					else '1' -- Reunify with parent or legal guardian For Compliance 
						-- '9' -- Not applicable  -- null -- ????
					/*
					9 CCOP			Court: Court Ordered Placement Change - X
					9 SPC			Permanency Step: Placement Closer to Home - X
					*/
				end ) as removalexitreason,
				
				(case when rm.removalexitreason in ('TTONDA', 'TON') then -- '8' -- Transfer to another agency
					NULL
				 else
					-- Other Engency: referencetypeid = 350
					(case when rm.transferagency = 'STIVEA' then '1' -- State title IV-E agency 
						-- STIVEA	State Title IV-E Agency
						when rm.transferagency = 'TA' then '2' -- Tribal title IV-E agency
						-- TA		Tribal Agency
						when rm.transferagency = 'ITNONIVE' then '3' -- Indian Tribe or Tribal agency (non-IV-E) 
						-- ITNONIVE	Indian Tribe or Tribal Agency (Non-IV-E)
						when rm.transferagency = 'JJA' then '4' -- Juvenile justice agency
						-- JJA		Juvenile Justice Agency
						when rm.transferagency = 'MHA' then '5' -- Mental health agency
						-- MHA		Mental Health Agency
						when rm.transferagency = 'OPA' then '6' -- Other public agency
						-- OPA		Other Public Agency
						when rm.transferagency = 'PA' then '7' -- Private agency 
						-- PA		Private Agency
					end)
				  end) as transfer_to_another_agency,				
				-- Environment at Removal: referencetypeid = 5470
				(case when rm.environmentatremovalkey is null or Btrim(environmentatremovalkey) = '' then
						'7' -- Other
				  when rm.environmentatremovalkey = 'PAHOLD' then -- Parent household
						'1' 
				  when rm.environmentatremovalkey = 'RELHLD' then -- Relative household
						'2'
				  when rm.environmentatremovalkey = 'LEGUHO' then -- Legal guardian household
						'3'
				  when rm.environmentatremovalkey = 'RELGUL' then -- Relative legal guardian household
						'4'
				  when rm.environmentatremovalkey = 'JUFATY' then -- Justice facility
						'5'
				  when rm.environmentatremovalkey = 'MEHEFA' then -- Medical/mental health facility
						'6'
				  when rm.environmentatremovalkey = 'OTHER' then -- Other
						'7'
				  else
						'7' -- Other
				end) as environmentatremovalkey,
				sc.servicecasenumber as servicecasenumber	
			from intakeservreqchildremoval rm
				join servicecase sc on sc.servicecaseid = rm.servicecaseid 
					and sc.activeflag = 1
			where rm.activeflag = 1
			   and rm.personid = vu_personid
			   and rm.removaldate is not null
			   and rm.removaldate <= vdt_to::DATE
			   -- and rm.exitdate::date <= vdt_from::date
			   -- 02/26/2025
			   and ( case when rm.exitdate is not null then 	
						rm.removaldate::date <> rm.exitdate::date
					else 
						true
					end)	
			   and ( select count(*) 
						from routing rur
					  where rur.objectid = rm.intakeservreqchildremovalid::character varying
						and rur.eventcode = 'CHRR'
						and rur.activeflag = 1
						and rur.routingstatustypeid = '16'
					) > 0
			   -- To exclude removals less than 1 day (24 hours)
				AND (case when rm.exitdate is not null then -- 10/29/2025
						(
							(
								(rm.removaltime is null  or rm.returntime is null) 
								and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE + interval '1 day' ) 
											<> rm.removaltransts::date 
							)
							or 
							( 
								(rm.removaltime is not null and rm.returntime is not null)
								and
								(
									(
										((rm.exitdate::date - rm.removaldate::date ) * 24 )  
											- COALESCE(EXTRACT(hour from rm.removaltime),0)  
											+ COALESCE(EXTRACT(hour from rm.returntime),0)
									)  
									-  
									COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
										+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
										-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
										+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001
								) >= 24
							)
						)	
					else
						true
					end)	
			order by rm.removaldate;
		LOOP
			fetch cur_child_removal_REFCURSOR into cur_child_removal;
				exit when not found;
			
				-- Reset
				vu_intakeservreqchildremovalid := NULL;
				vs_child_removalid := NULL;
				vs_e69_removal_date := NULL;
				vs_e70_removal_transaction_date	:= NULL;	
				vs_e71_removal_environment := NULL;
				vs_e153_exit_date := NULL;
				vs_e154_exit_transaction_date := NULL;
				vs_e155_exit_reason := NULL;
				vs_removalcircumstances := NULL;
				vs_e72_runaway := NULL;
				vs_e73_whereabouts_unknown := NULL;
				vs_e156_transfer_to_another_agency := NULL;
				vs_caseid := NULL;
								
				vu_intakeservreqchildremovalid := cur_child_removal.intakeservreqchildremovalid;
				vs_child_removalid := cur_child_removal.child_removalid;
				vs_e69_removal_date := cur_child_removal.removaldate;
				vs_e70_removal_transaction_date := cur_child_removal.removaltransts;
				vs_e71_removal_environment := cur_child_removal.environmentatremovalkey;
				vs_e153_exit_date := cur_child_removal.exitdate;
				vs_e154_exit_transaction_date := cur_child_removal.returntransts;
				vs_e155_exit_reason := cur_child_removal.removalexitreason;
				vs_E156_transfer_to_another_agency := cur_child_removal.transfer_to_another_agency; 
				vs_caseid := cur_child_removal.servicecasenumber; 
				
				vd_removal_date := cur_child_removal.removaldate;
				vd_exit_date := cur_child_removal.exitdate;
				
				-- Reset 
				vs_e80_abandonment := NULL;
				vs_e82_caretaker_alcohol_use := NULL; 
				vs_e83_caretaker_drug_use := NULL; 
				vs_e95_caretaker_impairment_cognitive := NULL;
				vs_e94_caretaker_impairment_physical_emotional := NULL; 
				vs_e84_child_alcohol_use := NULL; 
				vs_e91_child_behavior_problem := NULL; 
				vs_e85_child_drug_use := NULL; 
				vs_e98_child_requested_placement := NULL; 
				vs_e92_death_of_caretaker := NULL;
				vs_e88_diagnosed_condition := NULL; 
				vs_e79_domestic_violence := NULL; 
				vs_e81_failure_to_return := NULL; 
				vs_e101_family_conflict_gender_orientation := NULL; 
				vs_e105_homelessness := NULL; 
				vs_e89_inadequate_access_to_mental_health := NULL; 
				vs_e90_inadequate_access_to_medical_service := NULL; 
				vs_e96_inadequate_housing := NULL; 
				vs_e93_incarceration_of_caretaker := NULL; 
				vs_e78_medical_neglect := NULL; 
				vs_e77_neglect := NULL; 
				vs_e100_parental_immigration_detainment_deportation := NULL; 
				vs_e74_physical_abuse := NULL; 
				vs_e86_prenatal_alcohol_exposure := NULL; 
				vs_e87_prenatal_drug_exposure := NULL; 
				vs_e76_psychological_abuse := NULL; 
				vs_e103_public_agency_title_iv_agreement := NULL; 
				vs_e72_runaway := NULL;
				vs_e75_sexual_abuse := NULL;
				vs_e99_sex_trafficking := NULL; 
				vs_e104_tribal_agreement := NULL; 
				vs_e97_voluntary_adoption := NULL; 
				vs_e73_whereabouts_unknown := NULL;
				vs_e102_educational_neglect := NULL;
				vs_E3_local_agency := NULL;
				
				-- Child and family circumstances at removal
				select 
					(case when lower((rm.removalcircumstances ->> 'abandonment')::character varying) = 'true' then '1' else '0' end) as abandonment,
					(case when lower((rm.removalcircumstances ->> 'caretakeralcoholuse')::character varying) = 'true' then '1' else '0' end) as caretakers_alcohol_use,
					(case when lower((rm.removalcircumstances ->> 'caretakerdruguse')::character varying) = 'true' then '1' else '0' end) as caretakers_drug_use,
					(case when lower((rm.removalcircumstances ->> 'caretakersignificantimpairment')::character varying) = 'true' then '1' else '0' end) as ct_signf_impairment_cognitive,
					(case when lower((rm.removalcircumstances ->> 'caretakerignificantimpphysical')::character varying) = 'true' then '1' else '0' end) as ct_signf_impairment_phys_emtnl,
					(case when lower((rm.removalcircumstances ->> 'childalcoholuse')::character varying) = 'true' then '1' else '0' end) as child_alcohol_use,
					(case when lower((rm.removalcircumstances ->> 'childbehaviorproblem')::character varying) = 'true' then '1' else '0' end) as child_behavior_problem,
					(case when lower((rm.removalcircumstances ->> 'childdruguse')::character varying) = 'true' then '1' else '0' end) as child_drug_use,
					(case when lower((rm.removalcircumstances ->> 'childrequestedplacement')::character varying) = 'true' then '1' else '0' end) as child_requested_placement,
					(case when lower((rm.removalcircumstances ->> 'deathofcaretaker')::character varying) = 'true' then '1' else '0' end) as death_of_caretaker,
					(case when lower((rm.removalcircumstances ->> 'diagnosedcondition')::character varying) = 'true' then '1' else '0' end) as diagnosed_condition,
					(case when lower((rm.removalcircumstances ->> 'domesticviolence')::character varying) = 'true' then '1' else '0' end) as domestic_violence,
					(case when lower((rm.removalcircumstances ->> 'failuretoreturn')::character varying) = 'true' then '1' else '0' end) as failure_to_return,
					(case when lower((rm.removalcircumstances ->> 'familyconflict')::character varying) = 'true' then '1' else '0' end) as family_conflict_related_gender,
					(case when lower((rm.removalcircumstances ->> 'homelessness')::character varying) = 'true' then '1' else '0' end) as homelessness,
					(case when lower((rm.removalcircumstances ->> 'inadequateaccesstomhs')::character varying) = 'true' then '1' else '0' end) as inadequate_access_mental_health,
					(case when lower((rm.removalcircumstances ->> 'inadequateaccesstomedicalservices')::character varying) = 'true' then '1' else '0' end) as inadequate_access_medical,
					(case when lower((rm.removalcircumstances ->> 'inadequatehousing')::character varying) = 'true' then '1' else '0' end) as inadequate_housing,
					(case when lower((rm.removalcircumstances ->> 'incarcerationofcaretaker')::character varying) = 'true' then '1' else '0' end) as incarceration_of_caretaker,
					(case when lower((rm.removalcircumstances ->> 'medicalneglect')::character varying) = 'true' then '1' else '0' end) as medical_neglect,
					(case when lower((rm.removalcircumstances ->> 'neglect')::character varying) = 'true' then '1' else '0' end) neglect,
					(case when lower((rm.removalcircumstances ->> 'parentalimmigration')::character varying) = 'true' then '1' else '0' end) as parental_immigration,
					(case when lower((rm.removalcircumstances ->> 'physicalabuse')::character varying) = 'true' then '1' else '0' end) as physical_abuse,
					(case when lower((rm.removalcircumstances ->> 'prenatalalcoholexposure')::character varying) = 'true' then '1' else '0' end) as prenatal_alcohol_exposure,
					(case when lower((rm.removalcircumstances ->> 'prenataldrugexposure')::character varying) = 'true' then '1' else '0' end) as prenatal_drug_exposure,
					(case when lower((rm.removalcircumstances ->> 'psychologicalemotionalabuse')::character varying) = 'true' then '1' else '0' end) as psych_emotional_abuse,
					(case when lower((rm.removalcircumstances ->> 'publicagencytitleive')::character varying) = 'true' then '1' else '0' end) as pub_agency_title_ive,
					(case when lower((rm.removalcircumstances ->> 'runaway')::character varying) = 'true' then '1' else '0' end) as runaway,
					(case when lower((rm.removalcircumstances ->> 'sexualabuse')::character varying) = 'true' then '1' else '0' end) as sexual_abuse,
					(case when lower((rm.removalcircumstances ->> 'sextrafficking')::character varying) = 'true' then '1' else '0' end) as sex_trafficking,
					(case when lower((rm.removalcircumstances ->> 'tribaltitleive')::character varying) = 'true' then '1' else '0' end) as tribal_title_ive,
					(case when lower((rm.removalcircumstances ->> 'voluntaryrelinquishment')::character varying) = 'true' then '1' else '0' end) as voluntary_relq_adoption,
					(case when lower((rm.removalcircumstances ->> 'whereaboutsunknown')::character varying) = 'true' then '1' else '0' end) as whereabouts_unknown,
					-- 03/11/2025
					-- NULL as educational_neglect,
					'0' as educational_neglect,
					coalesce(-- Get the Child Assignment
						(select af.afcars_ref_cd 
							from caseassignment ca  
								join caseassignmentactor cr on cr.caseassignmentid = ca.caseassignmentid 
									and cr.activeflag  = 1
								join intakeservicerequestactor isr on isr.intakeservicerequestactorid = cr.intakeservicerequestactorid 
									and isr.activeflag = 1	
								join county c on c.countyid:: character varying = ca.toldssid::character varying
								join afcars_ref_code af on 
									(lower(trim(c.countyname)) = lower(trim(af.cjams_cd)) 
										OR 
									 lower(replace(c.countyname,' ','')) = lower(replace(af.cjams_cd,' ',''))
									)
									and af.afcars_ref_type = 'County Code'	  
							where ca.objectid = rm.servicecaseid
								and lower(ca.responsibilitytypekey) = 'child'
								and ca.activeflag = 1
								and ca.startdate <= vdt_to::date 
								and (ca.enddate >= vdt_from::date OR ca.enddate IS NULL) 
								and isr.personid = rm.personid
							order by ca.insertedon desc
							limit 1
						),
						(-- Get the Family Assignment
							select af.afcars_ref_cd 
							from caseassignment ca  
								join county c on c.countyid:: character varying = ca.toldssid::character varying
								join afcars_ref_code af on (lower(trim(c.countyname)) = lower(trim(af.cjams_cd)) OR 
									lower(replace(c.countyname,' ','')) = lower(replace(af.cjams_cd,' ','')))
									and af.afcars_ref_type = 'County Code'
							where ca.objectid = rm.servicecaseid
								and lower(ca.responsibilitytypekey) = 'family'
								and ca.activeflag = 1
								and ca.startdate <= vdt_to::date 
								and (ca.enddate >= vdt_from::date OR ca.enddate IS NULL) 
							order by ca.insertedon desc
							limit 1
						),
						(-- Get the most recent Family Assignment
							select af.afcars_ref_cd 
							from caseassignment ca  
								join county c on c.countyid:: character varying = ca.toldssid::character varying
								join afcars_ref_code af on (lower(trim(c.countyname)) = lower(trim(af.cjams_cd)) OR 
									lower(replace(c.countyname,' ','')) = lower(replace(af.cjams_cd,' ','')))
									and af.afcars_ref_type = 'County Code'
							where ca.objectid = rm.servicecaseid
								and lower(ca.responsibilitytypekey) = 'family'
								and ca.activeflag = 1
							order by ca.insertedon desc
							limit 1
						)
					)	
				into vs_e80_abandonment,
					vs_e82_caretaker_alcohol_use, 
					vs_e83_caretaker_drug_use, 
					vs_e95_caretaker_impairment_cognitive,
					vs_e94_caretaker_impairment_physical_emotional, 
					vs_e84_child_alcohol_use, 
					vs_e91_child_behavior_problem, 
					vs_e85_child_drug_use, 
					vs_e98_child_requested_placement, 
					vs_e92_death_of_caretaker,
					vs_e88_diagnosed_condition, 
					vs_e79_domestic_violence, 
					vs_e81_failure_to_return, 
					vs_e101_family_conflict_gender_orientation, 
					vs_e105_homelessness, 
					vs_e89_inadequate_access_to_mental_health, 
					vs_e90_inadequate_access_to_medical_service, 
					vs_e96_inadequate_housing, 
					vs_e93_incarceration_of_caretaker, 
					vs_e78_medical_neglect, 
					vs_e77_neglect, 
					vs_e100_parental_immigration_detainment_deportation, 
					vs_e74_physical_abuse, 
					vs_e86_prenatal_alcohol_exposure, 
					vs_e87_prenatal_drug_exposure, 
					vs_e76_psychological_abuse, 
					vs_e103_public_agency_title_iv_agreement, 
					vs_e72_runaway,
					vs_e75_sexual_abuse,
					vs_e99_sex_trafficking, 
					vs_e104_tribal_agreement, 
					vs_e97_voluntary_adoption, 
					vs_e73_whereabouts_unknown,
					vs_e102_educational_neglect,
					vs_E3_local_agency
				from intakeservreqchildremoval rm
				where rm.intakeservreqchildremovalid = vu_intakeservreqchildremovalid
					and rm.activeflag = 1 ;
				
				
				-- For Compliance Error 
				-- At least one of data elements E72 - E105 should be 1 (Applies).
				-- Look for Factors AT Removal
				IF vs_e72_runaway = '0' and vs_e73_whereabouts_unknown = '0' and vs_e74_physical_abuse = '0' and  
					vs_e75_sexual_abuse = '0' and vs_e76_psychological_abuse = '0' and vs_e77_neglect = '0' and  
					vs_e78_medical_neglect = '0' and vs_e79_domestic_violence = '0' and vs_e80_abandonment = '0' and  
					vs_e81_failure_to_return = '0' and vs_e82_caretaker_alcohol_use = '0' and 
					vs_e83_caretaker_drug_use = '0' and vs_e84_child_alcohol_use = '0' and 
					vs_e85_child_drug_use = '0' and vs_e86_prenatal_alcohol_exposure = '0' and  
					vs_e87_prenatal_drug_exposure = '0' and vs_e88_diagnosed_condition = '0' and 
					vs_e89_inadequate_access_to_mental_health = '0' and  
					vs_e90_inadequate_access_to_medical_service = '0' and vs_e91_child_behavior_problem = '0' and  
					vs_e92_death_of_caretaker = '0' and vs_e93_incarceration_of_caretaker = '0' and  
					vs_e94_caretaker_impairment_physical_emotional = '0' and  
					vs_e95_caretaker_impairment_cognitive = '0' and vs_e96_inadequate_housing = '0' and 
					vs_e97_voluntary_adoption = '0' and vs_e98_child_requested_placement = '0' and  
					vs_e99_sex_trafficking = '0' and vs_e100_parental_immigration_detainment_deportation = '0' and  
					vs_e101_family_conflict_gender_orientation = '0' and 
					vs_e102_educational_neglect = '0' and 
					vs_e103_public_agency_title_iv_agreement = '0' and  vs_e104_tribal_agreement = '0' 
					and vs_e105_homelessness = '0' THEN
					
					-- removalreasontype
					-- ADT	Abandonment
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_E80_abandonment
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'ADT' ;


					-- AAC	Alcohol Abuse (Child)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e84_child_alcohol_use
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'AAC' ;
					
					-- AAP	Alcohol Abuse (Parent)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e82_caretaker_alcohol_use
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'AAP' ;
					
					-- CIIO	Caregiver's Inability to Cope Due to Illness or Other Reason
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e94_caretaker_impairment_physical_emotional
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'CIIO' ;
						
					-- US	Child Unsafe
					-- HG	Neglect
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e77_neglect
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) in ('US', 'HG');
						
					-- CBP	Child's Behavior Problem
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e91_child_behavior_problem
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'CBP' ;
						
					-- CD	Child's Disabilities
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e88_diagnosed_condition
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'CD' ;
						
					-- DP	Death of Parent(s)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e92_death_of_caretaker
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'DP' ;
					
					-- DAC	Drug Abuse (Child)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e85_child_drug_use
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'DAC' ;
						
					-- DAP	Drug Abuse (Parent)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e83_caretaker_drug_use
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'DAP' ;
						
					-- IDH	Inadequate Housing
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e96_inadequate_housing
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'IDH' ;
						
					-- IP	Incarceration of Parent(s)
					-- PI	Parent incarceration 
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e93_incarceration_of_caretaker
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) in ('IP', 'PI') ;
					
					-- NS	Not secured
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e73_whereabouts_unknown
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'NS' ;
					
					-- PA	Physical abuse 
					-- HC	Harm To Child
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e74_physical_abuse
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) In ('PA','HC') ;
					
					-- RLQ	Relinquishment for Adoption (incl. Safe Haven)
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e97_voluntary_adoption
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'RLQ' ;
						
					-- SA	Sexual Abuse
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e75_sexual_abuse
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'SA' ;
						
					-- VP	Voluntary Placement
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_e98_child_requested_placement
					from intakeservreqchildremovalreason
					where intakeservreqchildremovalid = vu_intakeservreqchildremovalid
						and activeflag = 1
						-- and inputtypekey = 'CHFE'-- Child Factors at Entry
						and btrim(removalreasontypekey) = 'VP' ;
						
				END IF;
				
				-- RAISE NOTICE 'vs_child_removalid >> %',vs_child_removalid;
		
				INSERT INTO cjams.afcars_fc_child_removals
					(	afcarsfostercareid, 
						recordno, 
						e3_local_agency,
						removalid,
						cjamspid,
						caseid,
						current_period_removal_sw,	
						e69_removal_date, 
						e70_removal_transaction_date,
						e71_removal_environment,
						e72_runaway,
						e73_whereabouts_unknown,
						e74_physical_abuse, 
						e75_sexual_abuse,
						e76_psychological_abuse, 
						e77_neglect, 
						e78_medical_neglect, 
						e79_domestic_violence, 
						e80_abandonment,
						e81_failure_to_return, 
						e82_caretaker_alcohol_use, 
						e83_caretaker_drug_use, 
						e84_child_alcohol_use, 
						e85_child_drug_use, 
						e86_prenatal_alcohol_exposure, 
						e87_prenatal_drug_exposure, 
						e88_diagnosed_condition, 
						e89_inadequate_access_to_mental_health, 
						e90_inadequate_access_to_medical_service, 
						e91_child_behavior_problem, 
						e92_death_of_caretaker,
						e93_incarceration_of_caretaker, 
						e94_caretaker_impairment_physical_emotional, 
						e95_caretaker_impairment_cognitive,
						e96_inadequate_housing, 
						e97_voluntary_adoption, 
						e98_child_requested_placement, 
						e99_sex_trafficking, 
						e100_parental_immigration_detainment_deportation, 
						e101_family_conflict_gender_orientation, 
						e102_educational_neglect,
						e103_public_agency_title_iv_agreement,
						e104_tribal_agreement, 
						e105_homelessness,
						
						e153_exit_date, 
						e154_exit_transaction_date,
						e155_exit_reason,
						e156_transfer_to_another_agency,
						
						removal_date,
						exit_date
					)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno,
						vs_E3_local_agency,
						vs_child_removalid,
						vs_client_id,
						vs_caseid,
						-- (case when vs_e153_exit_date::date <= vdt_from::date then 'N' else 'Y' end),
						(case when vs_e153_exit_date::date < vd_removal_1993_dt::date 
							-- and vs_e154_exit_transaction_date::date < vd_removal_1993_dt::date 
							then 
							'N' 
						else 
							'Y' 
						end),
						vs_e69_removal_date, 
						vs_e70_removal_transaction_date,
						vs_e71_removal_environment,
						vs_e72_runaway,
						vs_e73_whereabouts_unknown,
						vs_e74_physical_abuse, 
						vs_e75_sexual_abuse,
						vs_e76_psychological_abuse, 
						vs_e77_neglect, 
						vs_e78_medical_neglect, 
						vs_e79_domestic_violence, 
						vs_e80_abandonment,
						vs_e81_failure_to_return, 
						vs_e82_caretaker_alcohol_use, 
						vs_e83_caretaker_drug_use, 
						vs_e84_child_alcohol_use, 
						vs_e85_child_drug_use, 
						vs_e86_prenatal_alcohol_exposure, 
						vs_e87_prenatal_drug_exposure, 
						vs_e88_diagnosed_condition, 
						vs_e89_inadequate_access_to_mental_health, 
						vs_e90_inadequate_access_to_medical_service, 
						vs_e91_child_behavior_problem, 
						vs_e92_death_of_caretaker,
						vs_e93_incarceration_of_caretaker, 
						vs_e94_caretaker_impairment_physical_emotional, 
						vs_e95_caretaker_impairment_cognitive,
						vs_e96_inadequate_housing, 
						vs_e97_voluntary_adoption, 
						vs_e98_child_requested_placement, 
						vs_e99_sex_trafficking, 
						vs_e100_parental_immigration_detainment_deportation, 
						vs_e101_family_conflict_gender_orientation, 
						vs_e102_educational_neglect,
						vs_e103_public_agency_title_iv_agreement,
						vs_e104_tribal_agreement, 
						vs_e105_homelessness,
						vs_e153_exit_date, 
						(case when vs_e153_exit_date is null then 
							null
						 else
							vs_e154_exit_transaction_date
						end),
						(case when vs_e153_exit_date is null then 
							'9' -- Not applicable 
						 else
							vs_e155_exit_reason
						end),
						vs_e156_transfer_to_another_agency,
						vd_removal_date,
						vd_exit_date
					);
				
				-- Vineet 02/13
				-- Capture Adoption Client IDs in Temp table 		
				vu_bio_personid := null;
				
				select pa.personid
					into vu_bio_personid
				from adoptioncase ac 
					join adoptionlink al on al.adoptioncaseid = ac.adoptioncaseid
					join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
						and aca.actortypekey = 'CHILD'
					join person pr on pr.personid = aca.personid and pr.activeflag = 1 
					join biologicaladoptionlink bol on al.preadoptionclientid = bol.preadoptiveclientid
					join adoptionbreakthelink abl ON abl.adoptionplanningid = bol.preadoptivecaseid
					join person pa on pa.personid = BOL.preadoptiveclientid and pa.activeflag = 1
				WHERE pr.cjamspid = vs_client_id::bigint
					and ac.activeflag = 1 
				order by abl.insertedon desc
				limit 1	;
				
				If vu_bio_personid is not null and (select count(*)
														from ttb_bio_client_removal
													where adop_cjamspid = vs_client_id
													) = 0 then 
				
					Insert into ttb_bio_client_removal 
						( adop_cjamspid,
						  afcarsfostercareid,  
						  recordno, 
						  e3_local_agency
						)
					values
						( 	vs_client_id,
							-- vu_bio_personid,
							vs_afcarsfostercareid,
							vs_recordno,
							vs_E3_local_agency							
						)
					;
				end if;	
				
		END LOOP;	
		close cur_child_removal_REFCURSOR;	
		
		
		-- Capture Bio Client's removals - START
		OPEN cur_ado_bio_clients_REFCURSOR FOR
			select adop_cjamspid,
			  afcarsfostercareid,  
			  recordno, 
			  e3_local_agency
			from ttb_bio_client_removal; 
		LOOP
			fetch cur_ado_bio_clients_REFCURSOR into cur_ado_bio_clients;
			exit when not found;
		
			-- Reset
			vs_adop_cjamspid := NULL;
			vs_adop_afcarsfostercareid := NULL;
			vs_adop_recordno := NULL;
			vs_adop_E3_local_agency  := NULL;
			
			vs_adop_cjamspid := cur_ado_bio_clients.adop_cjamspid;
			vs_adop_afcarsfostercareid := cur_ado_bio_clients.afcarsfostercareid;
			vs_adop_recordno := cur_ado_bio_clients.recordno;
			vs_adop_E3_local_agency := cur_ado_bio_clients.e3_local_agency;
		
			OPEN cur_bio_removals_REFCURSOR FOR
				select rm.intakeservreqchildremovalid,
					pr.cjamspid,
					rm.removalid,
					rm.removaldate,
					(case when rm.exitdate::date > vdt_to::date then 
						Null
					else
						rm.exitdate
					end) as exitdate,
					sc.servicecasenumber,
					-- Child Removal End Reason: referencetypeid = 343
					--  Reunify with parent or legal guardian
					(case when rm.removalexitreason 
						in ('REUNIF', 'CHREUNIFWF', 'RUF', 'CORHADR', 'CORHA', 'CIDP', 'CINC', 'CINSR', 'CISR',
							'PSPC', 'PSTHV', 'PII', 'RFS', 'REFSERV', 'RIMT' ) then '1' 
						/*
						1 REUNIF		Reunify with Parent or legal guardian
						1 CHREUNIFWF	Child reunified with parents/Family - X
						1 RUF			Reunification - X
						1 CORHADR		Court ordered return home against DSS recommendation
						1 CORHA			Court ordered return home against DSS recommendation - X
						1 CIDP			Child Issue: Dissatisfaction with provider - X
						1 CINC			Child Issue: Needs have changed - X
						1 CINSR			Child Issue: Needs less Structured/Restricted Environment - X
						1 CISR			Child Issue: Needs more Structured/Restricted Environment - X
						1 PSPC			Permanency Step: Placement Closer to Home
						1 PSTHV			Permanency Step: Trial Home Visit - X
						1 PII			Provider Issue: Investigation (CPS, APS, Criminal) - X
						1 RFS			Refused Service - X
						1 REFSERV		Refused Service - X
						1 RIMT			Resource Issue: Move from Short Term Placement - X
						*/
						-- Live with other relative
						when rm.removalexitreason in ('OTRL', 'OTHERREL', 'PSPR', 'LWOR') then '2' 
						/*
						2 OTRL			Other Relative - X
						2 OTHERREL		Other Relative - X
						Removed on 03/28 ???
						2 LWOR			Live with other relative
						2 PSPR			Permanency Step: Placement with Relative - X
						2 COCTRADR		Court ordered custody to a relative against DSS recommendation
						Added back 10/02/2024
						2 LWOR			Live with other relative
						*/
						-- Adoption
						when rm.removalexitreason 
							in ('ADNRE', 'ADRE', 'AF', 'ADPFIN', 'ADPL', 'CADOFIN', 'PSAP', 'ADPDIS', 'ADP') then '3' 
						/*
						3 ADNRE			Adoption Non-relative
						3 ADRE			Adoption Relative
						3 AF			Adoption Finalization - X
						3 ADPFIN		Adoption Finalization - X
						3 ADPL			Adoptive Placement - X
						3 CADOFIN		Child adoption finalized - X
						3 PSAP			Permanency Step: Adoptive or pre-adoptive Placement - X
						3 ADPDIS		Adoption Disruption - X
						3 ADP			Adoption Disruption
						*/
						-- Emancipation
						when rm.removalexitreason 
							in ('EMANIND', 'MRG', 'EMANMAR', 'EMANMIL', 'EMI', 'MILY', 'PSEV') then '4' 
						/*
						4 EMANIND		Emancipation-Independence
						4 EMANMAR, MRG	Emancipation-Marriage
						4 EMANMIL, MILY	Emancipation-Military
						4 EMI			Emancipation-Independence - X
						4 PSEV			Permanency Step: Educational/Vocational Placement - X
						*/
						-- Guardianship
						when rm.removalexitreason in (
							'GNONREL', 'GUARDR', 'CGPGAP', 'CUSNONR', 'CGNR', 'CGUARDNR', 'CGR', 
							'CGUARDREL', 'CCOP', 'COCTRADR', 'CNR', 'GNR', 'RGS', 'RGSUS' ) then '5' 
						/*
						5 GNONREL		Guardianship Non-Relative
						5 GUARDR		Guardianship Relative
						5 CGPGAP		Childs guardianship program approved - X
						5 CUSNONR		Custody Non-Relative - X
						5 CGNR			Custody/Guardianship - Non-Relative - X
						5 CGUARDNR		Custody/Guardianship - Non-Relative - X
						5 CGR			Custody/Guardianship - Relative - X
						5 CGUARDREL		Custody/Guardianship - Relative - X
						5 CCOP			Court: Court Ordered Placement Change
						5 COCTRADR		Court Ordered custody to a relative against DSS Recommendation
						5 CNR			Custody Non-Relative
						5 GNR			Guardianship Non-Relative
						5 RGS			Remove GAP suspension
						5 RGSUS			Remove GAP suspension - X
						Removed 10/02/2024
						5 LWOR			Live with Other Relative
						*/
						-- Runaway or whereabouts unknown
						when rm.removalexitreason in ('RNAWAY', 'RNWY', 'CIR', 'OTR', 'OTHER') then '6' 
						/*
						6 RNAWAY		Runaway or Whereabouts Unknown
						6 RNWY			Runaway - X
						6 CIR			Child Issue: Runaway - X
						6 OTR			Other - X
						6 OTHER			Other - X
						*/
						-- Death of child
						when rm.removalexitreason in ('DEATHOC', 'DOC') then '7' 
						/*
						7 DEATHOC		Death of Child
						7 DOC			Death of Child - X
						*/
						-- Transfer to another agency
						when rm.removalexitreason in ('TTONDA', 'TON', 'CIPDA') then '8' 
						/*
						8 TTONDA		Transfer to another Agency
						8 TON			Transfer to Other Non-DHR Agency - X
						8 CIPDA			Child Issue: Behavior (Property Destruction, Aggression to Others, Defiance) - X
						*/
						else '1' -- Reunify with parent or legal guardian For Compliance 
							-- '9' -- Not applicable  -- null -- ????
						/*
						9 CCOP			Court: Court Ordered Placement Change - X
						9 SPC			Permanency Step: Placement Closer to Home - X
						*/
					end ) as removalexitreason,
					(case when (rm.returntransts is not null and rm.returntransts::date != '1900-01-01'::date) then  
						(rm.returntransts::date)::character varying 
					else 
						(rm.updatedon::date)::character varying 
					end) as returntransts						
				from intakeservreqchildremoval rm
					join servicecase sc on sc.servicecaseid = rm.servicecaseid 
						and sc.activeflag = 1
					join person pr on pr.personid = rm.personid	
						and pr.activeflag = 1
				where rm.activeflag = 1
				    and rm.personid = 
						   (select pa.personid
							from adoptioncase ac 
								join adoptionlink al on al.adoptioncaseid = ac.adoptioncaseid
								join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
									and aca.actortypekey = 'CHILD'
								join person pr on pr.personid = aca.personid and pr.activeflag = 1 
								join biologicaladoptionlink bol on al.preadoptionclientid = bol.preadoptiveclientid
								join adoptionbreakthelink abl ON abl.adoptionplanningid = bol.preadoptivecaseid
								join person pa on pa.personid = BOL.preadoptiveclientid and pa.activeflag = 1
							WHERE pr.cjamspid = vs_adop_cjamspid::bigint
								and ac.activeflag = 1
							)						
				    and rm.removaldate is not null
				    and ( select count(*) 
							from routing rur
						  where rur.objectid = rm.intakeservreqchildremovalid::character varying
							and rur.eventcode = 'CHRR'
							and rur.activeflag = 1
							and rur.routingstatustypeid = '16'
						) > 0
					-- 02/26/2025
					and ( case when rm.exitdate is not null then 	
							rm.removaldate::date <> rm.exitdate::date
						else 
							true
						end)		
				 	-- To exclude removals less than 1 day (24 hours)
					and (case when rm.exitdate is not null then -- 10/29/2025
							(
								(
									(rm.removaltime is null  or rm.returntime is null) 
									and coalesce(nullif(rm.returntransts,'1900-01-01')::date, vdt_to::DATE + interval '1 day' ) 
												<> rm.removaltransts::date 
								)
								or 
								( 
									(rm.removaltime is not null and rm.returntime is not null)
									and
									(
										(
											((rm.exitdate::date - rm.removaldate::date ) * 24 )  
												- COALESCE(EXTRACT(hour from rm.removaltime),0)  
												+ COALESCE(EXTRACT(hour from rm.returntime),0)
										)  
										-  
										COALESCE(EXTRACT(minute from rm.removaltime),0) * 0.01   
											+ COALESCE(EXTRACT(minute from rm.returntime),0)  * 0.01  
											-  COALESCE(EXTRACT(second from rm.removaltime),0) * 0.0001 
											+ COALESCE(EXTRACT(second from rm.returntime),0) * 0.0001
									) >= 24
								)
							)
						else
							True
						end)	
				order by rm.removaldate;
			LOOP
				fetch cur_bio_removals_REFCURSOR into cur_bio_removals_record;
				exit when not found;
			
				-- Reset
				vu_bio_intakeservreqchildremovalid := NULL;
				vl_bio_cjamspid := NULL;
				vl_bio_removalid := NULL;
				vs_bio_removaldate := NULL;
				vs_bio_exitdate := NULL;
				vs_bio_returntransts := NULL;
				vs_bio_servicecasenumber := NULL;
				vs_bio_removalexitreason := NULL;
				
				vu_bio_intakeservreqchildremovalid := cur_bio_removals_record.intakeservreqchildremovalid;
				vl_bio_cjamspid := cur_bio_removals_record.cjamspid; 
				vl_bio_removalid := cur_bio_removals_record.removalid;
				vs_bio_removaldate := cur_bio_removals_record.removaldate;
				vs_bio_exitdate := cur_bio_removals_record.exitdate;
				vs_bio_servicecasenumber := cur_bio_removals_record.servicecasenumber;
				vs_bio_removalexitreason := cur_bio_removals_record.removalexitreason;
				vs_bio_returntransts := cur_bio_removals_record.returntransts;
				
				vd_bio_removal_date := cur_bio_removals_record.removaldate;
				vd_bio_exit_date := cur_bio_removals_record.exitdate;
						
				INSERT INTO cjams.afcars_fc_child_removals
					(	afcarsfostercareid, 
						recordno, 
						e3_local_agency,
						removalid,
						cjamspid,
						caseid,
						current_period_removal_sw,	
						e69_removal_date, 
						e153_exit_date,
						e155_exit_reason,
						bio_cjamspid,
						removal_date,
						exit_date
					)
				VALUES
					(	vs_adop_afcarsfostercareid, -- vs_afcarsfostercareid, 
						vs_adop_recordno, -- vs_recordno,
						vs_adop_E3_local_agency, -- vs_E3_local_agency,
						vl_bio_removalid,
						vs_adop_cjamspid, -- vs_client_id,
						vs_bio_servicecasenumber,
						-- 'N',
						(case when vs_bio_exitdate::date < vd_removal_1993_dt::date 
							-- and vs_bio_returntransts::date < vd_removal_1993_dt::date 
							then 
							'N' 
						else 
							'Y' 
						end),
						vs_bio_removaldate, 
						vs_bio_exitdate,
						vs_bio_removalexitreason,
						vl_bio_cjamspid,
						vd_bio_removal_date,
						vd_bio_exit_date
					);
				
			END LOOP;	
			close cur_bio_removals_REFCURSOR;	
			-- Cleanup the Temp table 
			delete from ttb_bio_client_removal ;
			
			-- Capture Bio Client's removals - END
			
		End Loop;
 		close cur_ado_bio_clients_REFCURSOR;
		
	END LOOP;	
	close cur_afcars_client_REFCURSOR;	
	
	-- RAISE NOTICE 'Capture Permanency Plan Details';
	OPEN cur_child_removal_REFCURSOR FOR
		select fc_rm.afcarsfostercareid,
			fc_rm.recordno,
			fc_rm.removalid,
			rm.removaldate::date as removaldate,
			(case when rm.exitdate::date > vdt_to::date then 
				Null
			else
				rm.exitdate::date
			end) as exitdate,
			(case when rm.exitdate::date > vdt_to::date then 
				Null
			else
				fc_rm.E155_exit_reason 
			end) as E155_exit_reason,
			fc_rm.cjamspid,
			pr.personid,
			fc_rm.caseid,
			sc.servicecaseid,
			fc_rm.e99_sex_trafficking,
			fc_rm.current_period_removal_sw,
			rm.intakeservreqchildremovalid,
			fc_rm.bio_cjamspid
		from cjams.afcars_fc_child_removals fc_rm,
			person pr,
			servicecase sc,
			intakeservreqchildremoval rm
		where fc_rm.cjamspid::bigint = pr.cjamspid
			and fc_rm.caseid = sc.servicecasenumber
			and fc_rm.removalid::bigint = rm.removalid
			-- Capture Details for Current Period Removals only
			-- and fc_rm.current_period_removal_sw = 'Y' 
		;
	LOOP
		fetch cur_child_removal_REFCURSOR into cur_child_removal;
		exit when not found;
	
		-- Reset
		vs_afcarsfostercareid := NULL;
		vs_recordno := NULL;
		vs_removalid := NULL;
		vd_removaldate := NULL;
		vd_exitdate := NULL;
		vs_E155_exit_reason := NULL;
		vs_client_id := NULL;	
		vu_personid := NULL;
		vs_caseid := NULL;
		vu_servicecaseid := NULL;
		vs_e99_sex_trafficking := NULL;
		vs_current_period_removal_sw := NULL ;
		vu_intakeservreqchildremovalid := NULL;
		vs_bio_cjamspid := NULL;
		vu_bio_personid := NULL;
		
		vs_afcarsfostercareid := cur_child_removal.afcarsfostercareid;
		vs_recordno := cur_child_removal.recordno;
		vs_removalid := cur_child_removal.removalid;
		vd_removaldate := cur_child_removal.removaldate;
		vd_exitdate := cur_child_removal.exitdate;
		vs_E155_exit_reason := cur_child_removal.E155_exit_reason;
		vs_client_id := cur_child_removal.cjamspid;
		vu_personid := cur_child_removal.personid;
		vs_caseid := cur_child_removal.caseid;
		vu_servicecaseid := cur_child_removal.servicecaseid;
		vs_e99_sex_trafficking := cur_child_removal.e99_sex_trafficking;
		vs_current_period_removal_sw := cur_child_removal.current_period_removal_sw;
		vu_intakeservreqchildremovalid := cur_child_removal.intakeservreqchildremovalid;
		vs_bio_cjamspid := cur_child_removal.bio_cjamspid;
		
		-- Get Bio personid
		if vs_bio_cjamspid is not null then 
			select personid
				into vu_bio_personid
			from person 
			where cjamspid = vs_bio_cjamspid::bigint
				and activeflag = 1 ;
		end if;	
		
		-- RAISE NOTICE 'vs_removalid >> %',vs_removalid;
	
		-- Capture Details for Current Period Removals only - Start
		if vs_current_period_removal_sw = 'Y' then
			-- RAISE NOTICE 'Capture Permanency Plans/ Case Worker Visits/ Periodic Reviews/ Permanency Hearings/ Living Arrangements - Placements';
			-- Capture Permanency Plan Details
			OPEN cur_permanency_plan_REFCURSOR FOR
				select pp.permanencyplanid,
					pp.establisheddate as E147_permanency_plan_date,
					(case when pp.primarypermanencytype = 'Reunification' then '1' -- Reunification
						when pp.primarypermanencytype = 'ADOPTR' then '2' -- Adoption by a relative
						when pp.primarypermanencytype = 'GUARDR' then '2' -- Guardianship by relative
						when pp.primarypermanencytype = 'ADOPTNR' then '3' -- Adoption by a non-relative
						when pp.primarypermanencytype = 'Guardianship' then '4' -- Guardianship by Non-Relative
						when pp.primarypermanencytype = 'APPLA' then '5' -- APPLA
					 else null
					 end) as E148_permanency_plan_type
				from permanencyplan pp,
					intakeservicerequestactor isa 
				where pp.intakeservicerequestactorid = isa.intakeservicerequestactorid 
					and pp.establisheddate is not null
					and pp.activeflag = 1
					and isa.personid = vu_personid 
					and pp.servicecaseid = vu_servicecaseid
					and pp.establisheddate::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
					-- and pp.establisheddate::date <= coalesce(vd_exitdate, current_date)::date
					-- and ( pp.enddate is null or pp.enddate::date >= vd_removaldate::date )
				order by pp.establisheddate  ;
			LOOP
				fetch cur_permanency_plan_REFCURSOR into cur_permanency_plan;
				exit when not found;
			
				-- Reset
				vu_permanencyplanid := NULL;
				vs_E147_permanency_plan_date := NULL;
				vs_E148_permanency_plan_type := NULL;
				
				vu_permanencyplanid := cur_permanency_plan.permanencyplanid;
				vs_E147_permanency_plan_date := cur_permanency_plan.E147_permanency_plan_date; 
				vs_E148_permanency_plan_type := cur_permanency_plan.E148_permanency_plan_type; 
				
				IF vs_E147_permanency_plan_date is not null 
					and vs_E148_permanency_plan_type is not null then
				
					INSERT INTO cjams.afcars_fc_permanency_plans
						(	afcarsfostercareid, 
							recordno, 
							removalid, 
							e147_permanency_plan_date, 
							e148_permanency_plan_type, 
							permanencyplanid, 
							cjamspid, 
							caseid
						)
					VALUES
						(	vs_afcarsfostercareid, 
							vs_recordno, 
							vs_removalid, 
							vs_E147_permanency_plan_date, 
							vs_E148_permanency_plan_type, 
							vu_permanencyplanid, 
							vs_client_id, 
							vs_caseid
						);
				end if;		
			END LOOP;	
			close cur_permanency_plan_REFCURSOR;	
		
			-- Performance Issue ????
			-- RAISE NOTICE 'Capture Case Worker Visit Details';
			-- Capture Case Worker Visit Details
			OPEN cur_caseworker_visit_REFCURSOR FOR
				select p.progressnoteid, 
					   p.contactdate::date as E151_case_worker_visit_date,
					   (case when p.progressnotesubtypeid = 'f3c40498-cf00-4648-96f0-dbdf562bb6ef' then	
							-- Child Residence
							'1'
						when p.progressnotesubtypeid = '3fde914b-1a85-44c7-b4eb-a0c0783bef55' then
							-- Child's Residence
							'1'
						else
							'2'
						end) as E152_case_worker_visit_location
				from progressnote p 
					inner join progressnotetype pt on pt.progressnotetypeid = p.progressnotetypeid
						and lower(pt.progressnotetypekey) in ('initialfacetoface', 'face to face')
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
					-- Do not consider activeflag	
				where p.entitytypeid = vu_servicecaseid::character varying 
					and lower(p.entitytype) = 'servicecase' 
					and p.activeflag = 1
					and p.attemptindicator <> true -- Completed
					and p.progressnotereasontypekey like'%MV%'
					and insr2.personid
						in (	select insr1.personid
									from intakeservicerequestactor insr1
								where insr1.servicecaseid = vu_servicecaseid
									and insr1.personid = vu_personid
									and insr1.activeflag = 1
								)
					and p.starttime::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
				order by p.starttime ;
			LOOP
				fetch cur_caseworker_visit_REFCURSOR into cur_caseworker_visit;
				exit when not found;
			
				-- Reset
				vu_progressnoteid := NULL;
				vs_E151_case_worker_visit_date := NULL;
				vs_E152_case_worker_visit_location := NULL;
				
				vu_progressnoteid := cur_caseworker_visit.progressnoteid ;
				vs_E151_case_worker_visit_date := cur_caseworker_visit.E151_case_worker_visit_date; 
				vs_E152_case_worker_visit_location := cur_caseworker_visit.E152_case_worker_visit_location; 
				
				if vs_E151_case_worker_visit_date is not null
					and vs_E152_case_worker_visit_location is not null then
				
					INSERT INTO cjams.afcars_fc_caseworker_visits
						(	afcarsfostercareid, 
							recordno, 
							removalid, 
							e151_case_worker_visit_date, 
							e152_case_worker_visit_location, 
							progressnoteid, 
							cjamspid, 
							caseid
						)
					VALUES
						(	vs_afcarsfostercareid, 
							vs_recordno, 
							vs_removalid, 
							vs_E151_case_worker_visit_date, 
							vs_E152_case_worker_visit_location, 
							vu_progressnoteid, 
							vs_client_id, 
							vs_caseid
						);
				end if;		
			END LOOP;	
			close cur_caseworker_visit_REFCURSOR;	
			
			-- RAISE NOTICE 'Capture Periodic Reviews Details';
			-- Capture Periodic Reviews Details
			OPEN cur_periodic_review_REFCURSOR FOR
				select h.intakeservicerequestcourthearingid,
					h.hearingdatetime::date as E149_periodic_review_date 
				from intakeservicerequestcourthearing h 
					join hearingclients hc on hc.courthearingid = h.intakeservicerequestcourthearingid
						and hc.activeflag = 1
					join hearingtype lu on h.hearingtype ? lu.hearingtypekey  -- ARRAY
						and lu.teamtypekey = 'CW' 
						and lu.hearingtypekey IN ('DI', 'Disp','GR', 'PPR','PP', 'TGC', 'TGU','REH','CR', 'VPPH')
						and lu.activeflag = 1
				where h.servicecaseid = vu_servicecaseid
					and h.activeflag = 1
					and hc.personid = vu_personid 
					and h.hearingdatetime::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
				order by hearingdatetime ;
			LOOP
				fetch cur_periodic_review_REFCURSOR into cur_periodic_review;
				exit when not found;
			
				-- Reset
				vu_intakeservicerequestcourthearingid := NULL;
				vs_E149_periodic_review_date := NULL;
				
				vu_intakeservicerequestcourthearingid := cur_periodic_review.intakeservicerequestcourthearingid ;
				vs_E149_periodic_review_date := cur_periodic_review.E149_periodic_review_date; 
				
				if vs_E149_periodic_review_date is not null
					and vu_intakeservicerequestcourthearingid is not null then
				
					INSERT INTO cjams.afcars_fc_periodic_reviews
						(	afcarsfostercareid, 
							recordno, 
							removalid, 
							e149_periodic_review_date, 
							intakeservicerequestcourthearingid, 
							cjamspid, 
							caseid
						)
					VALUES
						(	vs_afcarsfostercareid, 
							vs_recordno, 
							vs_removalid, 
							vs_E149_periodic_review_date, 
							vu_intakeservicerequestcourthearingid, 
							vs_client_id, 
							vs_caseid
						);
				end if;		
			END LOOP;	
			close cur_periodic_review_REFCURSOR;	


			-- RAISE NOTICE 'Capture Living Arrangement /Placement Details';
			-- Capture Living Arrangement Details - START
			OPEN cur_la_placement_REFCURSOR FOR
				select 'LA' as placement_type,
					pl.startdatetime as E112_date_living_arrangement, 
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home		
						'1'	
					else
						'0'
					end) as E113_foster_family_home,
					
					-- Commented for Compliance we need 
					-- If E113_foster_family_home = 1 (Yes), at least one of data elements E114 - E119 must be 1 (Applies).
					-- '0' as E113_foster_family_home, 
					
					-- For Compliance
					-- NULL - Not applicable
					(case when btrim(la.livingarrangementtypekey) = 'FCH' then -- Foster Care - Home
						'1' -- Applies
					when btrim(la.livingarrangementtypekey) = 'IAHI' then -- ICPC Adoptive Home - Incoming
						'1' -- Applies
					when btrim(la.livingarrangementtypekey) = 'IFHI' then -- ICPC Foster Home - Incoming
						'1' -- Applies
					when btrim(la.livingarrangementtypekey) = 'RFKH' then -- Relative/fictive kin home 
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'REC' then -- Respite Care
						'0' -- Does not apply
					-- when btrim(la.livingarrangementtypekey) = 'TVH' then -- Trial Visit Home				
					--	'0' -- Does not apply
					else
						'0' -- Does Not apply
					end) as E114_licensed_home, -- Does not apply
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							-- ,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home			
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'REC' then -- Respite Care	
						'1' -- Applies
					else
						NULL -- Not Applicable
					end) as E115_therapeutic_home, -- Does not apply 
					
					(case when btrim(la.livingarrangementtypekey) 
						in (-- 'FCH' -- Foster Care - Home
							'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							-- ,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home			
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'FCH' then -- Foster Care - Home
						'1' -- Applies
					when btrim(la.livingarrangementtypekey) = 'REC' then -- Respite Care	
						'1' -- Applies	
					else
						NULL -- Not Applicable
					end) as E116_shelter_care_home,
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							-- ,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home			
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'RFKH' then -- Relative/fictive kin home 
						'1' -- Applies
					-- when btrim(la.livingarrangementtypekey) = 'TVH' then -- Trial Visit Home	
					--	'1' -- Applies	
					else
						NULL -- Not Applicable
					end) as E117_relative_foster_family, 
					
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							-- ,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home			
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'IAHI' then -- ICPC Adoptive Home - Incoming
						'1' -- Applies
					else
						NULL -- Not Applicable
					end) as E118_pre_adopt_home,
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							-- ,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home			
						'0' -- Does not apply
					when btrim(la.livingarrangementtypekey) = 'RFKH' then -- Relative/fictive kin home 
						'1' -- Applies
					else
						NULL -- Not Applicable
					end) as E119_kin_foster_family,  --  Does not apply
					
					
					(case when btrim(la.livingarrangementtypekey) = 'HH' then -- Halfway House	
						'3' -- Group Home-Shelter Care
					when btrim(la.livingarrangementtypekey) = 'SUMC' then  -- Summer Camp 
						'7' -- Child care institution-shelter care
					when btrim(la.livingarrangementtypekey) in 
						( 'COLG' -- College
						,'FCNFHS' -- Foster Care - Non-Foster Home setting	
						,'JOCR' -- Job Corps	
						,'MOBP' -- Mother/Baby Program	
						,'OHA' -- Own Home/Apartment	
						,'SHA' -- SILA home/Apartment							
						) then 	
						'8' -- Supervised Independent Living
					when btrim(la.livingarrangementtypekey) in 
						( 'ACI' -- Adult Correctional Institution	
						 ,'DJS' -- DJS Funded Facility/not detention
						 ,'SJD' -- Secure Juvenile Detention
						) then  
						'9' -- Juvenile Justice Facility
					when btrim(la.livingarrangementtypekey) in 
						( 'ERM' -- ER Medical
						,'IMC' -- Inpatient Medical Care
						,'IMCNA' -- Inpatient Medical Care - Non-Acute
						,'MH' -- Medical hospital
						) then
						'10' -- Medical or rehabilitative facility
					when la.livingarrangementtypekey in 
						( 'ERP' -- ER Psychiatric	
						,'PSYH' -- Inpatient Psychiatric Hospital
						,'IPC' -- Inpatient Psychiatric Care						
						) then
						'11' -- Psychiatric Hospital
					when btrim(la.livingarrangementtypekey) = 'RNW' then -- Runaway
						'12' -- Runaway
					when btrim(la.livingarrangementtypekey) in 
						('HMLS' -- Homeless	
						,'HS' -- Homeless Shelter
						,'HMLSSTR' -- Homeless Shelter
						,'UNK' -- Unknown,
						,'OTH' -- Other						
						) then
						'13' -- Whereabouts Unknown
					when btrim(la.livingarrangementtypekey) in 
						('FSMPH' -- Father and Step Mother/Paramour Home
						,'FH' -- Father's Home	
						,'MOFH' -- Mother and Father's Home
						,'MOSFPH' -- Mother and Step Father/Paramour Home
						,'MOH' -- Mother's Home
						,'TVH' -- Trial Visit Home	 
						,'BP' --Biological Parent
						) then	
						'14' -- Placed at Home
					else	
						'0' --  Does not apply
					end ) as E120_other_living_arrangement_type, 
					
					( case when btrim(la.livingarrangementtypekey) in 
						( 'RNW' -- Runaway
						,'HMLS' -- Homeless	
						,'HS' -- Homeless Shelter
						,'HMLSSTR' -- Homeless Shelter
						,'UNK' -- Unknown,
						,'OTH' -- Other	
						) then
						'4' -- Runaway or whereabouts unknown 	
					  when coalesce(la.country, 'USA') not in ( 'US', 'USA', 'United States' ) then
						'3' --  Out-of-country
					  when coalesce(la.statetypekey, 'MD') = 'MD' 
							or btrim(la.statetypekey) = '' then
						'1' -- In-state or in-Tribal service area
					  when coalesce(la.statetypekey, 'MD') <> 'MD' then	
						'2' -- Out-of-state or out-of-Tribal service area
					 when coalesce(la.country, 'USA') in ( 'US', 'USA','United States' )
							or btrim(la.country) = '' then
						'1' -- In-state or in-Tribal service area		
					  else
						NULL
					end) as E121_location_of_living_arrangement,
				
					(case when btrim(la.livingarrangementtypekey) = 'RNW' 
						or coalesce(la.statetypekey, 'MD') = 'MD'  then -- Runaway
						-- Null should be used if the agency indicated 
						-- If # 121 is '1' (in-state or in-Tribal service area) or '4' (runaway or whereabouts unknown) 
						NULL
					when la.tribalservicearea is not null then
						( select mdmcode -- Tribal: 3-digit EPA Tribal standard code  update in mdmcode
							from referencevalues 
						  where referencetypeid = 2012 
							and activeflag = 1
							and ref_key = la.tribalservicearea
						)
					when coalesce(la.country, 'USA') in ( 'US', 'USA' ) then
						-- 'USA' -- Country: 3-digit ISO Alpha code
						(case when coalesce(la.statetypekey, 'MD') = 'AL' then '01' -- Alabama
							when coalesce(la.statetypekey, 'MD') = 'AK' then '02' -- Alaska
							when coalesce(la.statetypekey, 'MD') = 'AZ' then '04' -- Arizona	
							when coalesce(la.statetypekey, 'MD') = 'AR' then '05' -- Arkansas	
							when coalesce(la.statetypekey, 'MD') = 'CA' then '06' -- California	
							when coalesce(la.statetypekey, 'MD') = 'CO' then '08' -- Colorado
							when coalesce(la.statetypekey, 'MD') = 'CT' then '09' -- Connecticut	
							when coalesce(la.statetypekey, 'MD') = 'DE'	then '10' -- Delaware	
							when coalesce(la.statetypekey, 'MD') = 'DC' then '11' -- District of Columbia	
							when coalesce(la.statetypekey, 'MD') = 'FL' then '12' -- Florida	
							when coalesce(la.statetypekey, 'MD') = 'GA' then '13' -- Georgia	
							when coalesce(la.statetypekey, 'MD') = 'HI' then '15' -- Hawaii	
							when coalesce(la.statetypekey, 'MD') = 'ID' then '16' -- Idaho	
							when coalesce(la.statetypekey, 'MD') = 'IL' then '17' -- Illinois	
							when coalesce(la.statetypekey, 'MD') = 'IN' then '18' -- Indiana 	
							when coalesce(la.statetypekey, 'MD') = 'IA' then '19' -- Iowa	
							when coalesce(la.statetypekey, 'MD') = 'KS' then '20' -- Kansas	
							when coalesce(la.statetypekey, 'MD') = 'KY' then '21' -- Kentucky	
							when coalesce(la.statetypekey, 'MD') = 'LA' then '22' -- Louisiana	
							when coalesce(la.statetypekey, 'MD') = 'ME' then '23' -- Maine	
							when coalesce(la.statetypekey, 'MD') = 'MD' then Null -- '24' -- Maryland	
							when coalesce(la.statetypekey, 'MD') = 'MA' then '25' -- Massachusetts	
							when coalesce(la.statetypekey, 'MD') = 'MI' then '26' -- Michigan	
							when coalesce(la.statetypekey, 'MD') = 'MN' then '27' -- Minnesota	
							when coalesce(la.statetypekey, 'MD') = 'MS' then '28' -- Mississippi
							when coalesce(la.statetypekey, 'MD') = 'MO' then '29' -- Missouri	
							when coalesce(la.statetypekey, 'MD') = 'MT' then '30' -- Montana
							when coalesce(la.statetypekey, 'MD') = 'NE' then '31' -- Nebraska
							when coalesce(la.statetypekey, 'MD') = 'NV' then '32' -- Nevada
							when coalesce(la.statetypekey, 'MD') = 'NH' then '33' -- New Hampshire
							when coalesce(la.statetypekey, 'MD') = 'NJ' then '34' -- New Jersey
							when coalesce(la.statetypekey, 'MD') = 'NM' then '35' -- New Mexico
							when coalesce(la.statetypekey, 'MD') = 'NY' then '36' -- New York
							when coalesce(la.statetypekey, 'MD') = 'NC' then '37' -- North Carolina
							when coalesce(la.statetypekey, 'MD') = 'ND' then '38' -- North Dakota
							when coalesce(la.statetypekey, 'MD') = 'OH' then '39' -- Ohio
							when coalesce(la.statetypekey, 'MD') = 'OK' then '40' -- Oklahoma
							when coalesce(la.statetypekey, 'MD') = 'OR' then '41' -- Oregon
							when coalesce(la.statetypekey, 'MD') = 'PA' then '42' -- Pennsylvania
							when coalesce(la.statetypekey, 'MD') = 'PR' then '72' -- Puerto Rico
							when coalesce(la.statetypekey, 'MD') = 'RI' then '44' -- Rhode Island
							when coalesce(la.statetypekey, 'MD') = 'SC' then '45' -- South Carolina
							when coalesce(la.statetypekey, 'MD') = 'SD' then '46' -- South Dakota
							when coalesce(la.statetypekey, 'MD') = 'TN' then '47' -- Tennessee
							when coalesce(la.statetypekey, 'MD') = 'TX' then '48' -- Texas
							when coalesce(la.statetypekey, 'MD') = 'UT' then '49' -- Utah
							when coalesce(la.statetypekey, 'MD') = 'VT' then '50' -- Vermont
							when coalesce(la.statetypekey, 'MD') = 'VA' then '51' -- Virginia
							when coalesce(la.statetypekey, 'MD') = 'VI' then '78' -- Virgin Islands
							when coalesce(la.statetypekey, 'MD') = 'WA' then '53' -- Washington
							when coalesce(la.statetypekey, 'MD') = 'WV' then '54' -- West Virginia
							when coalesce(la.statetypekey, 'MD') = 'WI' then '55' -- Wisconsin
							when coalesce(la.statetypekey, 'MD') = 'WY' then '56' -- Wyoming
							else
								null
						end)
					when la.country is not null and la.country not in ( 'US', 'USA' ) then
						(select ref_key 
							from referencevalues
						 where referencetypeid = 310
							and lower(value_text) like '%' || lower(la.country) || '%'  
							and activeflag = 1
							and coalesce(teamtypekey, 'CW') = 'CW'
							limit 1
						) -- Country: 3-digit ISO Alpha code ???
					end) as E122_jurisdiction_or_country, 
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
						,'IAHI' -- ICPC Adoptive Home - Incoming
						,'IFHI' -- ICPC Foster Home - Incoming
						,'RFKH' -- Relative/fictive kin home 
						,'REC' -- Respite Care
						-- ,'TVH' -- Trial Visit Home
						) and pcr.personid is not null then -- Foster Care - Home
						
							(case when btrim(pcr.maritalstatustypekey) in ('MR', '290') then -- Married Couple
								'1' -- Married couple
							 when btrim(pcr.maritalstatustypekey) in ('294', '296', '298', '299') then
								'2' -- Unmarried couple
							when btrim(pcr.maritalstatustypekey) in ('288', '289', '291', '292', 'DV', 'LS') then 	
								'3' -- Separated
							when btrim(pcr.maritalstatustypekey) in ('293', '295', '297', 'SG', 'WD', 'UK') then	
								'4' -- Single adult 
							else
								'4' -- For Compliance Single adult 
							end )
					else
						NULL
					end) as E123_marital_status_of_foster_parents,
					
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							--,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home
								(case when lower(la.primaryrelationship) = 'relative' then
									'1' -- Relative 
								when lower(la.primaryrelationship) in ( 'noreltve', 'non-relative' ) then
									'2' -- Non-relative 
								when lower(la.primaryrelationship) = 'kin' then
									'3' -- Kin 
								else
									(case when btrim(la.livingarrangementtypekey) = 'RFKH' then -- Relative/fictive kin home
										'3' -- Kin 
									else
										'2' -- Non-relative 
									end)	
								end)	
					else
						NULL -- Not applicable
					end) as E124_relationship_to_foster_parents,
					-- NULL as E124_relationship_to_foster_parents, -- Not applicable For Compliance
					
					-- Parent 1
					(case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							--,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home		
						date_part('year', pcr.dob)::varchar 
					else
						NULL
					end) as E125_foster_parent1_birth_year, 
					
					(case when upper(pcr.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					when upper(pcr.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					else
						'9' -- Unknown
					end) as E126_foster_parent1_tribal_membership,
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as E127_foster_parent1_race_american_indian_alaska_native, 
					
										
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as E128_foster_parent1_race_asian, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as E129_foster_parent1_race_black, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as E130_foster_parent1_race_native_hawaiian_pacific_islander, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as E131_foster_parent1_race_white, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as E132_foster_parent1_race_unknown, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pcr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as E133_foster_parent1_race_declined, 
					
					(case when btrim(pcr.ethnicgrouptypekey) = 'H' then -- Hispanic or Latino
						'1' 
					when btrim(pcr.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					when btrim(pcr.ethnicgrouptypekey) = 'D' then  
						'8'
					else 
						'9' -- Unknown
					end ) as E134_foster_parent1_hispanic_latino, 
					 
					 (case when btrim(la.livingarrangementtypekey) 
						in ('FCH' -- Foster Care - Home
							,'IAHI' -- ICPC Adoptive Home - Incoming
							,'IFHI' -- ICPC Foster Home - Incoming
							,'RFKH' -- Relative/fictive kin home 
							,'REC' -- Respite Care
							-- ,'TVH' -- Trial Visit Home
							) then -- Foster Care - Home		
								(case when btrim(pcr.gendertypekey) in ( 'M', 'TGIF') then 
									'1'
								when btrim(pcr.gendertypekey) in ( 'F', 'TGIM') then 	
									'2'
								-- Changes for newly added gender type/substype 
								when btrim(pcr.gendertypekey) = 'O' and pcr.othergendertypekey = 0 then -- Assigned Male at Birth *
									'1' -- Male 
								when btrim(pcr.gendertypekey) = 'O' and pcr.othergendertypekey = 1 then -- Assigned Female at Birth *
									'2' -- Female 	
								else
									NULL
								end)
					else
						NULL
					end) as E135_foster_parent1_sex, 
					
					-- Parent 2
					date_part('year', scr.dob)::varchar as E136_foster_parent2_birth_year, 
					(case when upper(scr.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					when upper(scr.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					else
						'9' -- Unknown
					end) as E137_foster_parent2_tribal_membership, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as E138_foster_parent2_race_american_indian_alaska_native, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as E139_foster_parent2_race_asian, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as E140_foster_parent2_race_black, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as E141_foster_parent2_race_native_hawaiian_pacific_islander, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as E142_foster_parent2_race_white, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as E143_foster_parent2_race_unknown, 
					
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = scr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as E144_foster_parent2_race_declined, 
					
					(case when btrim(scr.ethnicgrouptypekey) = 'H' then -- Hispanic or Latino
						'1' 
					when btrim(scr.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					when btrim(scr.ethnicgrouptypekey) = 'D' then  
						'8'
					else 
						'9' -- Unknown
					end ) as E145_foster_parent2_hispanic_latino, 
					
					(case when btrim(scr.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					when btrim(scr.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					-- Changes for newly added gender type/substype 
					when btrim(scr.gendertypekey) = 'O' and scr.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					when btrim(scr.gendertypekey) = 'O' and scr.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 	
					else
					 	NULL
					end) as E146_foster_parent2_sex,
					
					pl.placementid,
					pl.startdatetime::DATE, 
					pl.enddatetime::DATE,
					pl.altproviderid
					-- 03/28
					, pcr.personid as pcr_personid					
					, scr.personid as scr_personid
					
					, btrim(la.livingarrangementtypekey) as livingarrangementtypekey		
				from placement pl,
					livingarrangement la 
					left join person pcr on pcr.personid = la.caregiverclientid
						and pcr.activeflag= 1 
					left join person scr on scr.personid = la.partnerid
						and scr.activeflag= 1
				where pl.placementid = la.placementid
					and pl.activeflag = 1
					and la.activeflag = 1
					and pl.altproviderid is null
					and pl.personid = coalesce(vu_bio_personid, vu_personid) -- 04/29/2025
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					-- and pl.startdatetime::DATE between vd_removaldate::date and coalesce(vd_exitdate, current_date)::date
					-- 03/04
					-- and pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
					and ( pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
						  or
						  ( pl.startdatetime <= coalesce(vd_exitdate, vdt_to::date)
							and
							( case when pl.enddatetime is not null then 
								pl.enddatetime > vd_removaldate
							  else
								True
							end)
						  )	
						)  
					and ( case when pl.enddatetime is not null then  
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end) 
					and btrim(la.livingarrangementtypekey) NOT In ('32944', 'PLMT', 'REC', 'ADPN') -- Placement, Respite Care and Adoption ??? 03/04
				order by 1;
			LOOP
				fetch cur_la_placement_REFCURSOR into cur_la_placement;
				exit when not found;

				-- Reset
				vs_placement_type := NULL;
				vs_E112_date_living_arrangement := NULL;
				vs_E113_foster_family_home := NULL; 
				vs_E114_licensed_home := NULL;
				vs_E115_therapeutic_home := NULL;
				vs_E116_shelter_care_home := NULL;
				vs_E117_relative_foster_family := NULL;
				vs_E118_pre_adopt_home := NULL;
				vs_E119_kin_foster_family := NULL;
				-- LA Details
				vs_E120_other_living_arrangement_type := NULL;
				vs_E121_location_of_living_arrangement := NULL;
				--
				vs_E122_jurisdiction_or_country := NULL;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := NULL;
				vs_E124_relationship_to_foster_parents := NULL;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := NULL;
				vs_E126_foster_parent1_tribal_membership := NULL;
				vs_E127_foster_parent1_race_american_indian_alaska_native := NULL;
				vs_E128_foster_parent1_race_asian := NULL;
				vs_E129_foster_parent1_race_black := NULL;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := NULL;
				vs_E131_foster_parent1_race_white := NULL;
				vs_E132_foster_parent1_race_unknown := NULL;
				vs_E133_foster_parent1_race_declined := NULL;
				vs_E134_foster_parent1_hispanic_latino := NULL;
				vs_E135_foster_parent1_sex := NULL;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := NULL;
				vs_E137_foster_parent2_tribal_membership := NULL;
				vs_E138_foster_parent2_race_american_indian_alaska_native := NULL;
				vs_E139_foster_parent2_race_asian := NULL;
				vs_E140_foster_parent2_race_black := NULL;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := NULL;
				vs_E142_foster_parent2_race_white := NULL;
				vs_E143_foster_parent2_race_unknown := NULL;
				vs_E144_foster_parent2_race_declined := NULL;
				vs_E145_foster_parent2_hispanic_latino := NULL;
				vs_E146_foster_parent2_sex := NULL;
				vu_placementid := NULL; 
				vd_pl_startdate := NULL; 
				vd_pl_enddate := NULL; 
				vl_altproviderid := NULL;
				vl_cpahome_altproviderid := NULL;
				vl_approval_person_id := NULL;
				vs_family_structure_cd := NULL;
				vl_applicant_cjamspid := NULL;
				vl_coapplicant_cjamspid := NULL;
				
				-- 03/28
				vu_pcr_personid := NULL;
				vu_scr_personid := NULL;
				
				vs_livingarrangementtypekey := NULL;
				
				vs_placement_type := cur_la_placement.placement_type;
				vs_E112_date_living_arrangement := cur_la_placement.E112_date_living_arrangement;
				vs_E113_foster_family_home := cur_la_placement.E113_foster_family_home; 
				vs_E114_licensed_home := cur_la_placement.E114_licensed_home;
				vs_E115_therapeutic_home := cur_la_placement.E115_therapeutic_home;
				vs_E116_shelter_care_home := cur_la_placement.E116_shelter_care_home;
				vs_E117_relative_foster_family := cur_la_placement.E117_relative_foster_family;
				vs_E118_pre_adopt_home := cur_la_placement.E118_pre_adopt_home;
				vs_E119_kin_foster_family := cur_la_placement.E119_kin_foster_family;
				-- LA Details
				vs_E120_other_living_arrangement_type := cur_la_placement.E120_other_living_arrangement_type;
				vs_E121_location_of_living_arrangement := cur_la_placement.E121_location_of_living_arrangement;
				--
				vs_E122_jurisdiction_or_country := cur_la_placement.E122_jurisdiction_or_country;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := cur_la_placement.E123_marital_status_of_foster_parents;
				vs_E124_relationship_to_foster_parents := cur_la_placement.E124_relationship_to_foster_parents;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := cur_la_placement.E125_foster_parent1_birth_year;
				vs_E126_foster_parent1_tribal_membership := cur_la_placement.E126_foster_parent1_tribal_membership;
				vs_E127_foster_parent1_race_american_indian_alaska_native := cur_la_placement.E127_foster_parent1_race_american_indian_alaska_native; 
				vs_E128_foster_parent1_race_asian := cur_la_placement.E128_foster_parent1_race_asian;
				vs_E129_foster_parent1_race_black := cur_la_placement.E129_foster_parent1_race_black;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := cur_la_placement.E130_foster_parent1_race_native_hawaiian_pacific_islander;
				vs_E131_foster_parent1_race_white:= cur_la_placement.E131_foster_parent1_race_white;
				vs_E132_foster_parent1_race_unknown := cur_la_placement.E132_foster_parent1_race_unknown;
				vs_E133_foster_parent1_race_declined := cur_la_placement.E133_foster_parent1_race_declined;
				vs_E134_foster_parent1_hispanic_latino := cur_la_placement.E134_foster_parent1_hispanic_latino;
				vs_E135_foster_parent1_sex := cur_la_placement.E135_foster_parent1_sex;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := cur_la_placement.E136_foster_parent2_birth_year;
				vs_E137_foster_parent2_tribal_membership := cur_la_placement.E137_foster_parent2_tribal_membership ;
				vs_E138_foster_parent2_race_american_indian_alaska_native := cur_la_placement.E138_foster_parent2_race_american_indian_alaska_native;
				vs_E139_foster_parent2_race_asian := cur_la_placement.E139_foster_parent2_race_asian;
				vs_E140_foster_parent2_race_black := cur_la_placement.E140_foster_parent2_race_black;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := cur_la_placement.E141_foster_parent2_race_native_hawaiian_pacific_islander;
				vs_E142_foster_parent2_race_white := cur_la_placement.E142_foster_parent2_race_white;
				vs_E143_foster_parent2_race_unknown := cur_la_placement.E143_foster_parent2_race_unknown;
				vs_E144_foster_parent2_race_declined := cur_la_placement.E144_foster_parent2_race_declined;
				vs_E145_foster_parent2_hispanic_latino := cur_la_placement.E145_foster_parent2_hispanic_latino;
				vs_E146_foster_parent2_sex := cur_la_placement.E146_foster_parent2_sex;
				vu_placementid := cur_la_placement.placementid;
				vd_pl_startdate := cur_la_placement.startdatetime;
				vd_pl_enddate := cur_la_placement.enddatetime;
				vl_altproviderid := cur_la_placement.altproviderid;
				
				-- 03/28
				vu_pcr_personid := cur_la_placement.pcr_personid;
				vu_scr_personid := cur_la_placement.scr_personid;
				
				vs_livingarrangementtypekey := cur_la_placement.livingarrangementtypekey;
				
				
				--  CIDM-11353 04/21/2026
				if vu_scr_personid is null then 
					vs_e123_marital_status_of_foster_parents := '4' ; -- For Compliance Single adult 
				end if;
				
				INSERT INTO cjams.afcars_fc_placements
					(	afcarsfostercareid, 
						recordno, 
						removalid, 
						e112_date_living_arrangement, 
						e113_foster_family_home, 
						e114_licensed_home, 
						e115_therapeutic_home, 
						e116_shelter_care_home, 
						e117_relative_foster_family, 
						e118_pre_adopt_home, 
						e119_kin_foster_family, 
						e120_other_living_arrangement_type, 
						e121_location_of_living_arrangement, 
						e122_jurisdiction_or_country, 
						e123_marital_status_of_foster_parents, 
						e124_relationship_to_foster_parents, 
						e125_foster_parent1_birth_year, 
						e126_foster_parent1_tribal_membership, 
						e127_foster_parent1_race_american_indian_alaska_native, 
						e128_foster_parent1_race_asian, 
						e129_foster_parent1_race_black, 
						e130_foster_parent1_race_native_hawaiian_pacific_islander, 
						e131_foster_parent1_race_white, 
						e132_foster_parent1_race_unknown, 
						e133_foster_parent1_race_declined, 
						e134_foster_parent1_hispanic_latino, 
						e135_foster_parent1_sex, 
						e136_foster_parent2_birth_year, 
						e137_foster_parent2_tribal_membership, 
						e138_foster_parent2_race_american_indian_alaska_native, 
						e139_foster_parent2_race_asian, 
						e140_foster_parent2_race_black, 
						e141_foster_parent2_race_native_hawaiian_pacific_islander, 
						e142_foster_parent2_race_white, 
						e143_foster_parent2_race_unknown, 
						e144_foster_parent2_race_declined, 
						e145_foster_parent2_hispanic_latino, 
						e146_foster_parent2_sex, 
						placementid, 
						cjamspid, 
						caseid,
						placementtype,
						start_date,
						placementsubtype,
						original_removalid
						)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_removalid, 
						vs_e112_date_living_arrangement, 
						vs_e113_foster_family_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e114_licensed_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e115_therapeutic_home, '0') -- Does not apply
						else
							NULL
						end),
												
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e116_shelter_care_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e117_relative_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
						
						vs_e118_pre_adopt_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e119_kin_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
												
						(case when vs_e113_foster_family_home = '0' then -- No
							vs_e120_other_living_arrangement_type
						else	
							NULL  -- For Compliance
						end),
						
						vs_e121_location_of_living_arrangement, 
						
						(case when vs_e121_location_of_living_arrangement = '1'	
							or vs_e121_location_of_living_arrangement = '4' then
							NULL -- For Compliance
						else	
							vs_e122_jurisdiction_or_country
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e123_marital_status_of_foster_parents
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e124_relationship_to_foster_parents
						end), 
						-- vs_e124_relationship_to_foster_parents,

						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e125_foster_parent1_birth_year
						end),
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						else	
							-- '9' --  Unknown
							coalesce(vs_E126_foster_parent1_tribal_membership, '9')
						end),
						-- vs_e126_foster_parent1_tribal_membership, -- e126 ??
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') -- No
						else
							vs_e127_foster_parent1_race_american_indian_alaska_native						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e128_foster_parent1_race_asian, '0') -- No
						else
							vs_e128_foster_parent1_race_asian						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e129_foster_parent1_race_black, '0') -- No
						else
							vs_e129_foster_parent1_race_black						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') -- No
						else
							vs_e130_foster_parent1_race_native_hawaiian_pacific_islander						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e131_foster_parent1_race_white, '0') -- No
						else
							vs_e131_foster_parent1_race_white						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e132_foster_parent1_race_unknown, '0') -- No
						else
							vs_e132_foster_parent1_race_unknown						
						end), 
						
						-- 03/28 
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							(case when vs_e133_foster_parent1_race_declined = '1' then -- Yes
								vs_e133_foster_parent1_race_declined
							else 
								(case when vu_pcr_personid is not null 
									and coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') = '0'
									and coalesce(vs_e128_foster_parent1_race_asian, '0') = '0'
									and coalesce(vs_e129_foster_parent1_race_black, '0') = '0'
									and coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') = '0'
									and coalesce(vs_e131_foster_parent1_race_white, '0') = '0'
									and coalesce(vs_e132_foster_parent1_race_unknown, '0') = '0' then
									'1' -- For Test Compliance
								else
									coalesce(vs_e133_foster_parent1_race_declined, '0') -- No
								end) 	
							end)	
						else
							coalesce(vs_e133_foster_parent1_race_declined, '0') -- No
							-- vs_e133_foster_parent1_race_declined						
						end), 
						
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e134_foster_parent1_hispanic_latino, '9') -- Unknown
						else
							vs_e134_foster_parent1_hispanic_latino						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e135_foster_parent1_sex
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e136_foster_parent2_birth_year
							end)	
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								'9'-- vs_e137_foster_parent2_tribal_membership, -- e137 ?? --  Unknown
							end)
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e138_foster_parent2_race_american_indian_alaska_native
							end)
						end),
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e139_foster_parent2_race_asian	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e140_foster_parent2_race_black	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e141_foster_parent2_race_native_hawaiian_pacific_islander	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e142_foster_parent2_race_white	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e143_foster_parent2_race_unknown
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						else
							-- 03/28
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								(case when vs_e144_foster_parent2_race_declined = '1' then -- Yes
									vs_e144_foster_parent2_race_declined
								else 
									(case when vu_scr_personid is not null 
										and coalesce(vs_e138_foster_parent2_race_american_indian_alaska_native, '0') = '0'
										and coalesce(vs_e139_foster_parent2_race_asian, '0') = '0'
										and coalesce(vs_e140_foster_parent2_race_black, '0') = '0'
										and coalesce(vs_e141_foster_parent2_race_native_hawaiian_pacific_islander, '0') = '0'
										and coalesce(vs_e142_foster_parent2_race_white, '0') = '0'
										and coalesce(vs_e143_foster_parent2_race_unknown, '0') = '0' then
										'1' -- For Test Compliance
									else
										vs_e144_foster_parent2_race_declined
									end) 	
									-- vs_e144_foster_parent2_race_declined	
								end)	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e145_foster_parent2_hispanic_latino
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e146_foster_parent2_sex
							end)
						end),
						
						vu_placementid, 
						vs_client_id, 
						vs_caseid,
						vs_placement_type,
						vd_pl_startdate,
						vs_livingarrangementtypekey,
						vs_removalid
					);
			END LOOP;	
			close cur_la_placement_REFCURSOR;
			-- Capture Living Arrangement Details - END
						
			-- Capture Provider Placement Details (with NO CPA Homes) - START
			OPEN cur_la_placement_REFCURSOR FOR
				select 'PRPL' as placement_type,
					pl.startdatetime as E112_date_living_arrangement, 
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
						'1'	-- Yes
					else
						'0' -- No 
					end ) as E113_foster_family_home, 		
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
						'1'	-- Applies
					else
						'0' -- Does not apply
					end) as E114_licensed_home, 
					
					-- (case when pl.service_id = 167 then --	Therapeutic Group Homes
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship
						) then
							(case when pl.service_id in 
								(-- 76 -- Residential Treatment Centers
								11405 -- Treatment Foster Care Level 1
								,11406 -- Treatment Foster Care Level 2
								,11407 -- Treatment Foster Care Level 3
								,11408 -- Treatment Foster Care Level 4
								,78	-- Treatment Foster Care (Private)
								,12	-- Treatment Foster Care (Public)
								) then
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) E115_therapeutic_home,
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship
						) then
							(case when pl.service_id = 13 then -- Emergency Foster Home Care
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E116_shelter_care_home,
					
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
							(case when pl.service_id in 
									(9 -- Restricted (Relative) Foster Care
									,8 -- Formal Kinship Care 
									,531 -- Non-paid Kinship
									,530 -- Kinship 
									) then 
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E117_relative_foster_family,
					
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
							(case when pl.service_id = 500 then -- Pre-Finalized Adoptive Home
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E118_pre_adopt_home, 
					
					(case when pl.service_id in 
							(525 -- CfE Resource Home
							,13 -- Emergency Foster Home Care
							,8 -- Formal Kinship Care
							,11 -- Intermediate Foster Care
							,11409 -- Intermediate Foster Care Difficulty of Care
							,500	-- Pre-Finalized Adoptive Home
							,10 -- Regular Foster Care
							-- ,76 -- Residential Treatment Centers
							,9 -- Restricted (Relative) Foster Care
							,11405 -- Treatment Foster Care Level 1
							,11406 -- Treatment Foster Care Level 2
							,11407 -- Treatment Foster Care Level 3
							,11408 -- Treatment Foster Care Level 4
							,78	-- Treatment Foster Care (Private)
							,12	-- Treatment Foster Care (Public)
							,531 -- Non-paid Kinship
							,530 -- Kinship 
							) then
						'0' -- Does not apply
					else
						NULL -- Not Applicable
					end ) as E119_kin_foster_family, -- Does not apply
					
					(case when pl.service_id = 14 then -- Residential Group Homes	
						'2' -- Group home–staff operated
					when pl.service_id = 15	then -- Emergency Group Shelter Care
						'3' -- Group home–shelter care
					when pl.service_id = 167 then -- Therapeutic Group Homes	
						'4' -- Residential Treatment Center
					when pl.service_id = 73 then -- After care room and board
						'14' -- Placed at Home
					when pl.service_id = 76 then -- Residential Treatment Centers
						'4' -- Residential Treatment Center
					when pl.service_id in 
						(74	-- Alternative Living Units
						,1 -- Independent Living Residential Program
						,75 -- Teen Mother Programs
						) then 
						'8' -- Supervised Independent Living
					-- CIDM-10839	
					when pl.service_id = 11410 then -- Qualified Residential Treatment Program	
						'5' 				
					else 
						'0' -- Does not apply
					end)as E120_other_living_arrangement_type,
					
					
					-- Get based on the provider ID in a loop
					Null as E121_location_of_living_arrangement,
					Null as E122_jurisdiction_or_country, 
					Null as E123_marital_status_of_foster_parents, 
					
					
					(case when lower(btrim(pl.primaryrelationship)) = lower('Relative') then
						'1' -- Relative
					when lower(btrim(pl.primaryrelationship)) = lower('Kin') then	
						'3' -- Kin
					when lower(btrim(pl.primaryrelationship)) in ( lower('Non-Relative'),lower('Foster-Parent')) then
						'2' -- Non-relative 
					when pl.service_id in 
									(9 -- Restricted (Relative) Foster Care
									,8 -- Formal Kinship Care
									,531 -- Non-paid Kinship
									,530 -- Kinship 
									) then 
						'3' -- Kin
					else
						'2' -- Non-relative 
					end) as E124_relationship_to_foster_parents, 
							
					Null as E125_foster_parent1_birth_year, 
					'9' as E126_foster_parent1_tribal_membership, -- Unknown
					Null as E127_foster_parent1_race_american_indian_alaska_native, 
					Null as E128_foster_parent1_race_asian, 
					Null as E129_foster_parent1_race_black, 
					Null as E130_foster_parent1_race_native_hawaiian_pacific_islander, 
					Null as E131_foster_parent1_race_white, 
					Null as E132_foster_parent1_race_unknown, 
					Null as E133_foster_parent1_race_declined, 
					Null as E134_foster_parent1_hispanic_latino, 
					Null as E135_foster_parent1_sex, 
					Null as E136_foster_parent2_birth_year, 
					Null as E137_foster_parent2_tribal_membership, 
					Null as E138_foster_parent2_race_american_indian_alaska_native, 
					Null as E139_foster_parent2_race_asian, 
					Null as E140_foster_parent2_race_black, 
					Null as E141_foster_parent2_race_native_hawaiian_pacific_islander, 
					Null as E142_foster_parent2_race_white, 
					Null as E143_foster_parent2_race_unknown, 
					Null as E144_foster_parent2_race_declined, 
					Null as E145_foster_parent2_hispanic_latino, 
					Null as E146_foster_parent2_sex,
					pl.placementid,
					pl.startdatetime::DATE, 
					pl.enddatetime::DATE,
					pl.altproviderid,
					pl.service_id					
				from placement pl -- ,
					-- livingarrangement la 
				where -- la.placementid = pl.placementid
					-- and pl.placementid = la.placementid
					pl.personid = coalesce(vu_bio_personid, vu_personid) -- 04/29/2025
					and pl.intakeservreqchildremovalid = vu_intakeservreqchildremovalid
					and pl.activeflag = 1
					-- and la.activeflag = 1
					and pl.altproviderid is not null
					and COALESCE(pl.isvoided, 0) <> 1
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					and pl.service_id not in (503, 501)	 
					-- and pl.startdatetime::DATE between vd_removaldate::date and coalesce(vd_exitdate, current_date)::date
					-- 03/04
					-- and pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
					and ( pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
						  or
						  ( pl.startdatetime <= coalesce(vd_exitdate, vdt_to::date)
							and
							( case when pl.enddatetime is not null then 
								pl.enddatetime > vd_removaldate
							  else
								True
							end)
						  )	
						)  
					and ( case when pl.enddatetime is not null then   
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end) 
					-- NO CPA homes
					and (select count(*) 
							from placementcpahomes cpa 
						where cpa.placementid = pl.placementid 
							and cpa.activeflag = 1
							and cpa.altproviderid is not null
							and cpa.entrydt is not null
							and cpa.entrydt between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
							and ( case when cpa.exitdt is not null then   
									cpa.entrydt::date <> cpa.exitdt::date
								  else
									true
								 end) 
						) = 0	 
				order by 1;
			LOOP
				fetch cur_la_placement_REFCURSOR into cur_la_placement;
				exit when not found;

				-- Reset
				vs_placement_type := NULL;
				vs_E112_date_living_arrangement := NULL;
				vs_E113_foster_family_home := NULL; 
				vs_E114_licensed_home := NULL;
				vs_E115_therapeutic_home := NULL;
				vs_E116_shelter_care_home := NULL;
				vs_E117_relative_foster_family := NULL;
				vs_E118_pre_adopt_home := NULL;
				vs_E119_kin_foster_family := NULL;
				-- LA Details
				vs_E120_other_living_arrangement_type := NULL;
				vs_E121_location_of_living_arrangement := NULL;
				--
				vs_E122_jurisdiction_or_country := NULL;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := NULL;
				vs_E124_relationship_to_foster_parents := NULL;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := NULL;
				vs_E126_foster_parent1_tribal_membership := NULL;
				vs_E127_foster_parent1_race_american_indian_alaska_native := NULL;
				vs_E128_foster_parent1_race_asian := NULL;
				vs_E129_foster_parent1_race_black := NULL;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := NULL;
				vs_E131_foster_parent1_race_white := NULL;
				vs_E132_foster_parent1_race_unknown := NULL;
				vs_E133_foster_parent1_race_declined := NULL;
				vs_E134_foster_parent1_hispanic_latino := NULL;
				vs_E135_foster_parent1_sex := NULL;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := NULL;
				vs_E137_foster_parent2_tribal_membership := NULL;
				vs_E138_foster_parent2_race_american_indian_alaska_native := NULL;
				vs_E139_foster_parent2_race_asian := NULL;
				vs_E140_foster_parent2_race_black := NULL;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := NULL;
				vs_E142_foster_parent2_race_white := NULL;
				vs_E143_foster_parent2_race_unknown := NULL;
				vs_E144_foster_parent2_race_declined := NULL;
				vs_E145_foster_parent2_hispanic_latino := NULL;
				vs_E146_foster_parent2_sex := NULL;
				vu_placementid := NULL; 
				vd_pl_startdate := NULL; 
				vd_pl_enddate := NULL; 
				vl_altproviderid := NULL;
				vl_cpahome_altproviderid := NULL;
				vl_approval_person_id := NULL;
				vs_family_structure_cd := NULL;
				vs_marital_status_cd := NULL;
				vl_applicant_cjamspid := NULL;
				vl_coapplicant_cjamspid := NULL;
								
				vl_placement_sructure_id := NULL;

				vs_placement_type := cur_la_placement.placement_type;
				vs_E112_date_living_arrangement := cur_la_placement.E112_date_living_arrangement;
				vs_E113_foster_family_home := cur_la_placement.E113_foster_family_home; 
				vs_E114_licensed_home := cur_la_placement.E114_licensed_home;
				vs_E115_therapeutic_home := cur_la_placement.E115_therapeutic_home;
				vs_E116_shelter_care_home := cur_la_placement.E116_shelter_care_home;
				vs_E117_relative_foster_family := cur_la_placement.E117_relative_foster_family;
				vs_E118_pre_adopt_home := cur_la_placement.E118_pre_adopt_home;
				vs_E119_kin_foster_family := cur_la_placement.E119_kin_foster_family;
				-- LA Details
				vs_E120_other_living_arrangement_type := cur_la_placement.E120_other_living_arrangement_type;
				vs_E121_location_of_living_arrangement := cur_la_placement.E121_location_of_living_arrangement;
				--
				vs_E122_jurisdiction_or_country := cur_la_placement.E122_jurisdiction_or_country;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := cur_la_placement.E123_marital_status_of_foster_parents;
				vs_E124_relationship_to_foster_parents := cur_la_placement.E124_relationship_to_foster_parents;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := cur_la_placement.E125_foster_parent1_birth_year;
				vs_E126_foster_parent1_tribal_membership := cur_la_placement.E126_foster_parent1_tribal_membership;
				vs_E127_foster_parent1_race_american_indian_alaska_native := cur_la_placement.E127_foster_parent1_race_american_indian_alaska_native; 
				vs_E128_foster_parent1_race_asian := cur_la_placement.E128_foster_parent1_race_asian;
				vs_E129_foster_parent1_race_black := cur_la_placement.E129_foster_parent1_race_black;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := cur_la_placement.E130_foster_parent1_race_native_hawaiian_pacific_islander;
				vs_E131_foster_parent1_race_white:= cur_la_placement.E131_foster_parent1_race_white;
				vs_E132_foster_parent1_race_unknown := cur_la_placement.E132_foster_parent1_race_unknown;
				vs_E133_foster_parent1_race_declined := cur_la_placement.E133_foster_parent1_race_declined;
				vs_E134_foster_parent1_hispanic_latino := cur_la_placement.E134_foster_parent1_hispanic_latino;
				vs_E135_foster_parent1_sex := cur_la_placement.E135_foster_parent1_sex;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := cur_la_placement.E136_foster_parent2_birth_year;
				vs_E137_foster_parent2_tribal_membership := cur_la_placement.E137_foster_parent2_tribal_membership ;
				vs_E138_foster_parent2_race_american_indian_alaska_native := cur_la_placement.E138_foster_parent2_race_american_indian_alaska_native;
				vs_E139_foster_parent2_race_asian := cur_la_placement.E139_foster_parent2_race_asian;
				vs_E140_foster_parent2_race_black := cur_la_placement.E140_foster_parent2_race_black;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := cur_la_placement.E141_foster_parent2_race_native_hawaiian_pacific_islander;
				vs_E142_foster_parent2_race_white := cur_la_placement.E142_foster_parent2_race_white;
				vs_E143_foster_parent2_race_unknown := cur_la_placement.E143_foster_parent2_race_unknown;
				vs_E144_foster_parent2_race_declined := cur_la_placement.E144_foster_parent2_race_declined;
				vs_E145_foster_parent2_hispanic_latino := cur_la_placement.E145_foster_parent2_hispanic_latino;
				vs_E146_foster_parent2_sex := cur_la_placement.E146_foster_parent2_sex;
				vu_placementid := cur_la_placement.placementid;
				vd_pl_startdate := cur_la_placement.startdatetime;
				vd_pl_enddate := cur_la_placement.enddatetime;
				vl_altproviderid := cur_la_placement.altproviderid;
				
				vl_placement_sructure_id := cur_la_placement.service_id;
				
				-- Get all Provider Details 
				vl_address_id := NULL;
				
				select prd.address_id,
					( case when coalesce(prd.adr_format_cd, '') = 'F' 
							and coalesce(prd.adr_country_tx, 'US') not in ( 'US', 'USA', 'United States' ) then
							'3' --  Out-of-country
						  when coalesce(prd.adr_state_cd, 'MD') = 'MD' then
							'1' -- In-state or in-Tribal service area
						  when coalesce(prd.adr_state_cd, 'MD') <> 'MD' then	
							'2' -- Out-of-state or out-of-Tribal service area
						  when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' )
								and coalesce(prd.adr_state_cd, 'MD') = 'XX' then
							'1' -- In-state	
						  else
							'1' -- In-state
						end) as E121_location_of_living_arrangement,
						(case when coalesce(prd.adr_state_cd, 'MD') = 'MD'  then
							-- Null should be used if the agency indicated 
							-- If # 121 is '1' (in-state or in-Tribal service area) or '4' (runaway or whereabouts unknown) 
							NULL
						when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' ) then 
							-- coalesce(prd.adr_format_cd, '') <> 'F' -- then
							(case when coalesce(prd.adr_state_cd, 'MD') = 'AL' then '01' -- Alabama
								when coalesce(prd.adr_state_cd, 'MD') = 'AK' then '02' -- Alaska
								when coalesce(prd.adr_state_cd, 'MD') = 'AZ' then '04' -- Arizona	
								when coalesce(prd.adr_state_cd, 'MD') = 'AR' then '05' -- Arkansas	
								when coalesce(prd.adr_state_cd, 'MD') = 'CA' then '06' -- California	
								when coalesce(prd.adr_state_cd, 'MD') = 'CO' then '08' -- Colorado
								when coalesce(prd.adr_state_cd, 'MD') = 'CT' then '09' -- Connecticut	
								when coalesce(prd.adr_state_cd, 'MD') = 'DE'	then '10' -- Delaware	
								when coalesce(prd.adr_state_cd, 'MD') = 'DC' then '11' -- District of Columbia	
								when coalesce(prd.adr_state_cd, 'MD') = 'FL' then '12' -- Florida	
								when coalesce(prd.adr_state_cd, 'MD') = 'GA' then '13' -- Georgia	
								when coalesce(prd.adr_state_cd, 'MD') = 'HI' then '15' -- Hawaii	
								when coalesce(prd.adr_state_cd, 'MD') = 'ID' then '16' -- Idaho	
								when coalesce(prd.adr_state_cd, 'MD') = 'IL' then '17' -- Illinois	
								when coalesce(prd.adr_state_cd, 'MD') = 'IN' then '18' -- Indiana 	
								when coalesce(prd.adr_state_cd, 'MD') = 'IA' then '19' -- Iowa	
								when coalesce(prd.adr_state_cd, 'MD') = 'KS' then '20' -- Kansas	
								when coalesce(prd.adr_state_cd, 'MD') = 'KY' then '21' -- Kentucky	
								when coalesce(prd.adr_state_cd, 'MD') = 'LA' then '22' -- Louisiana	
								when coalesce(prd.adr_state_cd, 'MD') = 'ME' then '23' -- Maine	
								when coalesce(prd.adr_state_cd, 'MD') = 'MD' then Null -- '24' -- Maryland	
								when coalesce(prd.adr_state_cd, 'MD') = 'MA' then '25' -- Massachusetts	
								when coalesce(prd.adr_state_cd, 'MD') = 'MI' then '26' -- Michigan	
								when coalesce(prd.adr_state_cd, 'MD') = 'MN' then '27' -- Minnesota	
								when coalesce(prd.adr_state_cd, 'MD') = 'MS' then '28' -- Mississippi
								when coalesce(prd.adr_state_cd, 'MD') = 'MO' then '29' -- Missouri	
								when coalesce(prd.adr_state_cd, 'MD') = 'MT' then '30' -- Montana
								when coalesce(prd.adr_state_cd, 'MD') = 'NE' then '31' -- Nebraska
								when coalesce(prd.adr_state_cd, 'MD') = 'NV' then '32' -- Nevada
								when coalesce(prd.adr_state_cd, 'MD') = 'NH' then '33' -- New Hampshire
								when coalesce(prd.adr_state_cd, 'MD') = 'NJ' then '34' -- New Jersey
								when coalesce(prd.adr_state_cd, 'MD') = 'NM' then '35' -- New Mexico
								when coalesce(prd.adr_state_cd, 'MD') = 'NY' then '36' -- New York
								when coalesce(prd.adr_state_cd, 'MD') = 'NC' then '37' -- North Carolina
								when coalesce(prd.adr_state_cd, 'MD') = 'ND' then '38' -- North Dakota
								when coalesce(prd.adr_state_cd, 'MD') = 'OH' then '39' -- Ohio
								when coalesce(prd.adr_state_cd, 'MD') = 'OK' then '40' -- Oklahoma
								when coalesce(prd.adr_state_cd, 'MD') = 'OR' then '41' -- Oregon
								when coalesce(prd.adr_state_cd, 'MD') = 'PA' then '42' -- Pennsylvania
								when coalesce(prd.adr_state_cd, 'MD') = 'PR' then '72' -- Puerto Rico
								when coalesce(prd.adr_state_cd, 'MD') = 'RI' then '44' -- Rhode Island
								when coalesce(prd.adr_state_cd, 'MD') = 'SC' then '45' -- South Carolina
								when coalesce(prd.adr_state_cd, 'MD') = 'SD' then '46' -- South Dakota
								when coalesce(prd.adr_state_cd, 'MD') = 'TN' then '47' -- Tennessee
								when coalesce(prd.adr_state_cd, 'MD') = 'TX' then '48' -- Texas
								when coalesce(prd.adr_state_cd, 'MD') = 'UT' then '49' -- Utah
								when coalesce(prd.adr_state_cd, 'MD') = 'VT' then '50' -- Vermont
								when coalesce(prd.adr_state_cd, 'MD') = 'VA' then '51' -- Virginia
								when coalesce(prd.adr_state_cd, 'MD') = 'VI' then '78' -- Virgin Islands
								when coalesce(prd.adr_state_cd, 'MD') = 'WA' then '53' -- Washington
								when coalesce(prd.adr_state_cd, 'MD') = 'WV' then '54' -- West Virginia
								when coalesce(prd.adr_state_cd, 'MD') = 'WI' then '55' -- Wisconsin
								when coalesce(prd.adr_state_cd, 'MD') = 'WY' then '56' -- Wyoming
							else
									null
							end)
						when coalesce(prd.adr_format_cd, '') = 'F' then
							(select ref_key 
								from referencevalues
							 where referencetypeid = 310
								and lower(value_text) like '%' || lower(prd.adr_country_tx) || '%'  
								and activeflag = 1
								and coalesce(teamtypekey, 'CW') = 'CW'
							limit 1
							) -- Country: 3-digit ISO Alpha code ???
						end) as E122_jurisdiction_or_country
					into vl_address_id,
						vs_E121_location_of_living_arrangement,
						vs_E122_jurisdiction_or_country
				from prov.tb_provider_addresses prd
				where prd.parent_key_id = vl_altproviderid::character varying
					and btrim(prd.adr_type_cd) = '3357' -- Provider Location 
					and prd.delete_sw = 'N' 
					-- and prd.adr_default_sw = 'Y'
					and prd.adr_start_dt <= coalesce(vd_pl_enddate, vdt_to::date)
					and (prd.adr_end_dt is null or prd.adr_end_dt >= vd_pl_startdate )
				order by prd.adr_start_dt desc 
				limit 1 ;
				
				-- Report based on most recent provider address
				if vl_address_id is null then
					select ( case when coalesce(prd.adr_format_cd, '') = 'F' 
								and coalesce(prd.adr_country_tx, 'US') not in ( 'US', 'USA', 'United States' ) then
								'3' --  Out-of-country
							  when coalesce(prd.adr_state_cd, 'MD') = 'MD' then
								'1' -- In-state or in-Tribal service area
							  when coalesce(prd.adr_state_cd, 'MD') <> 'MD' then	
								'2' -- Out-of-state or out-of-Tribal service area
							  when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' )
									and coalesce(prd.adr_state_cd, 'MD') = 'XX' then
								'1' -- In-state	
							  else
								'1' -- In-state
							end) as E121_location_of_living_arrangement,
							(case when coalesce(prd.adr_state_cd, 'MD') = 'MD'  then
								-- Null should be used if the agency indicated 
								-- If # 121 is '1' (in-state or in-Tribal service area) or '4' (runaway or whereabouts unknown) 
								NULL
							when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' ) then 
								-- coalesce(prd.adr_format_cd, '') <> 'F' -- then
								(case when coalesce(prd.adr_state_cd, 'MD') = 'AL' then '01' -- Alabama
									when coalesce(prd.adr_state_cd, 'MD') = 'AK' then '02' -- Alaska
									when coalesce(prd.adr_state_cd, 'MD') = 'AZ' then '04' -- Arizona	
									when coalesce(prd.adr_state_cd, 'MD') = 'AR' then '05' -- Arkansas	
									when coalesce(prd.adr_state_cd, 'MD') = 'CA' then '06' -- California	
									when coalesce(prd.adr_state_cd, 'MD') = 'CO' then '08' -- Colorado
									when coalesce(prd.adr_state_cd, 'MD') = 'CT' then '09' -- Connecticut	
									when coalesce(prd.adr_state_cd, 'MD') = 'DE'	then '10' -- Delaware	
									when coalesce(prd.adr_state_cd, 'MD') = 'DC' then '11' -- District of Columbia	
									when coalesce(prd.adr_state_cd, 'MD') = 'FL' then '12' -- Florida	
									when coalesce(prd.adr_state_cd, 'MD') = 'GA' then '13' -- Georgia	
									when coalesce(prd.adr_state_cd, 'MD') = 'HI' then '15' -- Hawaii	
									when coalesce(prd.adr_state_cd, 'MD') = 'ID' then '16' -- Idaho	
									when coalesce(prd.adr_state_cd, 'MD') = 'IL' then '17' -- Illinois	
									when coalesce(prd.adr_state_cd, 'MD') = 'IN' then '18' -- Indiana 	
									when coalesce(prd.adr_state_cd, 'MD') = 'IA' then '19' -- Iowa	
									when coalesce(prd.adr_state_cd, 'MD') = 'KS' then '20' -- Kansas	
									when coalesce(prd.adr_state_cd, 'MD') = 'KY' then '21' -- Kentucky	
									when coalesce(prd.adr_state_cd, 'MD') = 'LA' then '22' -- Louisiana	
									when coalesce(prd.adr_state_cd, 'MD') = 'ME' then '23' -- Maine	
									when coalesce(prd.adr_state_cd, 'MD') = 'MD' then Null -- '24' -- Maryland	
									when coalesce(prd.adr_state_cd, 'MD') = 'MA' then '25' -- Massachusetts	
									when coalesce(prd.adr_state_cd, 'MD') = 'MI' then '26' -- Michigan	
									when coalesce(prd.adr_state_cd, 'MD') = 'MN' then '27' -- Minnesota	
									when coalesce(prd.adr_state_cd, 'MD') = 'MS' then '28' -- Mississippi
									when coalesce(prd.adr_state_cd, 'MD') = 'MO' then '29' -- Missouri	
									when coalesce(prd.adr_state_cd, 'MD') = 'MT' then '30' -- Montana
									when coalesce(prd.adr_state_cd, 'MD') = 'NE' then '31' -- Nebraska
									when coalesce(prd.adr_state_cd, 'MD') = 'NV' then '32' -- Nevada
									when coalesce(prd.adr_state_cd, 'MD') = 'NH' then '33' -- New Hampshire
									when coalesce(prd.adr_state_cd, 'MD') = 'NJ' then '34' -- New Jersey
									when coalesce(prd.adr_state_cd, 'MD') = 'NM' then '35' -- New Mexico
									when coalesce(prd.adr_state_cd, 'MD') = 'NY' then '36' -- New York
									when coalesce(prd.adr_state_cd, 'MD') = 'NC' then '37' -- North Carolina
									when coalesce(prd.adr_state_cd, 'MD') = 'ND' then '38' -- North Dakota
									when coalesce(prd.adr_state_cd, 'MD') = 'OH' then '39' -- Ohio
									when coalesce(prd.adr_state_cd, 'MD') = 'OK' then '40' -- Oklahoma
									when coalesce(prd.adr_state_cd, 'MD') = 'OR' then '41' -- Oregon
									when coalesce(prd.adr_state_cd, 'MD') = 'PA' then '42' -- Pennsylvania
									when coalesce(prd.adr_state_cd, 'MD') = 'PR' then '72' -- Puerto Rico
									when coalesce(prd.adr_state_cd, 'MD') = 'RI' then '44' -- Rhode Island
									when coalesce(prd.adr_state_cd, 'MD') = 'SC' then '45' -- South Carolina
									when coalesce(prd.adr_state_cd, 'MD') = 'SD' then '46' -- South Dakota
									when coalesce(prd.adr_state_cd, 'MD') = 'TN' then '47' -- Tennessee
									when coalesce(prd.adr_state_cd, 'MD') = 'TX' then '48' -- Texas
									when coalesce(prd.adr_state_cd, 'MD') = 'UT' then '49' -- Utah
									when coalesce(prd.adr_state_cd, 'MD') = 'VT' then '50' -- Vermont
									when coalesce(prd.adr_state_cd, 'MD') = 'VA' then '51' -- Virginia
									when coalesce(prd.adr_state_cd, 'MD') = 'VI' then '78' -- Virgin Islands
									when coalesce(prd.adr_state_cd, 'MD') = 'WA' then '53' -- Washington
									when coalesce(prd.adr_state_cd, 'MD') = 'WV' then '54' -- West Virginia
									when coalesce(prd.adr_state_cd, 'MD') = 'WI' then '55' -- Wisconsin
									when coalesce(prd.adr_state_cd, 'MD') = 'WY' then '56' -- Wyoming
								else
										null
								end)
							when coalesce(prd.adr_format_cd, '') = 'F' then
								(select ref_key 
									from referencevalues
								 where referencetypeid = 310
									and lower(value_text) like '%' || lower(prd.adr_country_tx) || '%'  
									and activeflag = 1
									and coalesce(teamtypekey, 'CW') = 'CW'
								limit 1
								) -- Country: 3-digit ISO Alpha code ???
							end) as E122_jurisdiction_or_country
						into vs_E121_location_of_living_arrangement,
							vs_E122_jurisdiction_or_country
					from prov.tb_provider_addresses prd
					where prd.parent_key_id = vl_altproviderid::character varying
						and btrim(prd.adr_type_cd) = '3357' -- Provider Location 
						and prd.delete_sw = 'N' 
						-- and prd.adr_default_sw = 'Y'
						-- and prd.adr_start_dt <= coalesce(vd_pl_enddate, vdt_to::date)
						-- and (prd.adr_end_dt is null or prd.adr_end_dt >= vd_pl_startdate )
					order by prd.adr_start_dt desc 
					limit 1 ;
				end if;
					
				-- Get Provider Applicant Details
				select pr.maritalstatustypekey, 
					pr.cjamspid,
					date_part('year', pr.dob)::varchar as dob_year,
					(case when upper(pr.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					when upper(pr.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					else
						'9' -- Unknown
					end) as tribal_membership, -- Unkown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(pr.ethnicgrouptypekey) = 'H' then -- Hispanic or Latino
						'1' 
					 when btrim(pr.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(pr.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(pr.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(pr.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
				 	 when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 	
					 else
						NULL
					end) as gender
				into vs_family_structure_cd,
					vl_applicant_cjamspid,
					vs_E125_foster_parent1_birth_year, 
					vs_E126_foster_parent1_tribal_membership,
					vs_E127_foster_parent1_race_american_indian_alaska_native, 
					vs_E128_foster_parent1_race_asian, 
					vs_E129_foster_parent1_race_black, 
					vs_E130_foster_parent1_race_native_hawaiian_pacific_islander, 
					vs_E131_foster_parent1_race_white, 
					vs_E132_foster_parent1_race_unknown, 
					vs_E133_foster_parent1_race_declined, 
					vs_E134_foster_parent1_hispanic_latino, 
					vs_E135_foster_parent1_sex 
				from intakeservicerequestactor isr,
					person pr
				where isr.personid = pr.personid
					and isr.objectid = vl_altproviderid::character varying
					and isr.intakeservicerequestpersontypekey = 'APLCNT' -- Applicant
					and isr.activeflag = 1 ;
					
				if vl_applicant_cjamspid is null then 
					-- Get from Provider approval person data 
					select pap.approval_person_id,
						pap.marital_status_cd,
						pap.family_structure_cd, 
						date_part('year', pap.dob_dt::date)::varchar as dob_year,
						(case when btrim(pap.primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
							'1'
						else
							'0'
						end) as	E127_foster_parent1_race_american_indian_alaska_native,
						(case when btrim(pap.primary_race_cd) in ('6310', '6346' ) then -- Asian
							'1'
						else
							'0'
						end) as	E128_foster_parent1_race_asian,
						(case when btrim(pap.primary_race_cd) = '1801' then -- Black/African-American
							'1'
						else
							'0'
						end) as	E129_foster_parent1_race_black,
						(case when btrim(pap.primary_race_cd) in ('6311', '6347', '1804') then 
							-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
							'1'
						else
							'0'
						end) as	E130_foster_parent1_race_native_hawaiian_pacific_islander,
						(case when btrim(pap.primary_race_cd) = '1806' then -- White/Caucasian 
							'1'
						else
							'0'
						end) as	E131_foster_parent1_race_white, 
						(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
							'1'
						else
							'0'
						end) as	E132_foster_parent1_race_unknown, 
						(case when btrim(primary_race_cd) = '6314' then -- Declined
							'1'
						else
							'0'
						end) as	E133_foster_parent1_race_declined, 
						(case when pap.hispanic_cd = 'Y' then 
							'1'  -- Yes
						when hispanic_cd = 'N' then 
							'0' -- No
						when hispanic_cd = 'U' then 
							'9' -- Unknown
						else 
							NULL
						end) as hispanic_cd,
						(case when btrim(pap.gender_cd) = '1282' then -- Male
							'1'
						 when btrim(pap.gender_cd) = '1281' then -- Female
							'2'
						 else
							Null
						end) gender_cd
					into vl_approval_person_id,
						vs_family_structure_cd,
						vs_marital_status_cd,
						vs_E125_foster_parent1_birth_year, 
						vs_E134_foster_parent1_hispanic_latino,
						vs_E127_foster_parent1_race_american_indian_alaska_native, 
						vs_E128_foster_parent1_race_asian, 
						vs_E129_foster_parent1_race_black, 
						vs_E130_foster_parent1_race_native_hawaiian_pacific_islander, 
						vs_E131_foster_parent1_race_white, 
						vs_E132_foster_parent1_race_unknown, 
						vs_E133_foster_parent1_race_declined, 						
						vs_E135_foster_parent1_sex	
					from tb_provider_approval pra,
						tb_prov_approval_person pap
					where pra.provider_approval_id = pap.provider_approval_id
						and pra.provider_id = vl_altproviderid
						and btrim(pap.person_type_cd) in ('3610') -- Applicant
						and pra.delete_sw = 'N'
						and pap.delete_sw = 'N'
						and pra.approval_dt::date <= coalesce(vd_pl_enddate, vdt_to::date)
					order by  pra.provider_approval_id desc 
					limit 1;
					
				end if;
						
				If vs_marital_status_cd is not null then 
					select (case when btrim(vs_marital_status_cd) in ('MR', '290', '1569') then 
								'1' -- Married Couple
							when btrim(vs_marital_status_cd) in ('294', '296', '298', '299', '1572') then 
								'2' -- Unmarried Couple
							when btrim(vs_marital_status_cd) in ('288', '289', '291', '292', 'DV', 'LS', '1570') then 
								'3' -- Separated
							when btrim(vs_marital_status_cd) in ('293', '295', '297', 'SG', 'WD', 'UK', '1568', '1571', '3673', '3674' ) then
								'4' -- Single adult 
							end )
					into vs_E123_marital_status_of_foster_parents ;		
				end if;		
					
				if vs_E123_marital_status_of_foster_parents is null
					or btrim(vs_E123_marital_status_of_foster_parents) = '' then 	
					select (case when vs_family_structure_cd in ('MR', '290') then -- 	Married Couple
								'1' -- Married couple
							when vs_family_structure_cd in ('294', '296', '298', '299') then
								'2' -- Unmarried couple
							when vs_family_structure_cd in ('288', '289', '291', '292', 'DV', 'LS') then 	
								'3' -- Separated
							when vs_family_structure_cd in ('293', '295', '297', 'SG', 'WD', 'UK') then	
								'4' -- Single adult 
							else
								'4' -- For Compliance Single adult 
							end )
					into vs_E123_marital_status_of_foster_parents ;
				end if;

				if vs_E123_marital_status_of_foster_parents is null
					or btrim(vs_E123_marital_status_of_foster_parents) = '' then
					vs_E123_marital_status_of_foster_parents := '4'; -- For Compliance Single adult 
				end if;				
					
				-- Get Provider Co-Applicant Details
				select pr.cjamspid,
					date_part('year', pr.dob)::varchar as dob_year,
					(case when upper(pr.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					when upper(pr.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					else
						'9' -- Unknown
					end) as tribal_membership, 
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = pr.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(pr.ethnicgrouptypekey) = 'H' then -- Hispanic or Latino
						'1' 
					 when btrim(pr.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(pr.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(pr.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(pr.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					 when btrim(pr.gendertypekey) = 'O' and pr.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 
					 else
						NULL
					end) as gender
				into vl_coapplicant_cjamspid,
					vs_E136_foster_parent2_birth_year,
					vs_E137_foster_parent2_tribal_membership,
					vs_E138_foster_parent2_race_american_indian_alaska_native,
					vs_E139_foster_parent2_race_asian,
					vs_E140_foster_parent2_race_black,
					vs_E141_foster_parent2_race_native_hawaiian_pacific_islander,
					vs_E142_foster_parent2_race_white,
					vs_E143_foster_parent2_race_unknown,
					vs_E144_foster_parent2_race_declined,
					vs_E145_foster_parent2_hispanic_latino,
					vs_E146_foster_parent2_sex
				from intakeservicerequestactor isr,
					person pr
				where isr.personid = pr.personid
					and isr.objectid = vl_altproviderid::character varying
					and isr.intakeservicerequestpersontypekey = 'COAPLCNT' -- Co-Applicant
					and isr.activeflag = 1 ;

				if vl_coapplicant_cjamspid is null then 
					-- Get from Provider approval person data 
					select pap.approval_person_id,
						pap.marital_status_cd,
						pap.family_structure_cd, 
						date_part('year', pap.dob_dt::date)::varchar as dob_year,
						(case when btrim(pap.primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
							'1'
						else
							'0'
						end) as	E138_foster_parent2_race_american_indian_alaska_native,
						(case when btrim(pap.primary_race_cd) in ('6310', '6346' ) then -- Asian
							'1'
						else
							'0'
						end) as	E139_foster_parent2_race_asian,
						(case when btrim(pap.primary_race_cd) = '1801' then -- Black/African-American
							'1'
						else
							'0'
						end) as	E140_foster_parent2_race_black,
						(case when btrim(pap.primary_race_cd) in ('6311', '6347', '1804') then 
							-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
							'1'
						else
							'0'
						end) as	E141_foster_parent2_race_native_hawaiian_pacific_islander,
						(case when btrim(pap.primary_race_cd) = '1806' then -- White/Caucasian 
							'1'
						else
							'0'
						end) as	E142_foster_parent2_race_white, 
						(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
							'1'
						else
							'0'
						end) as	E143_foster_parent2_race_unknown, 
						(case when btrim(primary_race_cd) = '6314' then -- Declined
							'1'
						else
							'0'
						end) as	E144_foster_parent2_race_declined, 
						(case when pap.hispanic_cd = 'Y' then 
							'1'  -- Yes
						when hispanic_cd = 'N' then 
							'0' -- No
						when hispanic_cd = 'U' then 
							'9' -- Unknown
						else 
							NULL
						end) as hispanic_cd, 
						(case when btrim(pap.gender_cd) = '1282' then -- Male
							'1'
						 when btrim(pap.gender_cd) = '1281' then -- Female
							'2'
						 else
							Null
						end) gender_cd
					into vl_approval_person_id,
						vs_marital_status_cd,
						vs_family_structure_cd,
						vs_E136_foster_parent2_birth_year,
						-- vs_E137_foster_parent2_tribal_membership,
						vs_E138_foster_parent2_race_american_indian_alaska_native,
						vs_E139_foster_parent2_race_asian,
						vs_E140_foster_parent2_race_black,
						vs_E141_foster_parent2_race_native_hawaiian_pacific_islander,
						vs_E142_foster_parent2_race_white,
						vs_E143_foster_parent2_race_unknown,
						vs_E144_foster_parent2_race_declined,
						vs_E145_foster_parent2_hispanic_latino,
						vs_E146_foster_parent2_sex							
					from tb_provider_approval pra,
						tb_prov_approval_person pap
					where pra.provider_approval_id = pap.provider_approval_id
						and pra.provider_id = vl_altproviderid
						and btrim(pap.person_type_cd) in ('3611') -- Co-Applicant
						and pra.delete_sw = 'N'
						and pap.delete_sw = 'N'
						and pra.approval_dt::date <= coalesce(vd_pl_enddate, vdt_to::date)
					order by  pra.provider_approval_id desc 
					limit 1;
				end if;
				
				-- CIDM-11353 04/21/2026
				if vl_coapplicant_cjamspid is null -- and vl_approval_person_id is null 
					then 
					vs_e123_marital_status_of_foster_parents := '4' ; -- For Compliance Single adult 
				end if;
					

				INSERT INTO cjams.afcars_fc_placements
					(	afcarsfostercareid, 
						recordno, 
						removalid, 
						e112_date_living_arrangement, 
						e113_foster_family_home, 
						e114_licensed_home, 
						e115_therapeutic_home, 
						e116_shelter_care_home, 
						e117_relative_foster_family, 
						e118_pre_adopt_home, 
						e119_kin_foster_family, 
						e120_other_living_arrangement_type, 
						e121_location_of_living_arrangement, 
						e122_jurisdiction_or_country, 
						e123_marital_status_of_foster_parents, 
						e124_relationship_to_foster_parents, 
						e125_foster_parent1_birth_year, 
						e126_foster_parent1_tribal_membership, 
						e127_foster_parent1_race_american_indian_alaska_native, 
						e128_foster_parent1_race_asian, 
						e129_foster_parent1_race_black, 
						e130_foster_parent1_race_native_hawaiian_pacific_islander, 
						e131_foster_parent1_race_white, 
						e132_foster_parent1_race_unknown, 
						e133_foster_parent1_race_declined, 
						e134_foster_parent1_hispanic_latino, 
						e135_foster_parent1_sex, 
						e136_foster_parent2_birth_year, 
						e137_foster_parent2_tribal_membership, 
						e138_foster_parent2_race_american_indian_alaska_native, 
						e139_foster_parent2_race_asian, 
						e140_foster_parent2_race_black, 
						e141_foster_parent2_race_native_hawaiian_pacific_islander, 
						e142_foster_parent2_race_white, 
						e143_foster_parent2_race_unknown, 
						e144_foster_parent2_race_declined, 
						e145_foster_parent2_hispanic_latino, 
						e146_foster_parent2_sex, 
						placementid, 
						cjamspid, 
						caseid,
						placementtype,
						start_date,
						placementsubtype,
						original_removalid
						)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_removalid, 
						vs_e112_date_living_arrangement, 
						vs_e113_foster_family_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e114_licensed_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e115_therapeutic_home, '0') -- Does not apply
						else
							NULL
						end),
												
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e116_shelter_care_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e117_relative_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
						
						vs_e118_pre_adopt_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e119_kin_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
												
						(case when vs_e113_foster_family_home = '0' then -- No
							vs_e120_other_living_arrangement_type
						else	
							NULL  -- For Compliance
						end),
						
						vs_e121_location_of_living_arrangement, 
						
						(case when vs_e121_location_of_living_arrangement = '1'	
							or vs_e121_location_of_living_arrangement = '4' then
							NULL -- For Compliance
						else	
							vs_e122_jurisdiction_or_country
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e123_marital_status_of_foster_parents
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e124_relationship_to_foster_parents
						end), 
						-- vs_e124_relationship_to_foster_parents,

						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e125_foster_parent1_birth_year
						end),
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						else	
							-- '9' --  Unknown
							coalesce(vs_E126_foster_parent1_tribal_membership, '9')
						end),
						-- vs_e126_foster_parent1_tribal_membership, -- e126 ??
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') -- No
						else
							vs_e127_foster_parent1_race_american_indian_alaska_native						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e128_foster_parent1_race_asian, '0') -- No
						else
							vs_e128_foster_parent1_race_asian						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e129_foster_parent1_race_black, '0') -- No
						else
							vs_e129_foster_parent1_race_black						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') -- No
						else
							vs_e130_foster_parent1_race_native_hawaiian_pacific_islander						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e131_foster_parent1_race_white, '0') -- No
						else
							vs_e131_foster_parent1_race_white						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e132_foster_parent1_race_unknown, '0') -- No
						else
							vs_e132_foster_parent1_race_unknown						
						end), 
						
						-- 03/28
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							(case when vs_e133_foster_parent1_race_declined = '1' then -- Yes
								vs_e133_foster_parent1_race_declined
							else 
								(case when coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') = '0'
									and coalesce(vs_e128_foster_parent1_race_asian, '0') = '0'
									and coalesce(vs_e129_foster_parent1_race_black, '0') = '0'
									and coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') = '0'
									and coalesce(vs_e131_foster_parent1_race_white, '0') = '0'
									and coalesce(vs_e132_foster_parent1_race_unknown, '0') = '0' then
								'1' -- For Test Compliance
								else
									vs_e133_foster_parent1_race_declined
								end)
							end)	
						else
							vs_e133_foster_parent1_race_declined
						end), 
						
						/*
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e133_foster_parent1_race_declined, '0') -- No
						else
							vs_e133_foster_parent1_race_declined						
						end), 
						*/
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e134_foster_parent1_hispanic_latino, '9') -- Unknown
						else
							vs_e134_foster_parent1_hispanic_latino						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e135_foster_parent1_sex
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e136_foster_parent2_birth_year
							end)
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								-- '9'-- vs_e137_foster_parent2_tribal_membership, -- e137 ?? --  Unknown
								coalesce(vs_e137_foster_parent2_tribal_membership, '9')
							end)
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e138_foster_parent2_race_american_indian_alaska_native
							end)
						end),
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e139_foster_parent2_race_asian
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e140_foster_parent2_race_black
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e141_foster_parent2_race_native_hawaiian_pacific_islander
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e142_foster_parent2_race_white
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e143_foster_parent2_race_unknown
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								-- 03/28
								(case when vs_e144_foster_parent2_race_declined = '1' then -- Yes
									vs_e144_foster_parent2_race_declined
								else 
									(case when coalesce(vs_e138_foster_parent2_race_american_indian_alaska_native, '0') = '0'
										and coalesce(vs_e139_foster_parent2_race_asian, '0') = '0'
										and coalesce(vs_e140_foster_parent2_race_black, '0') = '0'
										and coalesce(vs_e141_foster_parent2_race_native_hawaiian_pacific_islander, '0') = '0'
										and coalesce(vs_e142_foster_parent2_race_white, '0') = '0'
										and coalesce(vs_e143_foster_parent2_race_unknown, '0') = '0' then
										'1' -- For Test Compliance
									else
										vs_e144_foster_parent2_race_declined
									end) 	
								end)
							end)
						end), 
						
						/*
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							vs_e144_foster_parent2_race_declined	
						end), 
						*/
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e145_foster_parent2_hispanic_latino	
							end)
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e146_foster_parent2_sex
							end)
						end),
						
						vu_placementid, 
						vs_client_id, 
						vs_caseid,
						vs_placement_type,
						vd_pl_startdate,
						vl_placement_sructure_id::character varying,
						vs_removalid
					);
			END LOOP;	
			close cur_la_placement_REFCURSOR;	

			-- Capture Provider Placement Details (with NO CPA Homes) - END

			-- Capture Provider Placement Details (with CPA Homes) - START 

			OPEN cur_la_placement_REFCURSOR FOR
				select 'PRPL' as placement_type,
					pl.startdatetime as E112_date_living_arrangement, 
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
						'1'	-- Yes
					else
						'0' -- No 
					end ) as E113_foster_family_home, 		
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
						'1'	-- Applies
					else
						'0' -- Does not apply
					end) as E114_licensed_home, 
					
					-- (case when pl.service_id = 167 then --	Therapeutic Group Homes
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship
						) then
							(case when pl.service_id in 
								(-- 76 -- Residential Treatment Centers
								11405 -- Treatment Foster Care Level 1
								,11406 -- Treatment Foster Care Level 2
								,11407 -- Treatment Foster Care Level 3
								,11408 -- Treatment Foster Care Level 4
								,78	-- Treatment Foster Care (Private)
								,12	-- Treatment Foster Care (Public)
								) then
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) E115_therapeutic_home,
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
							(case when pl.service_id = 13 then -- Emergency Foster Home Care
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E116_shelter_care_home,
					
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship 
						) then
							(case when pl.service_id in 
									(9 -- Restricted (Relative) Foster Care
									,8 -- Formal Kinship Care 
									,531 -- Non-paid Kinship
									,530 -- Kinship 
									) then 
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E117_relative_foster_family,
					
					
					(case when pl.service_id in 
						(525 -- CfE Resource Home
						,13 -- Emergency Foster Home Care
						,8 -- Formal Kinship Care
						,11 -- Intermediate Foster Care
						,11409 -- Intermediate Foster Care Difficulty of Care
						,500	-- Pre-Finalized Adoptive Home
						,10 -- Regular Foster Care
						-- ,76 -- Residential Treatment Centers
						,9 -- Restricted (Relative) Foster Care
						,11405 -- Treatment Foster Care Level 1
						,11406 -- Treatment Foster Care Level 2
						,11407 -- Treatment Foster Care Level 3
						,11408 -- Treatment Foster Care Level 4
						,78	-- Treatment Foster Care (Private)
						,12	-- Treatment Foster Care (Public)
						,531 -- Non-paid Kinship
						,530 -- Kinship
						) then
							(case when pl.service_id = 500 then -- Pre-Finalized Adoptive Home
								'1'	-- Applies
							else
								'0' -- Does not apply
							end)
					else
						NULL -- Not Applicable
					end ) as E118_pre_adopt_home, 
					
					(case when pl.service_id in 
							(525 -- CfE Resource Home
							,13 -- Emergency Foster Home Care
							,8 -- Formal Kinship Care
							,11 -- Intermediate Foster Care
							,11409 -- Intermediate Foster Care Difficulty of Care
							,500	-- Pre-Finalized Adoptive Home
							,10 -- Regular Foster Care
							-- ,76 -- Residential Treatment Centers
							,9 -- Restricted (Relative) Foster Care
							,11405 -- Treatment Foster Care Level 1
							,11406 -- Treatment Foster Care Level 2
							,11407 -- Treatment Foster Care Level 3
							,11408 -- Treatment Foster Care Level 4
							,78	-- Treatment Foster Care (Private)
							,12	-- Treatment Foster Care (Public)
							,531 -- Non-paid Kinship
							,530 -- Kinship 
							) then
						'0' -- Does not apply
					else
						NULL -- Not Applicable
					end ) as E119_kin_foster_family, -- Does not apply
					
					(case when pl.service_id = 14 then -- Residential Group Homes	
						'2' -- Group home–staff operated
					when pl.service_id = 15	then -- Emergency Group Shelter Care
						'3' -- Group home–shelter care
					when pl.service_id = 167 then -- Therapeutic Group Homes	
						'4' -- Residential Treatment Center
					when pl.service_id = 73 then -- After care room and board
						'14' -- Placed at Home
					when pl.service_id = 76 then -- Residential Treatment Centers
						'4' -- Residential Treatment Center
					when pl.service_id in 
						(74	-- Alternative Living Units
						,1 -- Independent Living Residential Program
						,75 -- Teen Mother Programs
						) then 
						'8' -- Supervised Independent Living
					-- CIDM-10839		
					when pl.service_id = 11410 then -- Qualified Residential Treatment Program	
						'5' 		
					else
						'0' -- Does not apply
					end)as E120_other_living_arrangement_type,
					
					
					-- Get based on the provider ID in a loop
					Null as E121_location_of_living_arrangement,
					Null as E122_jurisdiction_or_country, 
					Null as E123_marital_status_of_foster_parents, 
					
					
					(case when lower(btrim(pl.primaryrelationship)) = lower('Relative') then
						'1' -- Relative
					when lower(btrim(pl.primaryrelationship)) = lower('Kin') then	
						'3' -- Kin
					when lower(btrim(pl.primaryrelationship)) in ( lower('Non-Relative'),lower('Foster-Parent')) then
						'2' -- Non-relative 
					when pl.service_id in ( 9 -- Restricted (Relative) Foster Care
											,8 -- Formal Kinship Care 
											,531 -- Non-paid Kinship
											,530 -- Kinship 
									) then 
						'3' -- Kin
					else
						'2' -- Non-relative 
					end) as E124_relationship_to_foster_parents, 
					
					Null as E125_foster_parent1_birth_year, 
					'9' as E126_foster_parent1_tribal_membership, -- Unknown
					Null as E127_foster_parent1_race_american_indian_alaska_native, 
					Null as E128_foster_parent1_race_asian, 
					Null as E129_foster_parent1_race_black, 
					Null as E130_foster_parent1_race_native_hawaiian_pacific_islander, 
					Null as E131_foster_parent1_race_white, 
					Null as E132_foster_parent1_race_unknown, 
					Null as E133_foster_parent1_race_declined, 
					Null as E134_foster_parent1_hispanic_latino, 
					Null as E135_foster_parent1_sex, 
					Null as E136_foster_parent2_birth_year, 
					Null as E137_foster_parent2_tribal_membership, 
					Null as E138_foster_parent2_race_american_indian_alaska_native, 
					Null as E139_foster_parent2_race_asian, 
					Null as E140_foster_parent2_race_black, 
					Null as E141_foster_parent2_race_native_hawaiian_pacific_islander, 
					Null as E142_foster_parent2_race_white, 
					Null as E143_foster_parent2_race_unknown, 
					Null as E144_foster_parent2_race_declined, 
					Null as E145_foster_parent2_hispanic_latino, 
					Null as E146_foster_parent2_sex,
					pl.placementid,
					pl.startdatetime::DATE, 
					pl.enddatetime::DATE,
					pl.altproviderid,
					pl.service_id
				from placement pl -- ,
					-- livingarrangement la 
				where -- la.placementid = pl.placementid
					-- and pl.placementid = la.placementid
					pl.personid = coalesce(vu_bio_personid, vu_personid) -- 04/29/2025
					and pl.intakeservreqchildremovalid = vu_intakeservreqchildremovalid
					and pl.activeflag = 1
					-- and la.activeflag = 1
					and pl.altproviderid is not null
					and COALESCE(pl.isvoided, 0) <> 1
					and ( SELECT count(*) AS count
							   FROM routing
						  WHERE routing.routingstatustypeid = 16 
							AND routing.eventcode::text = 'PLTR'::text 
							AND routing.activeflag = 1 
							AND routing.objectid::text = pl.placementid::character varying::text
						 ) > 0 
					and pl.service_id not in (503, 501)	 
					-- and pl.startdatetime::DATE between vd_removaldate::date and coalesce(vd_exitdate, current_date)::date
					-- 03/04
					-- and pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
					and ( pl.startdatetime between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
						  or
						  ( pl.startdatetime <= coalesce(vd_exitdate, vdt_to::date)
							and
							( case when pl.enddatetime is not null then 
								pl.enddatetime > vd_removaldate
							  else
								True
							end)
						  )	
						)  
					and ( case when pl.enddatetime is not null then   
							pl.startdatetime::date <> pl.enddatetime::date
						  else
							true
						 end) 
					 -- NO CPA homes
					and (select count(*) 
							from placementcpahomes cpa 
						where cpa.placementid = pl.placementid 
							and cpa.activeflag = 1
							and cpa.altproviderid is not null
							and cpa.entrydt is not null
							and cpa.entrydt between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
							and ( case when cpa.exitdt is not null then   
									cpa.entrydt::date <> cpa.exitdt::date
								  else
									true
								 end) 
						) > 0
				order by 1;
			LOOP
				fetch cur_la_placement_REFCURSOR into cur_la_placement;
				exit when not found;

				-- Reset
				vs_placement_type := NULL;
				vs_E112_date_living_arrangement := NULL;
				vs_E113_foster_family_home := NULL; 
				vs_E114_licensed_home := NULL;
				vs_E115_therapeutic_home := NULL;
				vs_E116_shelter_care_home := NULL;
				vs_E117_relative_foster_family := NULL;
				vs_E118_pre_adopt_home := NULL;
				vs_E119_kin_foster_family := NULL;
				-- LA Details
				vs_E120_other_living_arrangement_type := NULL;
				vs_E121_location_of_living_arrangement := NULL;
				--
				vs_E122_jurisdiction_or_country := NULL;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := NULL;
				vs_E124_relationship_to_foster_parents := NULL;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := NULL;
				vs_E126_foster_parent1_tribal_membership := NULL;
				vs_E127_foster_parent1_race_american_indian_alaska_native := NULL;
				vs_E128_foster_parent1_race_asian := NULL;
				vs_E129_foster_parent1_race_black := NULL;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := NULL;
				vs_E131_foster_parent1_race_white := NULL;
				vs_E132_foster_parent1_race_unknown := NULL;
				vs_E133_foster_parent1_race_declined := NULL;
				vs_E134_foster_parent1_hispanic_latino := NULL;
				vs_E135_foster_parent1_sex := NULL;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := NULL;
				vs_E137_foster_parent2_tribal_membership := NULL;
				vs_E138_foster_parent2_race_american_indian_alaska_native := NULL;
				vs_E139_foster_parent2_race_asian := NULL;
				vs_E140_foster_parent2_race_black := NULL;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := NULL;
				vs_E142_foster_parent2_race_white := NULL;
				vs_E143_foster_parent2_race_unknown := NULL;
				vs_E144_foster_parent2_race_declined := NULL;
				vs_E145_foster_parent2_hispanic_latino := NULL;
				vs_E146_foster_parent2_sex := NULL;
				vu_placementid := NULL; 
				vd_pl_startdate := NULL; 
				vd_pl_enddate := NULL; 
				vl_altproviderid := NULL;
				vl_cpahome_altproviderid := NULL;
				vl_approval_person_id := NULL;
				vs_family_structure_cd := NULL;
				vl_applicant_cjamspid := NULL;
				vl_coapplicant_cjamspid := NULL;
				vl_placement_sructure_id := NULL;
				vl_provider_cpa_adop_person_id := null;
				

				vs_placement_type := cur_la_placement.placement_type;
				vs_E112_date_living_arrangement := cur_la_placement.E112_date_living_arrangement;
				vs_E113_foster_family_home := cur_la_placement.E113_foster_family_home; 
				vs_E114_licensed_home := cur_la_placement.E114_licensed_home;
				vs_E115_therapeutic_home := cur_la_placement.E115_therapeutic_home;
				vs_E116_shelter_care_home := cur_la_placement.E116_shelter_care_home;
				vs_E117_relative_foster_family := cur_la_placement.E117_relative_foster_family;
				vs_E118_pre_adopt_home := cur_la_placement.E118_pre_adopt_home;
				vs_E119_kin_foster_family := cur_la_placement.E119_kin_foster_family;
				-- LA Details
				vs_E120_other_living_arrangement_type := cur_la_placement.E120_other_living_arrangement_type;
				vs_E121_location_of_living_arrangement := cur_la_placement.E121_location_of_living_arrangement;
				--
				vs_E122_jurisdiction_or_country := cur_la_placement.E122_jurisdiction_or_country;
				-- FC Parents 
				vs_E123_marital_status_of_foster_parents := cur_la_placement.E123_marital_status_of_foster_parents;
				vs_E124_relationship_to_foster_parents := cur_la_placement.E124_relationship_to_foster_parents;
				-- FC Parent 1
				vs_E125_foster_parent1_birth_year := cur_la_placement.E125_foster_parent1_birth_year;
				vs_E126_foster_parent1_tribal_membership := cur_la_placement.E126_foster_parent1_tribal_membership;
				vs_E127_foster_parent1_race_american_indian_alaska_native := cur_la_placement.E127_foster_parent1_race_american_indian_alaska_native; 
				vs_E128_foster_parent1_race_asian := cur_la_placement.E128_foster_parent1_race_asian;
				vs_E129_foster_parent1_race_black := cur_la_placement.E129_foster_parent1_race_black;
				vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := cur_la_placement.E130_foster_parent1_race_native_hawaiian_pacific_islander;
				vs_E131_foster_parent1_race_white:= cur_la_placement.E131_foster_parent1_race_white;
				vs_E132_foster_parent1_race_unknown := cur_la_placement.E132_foster_parent1_race_unknown;
				vs_E133_foster_parent1_race_declined := cur_la_placement.E133_foster_parent1_race_declined;
				vs_E134_foster_parent1_hispanic_latino := cur_la_placement.E134_foster_parent1_hispanic_latino;
				vs_E135_foster_parent1_sex := cur_la_placement.E135_foster_parent1_sex;
				-- FC Parent 2
				vs_E136_foster_parent2_birth_year := cur_la_placement.E136_foster_parent2_birth_year;
				vs_E137_foster_parent2_tribal_membership := cur_la_placement.E137_foster_parent2_tribal_membership ;
				vs_E138_foster_parent2_race_american_indian_alaska_native := cur_la_placement.E138_foster_parent2_race_american_indian_alaska_native;
				vs_E139_foster_parent2_race_asian := cur_la_placement.E139_foster_parent2_race_asian;
				vs_E140_foster_parent2_race_black := cur_la_placement.E140_foster_parent2_race_black;
				vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := cur_la_placement.E141_foster_parent2_race_native_hawaiian_pacific_islander;
				vs_E142_foster_parent2_race_white := cur_la_placement.E142_foster_parent2_race_white;
				vs_E143_foster_parent2_race_unknown := cur_la_placement.E143_foster_parent2_race_unknown;
				vs_E144_foster_parent2_race_declined := cur_la_placement.E144_foster_parent2_race_declined;
				vs_E145_foster_parent2_hispanic_latino := cur_la_placement.E145_foster_parent2_hispanic_latino;
				vs_E146_foster_parent2_sex := cur_la_placement.E146_foster_parent2_sex;
				vu_placementid := cur_la_placement.placementid;
				vd_pl_startdate := cur_la_placement.startdatetime;
				vd_pl_enddate := cur_la_placement.enddatetime;
				vl_altproviderid := cur_la_placement.altproviderid;
				
				vl_placement_sructure_id := cur_la_placement.service_id;
				
				-- Loop for CPA Homes
				vl_cpahome_count := 0;
					
				OPEN cur_cap_home_REFCURSOR FOR
					select cpa.placementcpahomeid,
						cpa.altproviderid, 
						cpa.entrydt, 
						cpa.exitdt
					from placementcpahomes cpa 
					where cpa.placementid = vu_placementid
						and cpa.activeflag = 1
						and cpa.altproviderid is not null
						and cpa.entrydt is not null
						and cpa.entrydt between vd_removaldate and coalesce(vd_exitdate, vdt_to::date)
						and ( case when cpa.exitdt is not null then   
								cpa.entrydt::date <> cpa.exitdt::date
							  else
								true
							 end) 
					order by cpa.entrydt ;
				LOOP
					fetch cur_cap_home_REFCURSOR into cur_cap_home_record;
					exit when not found;

					-- Reset
					vu_placementcpahomeid := NULL;
					vl_cpahome_altproviderid := NULL;
					vd_cpahome_startdate := NULL;
					vd_cpahome_enddate := NULL;
					
					vl_cpahome_count := vl_cpahome_count + 1;
					
					vu_placementcpahomeid := cur_cap_home_record.placementcpahomeid;
					vl_cpahome_altproviderid := cur_cap_home_record.altproviderid ;
					vd_cpahome_startdate := cur_cap_home_record.entrydt; 
					vd_cpahome_enddate := cur_cap_home_record.exitdt; 
					
					
					if vl_cpahome_count = 1 -- 1st CPA Home
							and vs_E112_date_living_arrangement::date < vd_cpahome_startdate::date then
						vd_cpahome_startdate := vs_E112_date_living_arrangement ;
					end if;
					
					-- Reset
					vl_address_id := NULL;
					vs_E121_location_of_living_arrangement := NULL;
					vs_E122_jurisdiction_or_country := NULL;
					vs_family_structure_cd := NULL;
					vs_E125_foster_parent1_birth_year := NULL; 
					vs_E134_foster_parent1_hispanic_latino := NULL;
					vs_E127_foster_parent1_race_american_indian_alaska_native := NULL; 
					vs_E128_foster_parent1_race_asian := NULL; 
					vs_E129_foster_parent1_race_black := NULL; 
					vs_E130_foster_parent1_race_native_hawaiian_pacific_islander := NULL; 
					vs_E131_foster_parent1_race_white := NULL; 
					vs_E132_foster_parent1_race_unknown := NULL; 
					vs_E133_foster_parent1_race_declined := NULL; 						
					vs_E135_foster_parent1_sex := NULL;
					vs_E123_marital_status_of_foster_parents := NULL;
					vs_E136_foster_parent2_birth_year := NULL;
					vs_E137_foster_parent2_tribal_membership := NULL;
					vs_E138_foster_parent2_race_american_indian_alaska_native := NULL;
					vs_E139_foster_parent2_race_asian := NULL;
					vs_E140_foster_parent2_race_black := NULL;
					vs_E141_foster_parent2_race_native_hawaiian_pacific_islander := NULL;
					vs_E142_foster_parent2_race_white := NULL;
					vs_E143_foster_parent2_race_unknown := NULL;
					vs_E144_foster_parent2_race_declined := NULL;
					vs_E145_foster_parent2_hispanic_latino := NULL;
					vs_E146_foster_parent2_sex := NULL;
					vl_provider_cpa_adop_person_id := null;

					select prd.address_id,
							( case when coalesce(prd.adr_format_cd, '') = 'F' 
								and coalesce(prd.adr_country_tx, 'US') not in ( 'US', 'USA', 'United States' ) then
								'3' --  Out-of-country
							  when coalesce(prd.adr_state_cd, 'MD') = 'MD' then
								'1' -- In-state or in-Tribal service area
							  when coalesce(prd.adr_state_cd, 'MD') <> 'MD' then	
								'2' -- Out-of-state or out-of-Tribal service area
							  when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' )
									and coalesce(prd.adr_state_cd, 'MD') = 'XX' then
								'1' -- In-state	
							  else
								'1' -- In-state
							end) as E121_location_of_living_arrangement,
							(case when coalesce(prd.adr_state_cd, 'MD') = 'MD'  then
								-- Null should be used if the agency indicated 
								-- If # 121 is '1' (in-state or in-Tribal service area) or '4' (runaway or whereabouts unknown) 
								NULL
							when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' ) then 
								-- coalesce(prd.adr_format_cd, '') <> 'F' -- then
								(case when coalesce(prd.adr_state_cd, 'MD') = 'AL' then '01' -- Alabama
									when coalesce(prd.adr_state_cd, 'MD') = 'AK' then '02' -- Alaska
									when coalesce(prd.adr_state_cd, 'MD') = 'AZ' then '04' -- Arizona	
									when coalesce(prd.adr_state_cd, 'MD') = 'AR' then '05' -- Arkansas	
									when coalesce(prd.adr_state_cd, 'MD') = 'CA' then '06' -- California	
									when coalesce(prd.adr_state_cd, 'MD') = 'CO' then '08' -- Colorado
									when coalesce(prd.adr_state_cd, 'MD') = 'CT' then '09' -- Connecticut	
									when coalesce(prd.adr_state_cd, 'MD') = 'DE'	then '10' -- Delaware	
									when coalesce(prd.adr_state_cd, 'MD') = 'DC' then '11' -- District of Columbia	
									when coalesce(prd.adr_state_cd, 'MD') = 'FL' then '12' -- Florida	
									when coalesce(prd.adr_state_cd, 'MD') = 'GA' then '13' -- Georgia	
									when coalesce(prd.adr_state_cd, 'MD') = 'HI' then '15' -- Hawaii	
									when coalesce(prd.adr_state_cd, 'MD') = 'ID' then '16' -- Idaho	
									when coalesce(prd.adr_state_cd, 'MD') = 'IL' then '17' -- Illinois	
									when coalesce(prd.adr_state_cd, 'MD') = 'IN' then '18' -- Indiana 	
									when coalesce(prd.adr_state_cd, 'MD') = 'IA' then '19' -- Iowa	
									when coalesce(prd.adr_state_cd, 'MD') = 'KS' then '20' -- Kansas	
									when coalesce(prd.adr_state_cd, 'MD') = 'KY' then '21' -- Kentucky	
									when coalesce(prd.adr_state_cd, 'MD') = 'LA' then '22' -- Louisiana	
									when coalesce(prd.adr_state_cd, 'MD') = 'ME' then '23' -- Maine	
									when coalesce(prd.adr_state_cd, 'MD') = 'MD' then Null -- '24' -- Maryland	
									when coalesce(prd.adr_state_cd, 'MD') = 'MA' then '25' -- Massachusetts	
									when coalesce(prd.adr_state_cd, 'MD') = 'MI' then '26' -- Michigan	
									when coalesce(prd.adr_state_cd, 'MD') = 'MN' then '27' -- Minnesota	
									when coalesce(prd.adr_state_cd, 'MD') = 'MS' then '28' -- Mississippi
									when coalesce(prd.adr_state_cd, 'MD') = 'MO' then '29' -- Missouri	
									when coalesce(prd.adr_state_cd, 'MD') = 'MT' then '30' -- Montana
									when coalesce(prd.adr_state_cd, 'MD') = 'NE' then '31' -- Nebraska
									when coalesce(prd.adr_state_cd, 'MD') = 'NV' then '32' -- Nevada
									when coalesce(prd.adr_state_cd, 'MD') = 'NH' then '33' -- New Hampshire
									when coalesce(prd.adr_state_cd, 'MD') = 'NJ' then '34' -- New Jersey
									when coalesce(prd.adr_state_cd, 'MD') = 'NM' then '35' -- New Mexico
									when coalesce(prd.adr_state_cd, 'MD') = 'NY' then '36' -- New York
									when coalesce(prd.adr_state_cd, 'MD') = 'NC' then '37' -- North Carolina
									when coalesce(prd.adr_state_cd, 'MD') = 'ND' then '38' -- North Dakota
									when coalesce(prd.adr_state_cd, 'MD') = 'OH' then '39' -- Ohio
									when coalesce(prd.adr_state_cd, 'MD') = 'OK' then '40' -- Oklahoma
									when coalesce(prd.adr_state_cd, 'MD') = 'OR' then '41' -- Oregon
									when coalesce(prd.adr_state_cd, 'MD') = 'PA' then '42' -- Pennsylvania
									when coalesce(prd.adr_state_cd, 'MD') = 'PR' then '72' -- Puerto Rico
									when coalesce(prd.adr_state_cd, 'MD') = 'RI' then '44' -- Rhode Island
									when coalesce(prd.adr_state_cd, 'MD') = 'SC' then '45' -- South Carolina
									when coalesce(prd.adr_state_cd, 'MD') = 'SD' then '46' -- South Dakota
									when coalesce(prd.adr_state_cd, 'MD') = 'TN' then '47' -- Tennessee
									when coalesce(prd.adr_state_cd, 'MD') = 'TX' then '48' -- Texas
									when coalesce(prd.adr_state_cd, 'MD') = 'UT' then '49' -- Utah
									when coalesce(prd.adr_state_cd, 'MD') = 'VT' then '50' -- Vermont
									when coalesce(prd.adr_state_cd, 'MD') = 'VA' then '51' -- Virginia
									when coalesce(prd.adr_state_cd, 'MD') = 'VI' then '78' -- Virgin Islands
									when coalesce(prd.adr_state_cd, 'MD') = 'WA' then '53' -- Washington
									when coalesce(prd.adr_state_cd, 'MD') = 'WV' then '54' -- West Virginia
									when coalesce(prd.adr_state_cd, 'MD') = 'WI' then '55' -- Wisconsin
									when coalesce(prd.adr_state_cd, 'MD') = 'WY' then '56' -- Wyoming
								else
										null
								end)
							when coalesce(prd.adr_format_cd, '') = 'F' then
								(select ref_key 
									from referencevalues
								 where referencetypeid = 310
									and lower(value_text) like '%' || lower(prd.adr_country_tx) || '%'  
									and activeflag = 1
									and coalesce(teamtypekey, 'CW') = 'CW'
								limit 1
								) -- Country: 3-digit ISO Alpha code ???
							end) as E122_jurisdiction_or_country
						into vl_address_id,
							vs_E121_location_of_living_arrangement,
							vs_E122_jurisdiction_or_country
					from prov.tb_provider_addresses prd
					where prd.parent_key_id = vl_cpahome_altproviderid::character varying
						and btrim(prd.adr_type_cd) = '3357' -- Provider Location 
						and prd.delete_sw = 'N' 
						-- and prd.adr_default_sw = 'Y'
						and prd.adr_start_dt <= coalesce(vd_cpahome_enddate, vdt_to::date)
						and (prd.adr_end_dt is null or prd.adr_end_dt >= vd_cpahome_startdate )
					order by prd.adr_start_dt desc 
					limit 1 ;
					
					-- Report based on most recent provider address
					if vl_address_id is null then
						select ( case when coalesce(prd.adr_format_cd, '') = 'F' 
									and coalesce(prd.adr_country_tx, 'US') not in ( 'US', 'USA', 'United States' ) then
									'3' --  Out-of-country
								  when coalesce(prd.adr_state_cd, 'MD') = 'MD' then
									'1' -- In-state or in-Tribal service area
								  when coalesce(prd.adr_state_cd, 'MD') <> 'MD' then	
									'2' -- Out-of-state or out-of-Tribal service area
								  when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' )
										and coalesce(prd.adr_state_cd, 'MD') = 'XX' then
									'1' -- In-state	
								  else
									'1' -- In-state
								end) as E121_location_of_living_arrangement,
								(case when coalesce(prd.adr_state_cd, 'MD') = 'MD'  then
									-- Null should be used if the agency indicated 
									-- If # 121 is '1' (in-state or in-Tribal service area) or '4' (runaway or whereabouts unknown) 
									NULL
								when coalesce(prd.adr_country_tx, 'USA') in ( 'US', 'USA', 'United States' ) then 
									-- coalesce(prd.adr_format_cd, '') <> 'F' -- then
									(case when coalesce(prd.adr_state_cd, 'MD') = 'AL' then '01' -- Alabama
										when coalesce(prd.adr_state_cd, 'MD') = 'AK' then '02' -- Alaska
										when coalesce(prd.adr_state_cd, 'MD') = 'AZ' then '04' -- Arizona	
										when coalesce(prd.adr_state_cd, 'MD') = 'AR' then '05' -- Arkansas	
										when coalesce(prd.adr_state_cd, 'MD') = 'CA' then '06' -- California	
										when coalesce(prd.adr_state_cd, 'MD') = 'CO' then '08' -- Colorado
										when coalesce(prd.adr_state_cd, 'MD') = 'CT' then '09' -- Connecticut	
										when coalesce(prd.adr_state_cd, 'MD') = 'DE'	then '10' -- Delaware	
										when coalesce(prd.adr_state_cd, 'MD') = 'DC' then '11' -- District of Columbia	
										when coalesce(prd.adr_state_cd, 'MD') = 'FL' then '12' -- Florida	
										when coalesce(prd.adr_state_cd, 'MD') = 'GA' then '13' -- Georgia	
										when coalesce(prd.adr_state_cd, 'MD') = 'HI' then '15' -- Hawaii	
										when coalesce(prd.adr_state_cd, 'MD') = 'ID' then '16' -- Idaho	
										when coalesce(prd.adr_state_cd, 'MD') = 'IL' then '17' -- Illinois	
										when coalesce(prd.adr_state_cd, 'MD') = 'IN' then '18' -- Indiana 	
										when coalesce(prd.adr_state_cd, 'MD') = 'IA' then '19' -- Iowa	
										when coalesce(prd.adr_state_cd, 'MD') = 'KS' then '20' -- Kansas	
										when coalesce(prd.adr_state_cd, 'MD') = 'KY' then '21' -- Kentucky	
										when coalesce(prd.adr_state_cd, 'MD') = 'LA' then '22' -- Louisiana	
										when coalesce(prd.adr_state_cd, 'MD') = 'ME' then '23' -- Maine	
										when coalesce(prd.adr_state_cd, 'MD') = 'MD' then Null -- '24' -- Maryland	
										when coalesce(prd.adr_state_cd, 'MD') = 'MA' then '25' -- Massachusetts	
										when coalesce(prd.adr_state_cd, 'MD') = 'MI' then '26' -- Michigan	
										when coalesce(prd.adr_state_cd, 'MD') = 'MN' then '27' -- Minnesota	
										when coalesce(prd.adr_state_cd, 'MD') = 'MS' then '28' -- Mississippi
										when coalesce(prd.adr_state_cd, 'MD') = 'MO' then '29' -- Missouri	
										when coalesce(prd.adr_state_cd, 'MD') = 'MT' then '30' -- Montana
										when coalesce(prd.adr_state_cd, 'MD') = 'NE' then '31' -- Nebraska
										when coalesce(prd.adr_state_cd, 'MD') = 'NV' then '32' -- Nevada
										when coalesce(prd.adr_state_cd, 'MD') = 'NH' then '33' -- New Hampshire
										when coalesce(prd.adr_state_cd, 'MD') = 'NJ' then '34' -- New Jersey
										when coalesce(prd.adr_state_cd, 'MD') = 'NM' then '35' -- New Mexico
										when coalesce(prd.adr_state_cd, 'MD') = 'NY' then '36' -- New York
										when coalesce(prd.adr_state_cd, 'MD') = 'NC' then '37' -- North Carolina
										when coalesce(prd.adr_state_cd, 'MD') = 'ND' then '38' -- North Dakota
										when coalesce(prd.adr_state_cd, 'MD') = 'OH' then '39' -- Ohio
										when coalesce(prd.adr_state_cd, 'MD') = 'OK' then '40' -- Oklahoma
										when coalesce(prd.adr_state_cd, 'MD') = 'OR' then '41' -- Oregon
										when coalesce(prd.adr_state_cd, 'MD') = 'PA' then '42' -- Pennsylvania
										when coalesce(prd.adr_state_cd, 'MD') = 'PR' then '72' -- Puerto Rico
										when coalesce(prd.adr_state_cd, 'MD') = 'RI' then '44' -- Rhode Island
										when coalesce(prd.adr_state_cd, 'MD') = 'SC' then '45' -- South Carolina
										when coalesce(prd.adr_state_cd, 'MD') = 'SD' then '46' -- South Dakota
										when coalesce(prd.adr_state_cd, 'MD') = 'TN' then '47' -- Tennessee
										when coalesce(prd.adr_state_cd, 'MD') = 'TX' then '48' -- Texas
										when coalesce(prd.adr_state_cd, 'MD') = 'UT' then '49' -- Utah
										when coalesce(prd.adr_state_cd, 'MD') = 'VT' then '50' -- Vermont
										when coalesce(prd.adr_state_cd, 'MD') = 'VA' then '51' -- Virginia
										when coalesce(prd.adr_state_cd, 'MD') = 'VI' then '78' -- Virgin Islands
										when coalesce(prd.adr_state_cd, 'MD') = 'WA' then '53' -- Washington
										when coalesce(prd.adr_state_cd, 'MD') = 'WV' then '54' -- West Virginia
										when coalesce(prd.adr_state_cd, 'MD') = 'WI' then '55' -- Wisconsin
										when coalesce(prd.adr_state_cd, 'MD') = 'WY' then '56' -- Wyoming
									else
											null
									end)
								when coalesce(prd.adr_format_cd, '') = 'F' then
									(select ref_key 
										from referencevalues
									 where referencetypeid = 310
										and lower(value_text) like '%' || lower(prd.adr_country_tx) || '%'  
										and activeflag = 1
										and coalesce(teamtypekey, 'CW') = 'CW'
									limit 1
									) -- Country: 3-digit ISO Alpha code ???
								end) as E122_jurisdiction_or_country
							into vs_E121_location_of_living_arrangement,
								vs_E122_jurisdiction_or_country
						from prov.tb_provider_addresses prd
						where prd.parent_key_id = vl_cpahome_altproviderid::character varying
							and btrim(prd.adr_type_cd) = '3357' -- Provider Location 
							and prd.delete_sw = 'N' 
							-- and prd.adr_default_sw = 'Y'
							-- and prd.adr_start_dt <= coalesce(vd_cpahome_enddate, vdt_to::date)
							-- and (prd.adr_end_dt is null or prd.adr_end_dt >= vd_cpahome_startdate )
						order by prd.adr_start_dt desc 
						limit 1 ;
					end if;
					
					-- Get CPA Home Applicant Details
					select marital_status,
						family_structure_cd, 
						date_part('year', dob_dt::date)::varchar as dob_year,
						(case when btrim(primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
							'1'
						else
							'0'
						end) as	E127_foster_parent1_race_american_indian_alaska_native,
						(case when btrim(primary_race_cd) in ('6310', '6346' ) then -- Asian
							'1'
						else
							'0'
						end) as	E128_foster_parent1_race_asian,
						(case when btrim(primary_race_cd) = '1801' then -- Black/African-American
							'1'
						else
							'0'
						end) as	E129_foster_parent1_race_black,
						(case when btrim(primary_race_cd) in ('6311', '6347', '1804') then 
							-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
							'1'
						else
							'0'
						end) as	E130_foster_parent1_race_native_hawaiian_pacific_islander,
						(case when btrim(primary_race_cd) = '1806' then -- White/Caucasian 
							'1'
						else
							'0'
						end) as	E131_foster_parent1_race_white, 
						(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
							'1'
						else
							'0'
						end) as	E132_foster_parent1_race_unknown, 
						(case when btrim(primary_race_cd) = '6314' then -- Declined
							'1'
						else
							'0'
						end) as	E133_foster_parent1_race_declined, 
						(case when hispanic_cd = 'Y' then 
							'1'  -- Yes
						when hispanic_cd = 'N' then 
							'0' -- No
						when hispanic_cd = 'U' then 
							'9' -- Unknown
						else 
							NULL
						end) as hispanic_cd,
						(case when btrim(gender_cd) = '1282' then -- Male
							'1'
						 when btrim(gender_cd) = '1281' then -- Female
							'2'
						 else
							Null
						end) gender_cd
					into vs_marital_status_cd,
						vs_family_structure_cd,
						vs_E125_foster_parent1_birth_year, 
						vs_E127_foster_parent1_race_american_indian_alaska_native, 
						vs_E128_foster_parent1_race_asian, 
						vs_E129_foster_parent1_race_black, 
						vs_E130_foster_parent1_race_native_hawaiian_pacific_islander, 
						vs_E131_foster_parent1_race_white, 
						vs_E132_foster_parent1_race_unknown, 
						vs_E133_foster_parent1_race_declined, 						
						vs_E134_foster_parent1_hispanic_latino,
						vs_E135_foster_parent1_sex
					from prov.tb_prov_cpa_adop_person 
					where provider_id = vl_cpahome_altproviderid
						and delete_sw = 'N' 
						and btrim(person_type_cd) = '3610' -- Applicant
					order by provider_cpa_adop_person_id desc
					limit 1;
					
					If vs_marital_status_cd is not null then 
						select (case when btrim(vs_marital_status_cd) in ('MR', '290', '1569') then 
									'1' -- Married Couple
								when btrim(vs_marital_status_cd) in ('294', '296', '298', '299', '1572') then 
									'2' -- Unmarried Couple
								when btrim(vs_marital_status_cd) in ('288', '289', '291', '292', 'DV', 'LS', '1570') then 
									'3' -- Separated
								when btrim(vs_marital_status_cd) in ('293', '295', '297', 'SG', 'WD', 'UK', '1568', '1571', '3673', '3674' ) then
									'4' -- Single adult 
								end )
						into vs_E123_marital_status_of_foster_parents ;		
					end if;
					
					if vs_E123_marital_status_of_foster_parents is null
						or btrim(vs_E123_marital_status_of_foster_parents) = '' then 
						
						select (case when vs_family_structure_cd in ('MR', '290') then -- 	Married Couple
									'1' -- Married couple
								when vs_family_structure_cd in ('294', '296', '298', '299') then
									'2' -- Unmarried couple
								when vs_family_structure_cd in ('288', '289', '291', '292', 'DV', 'LS') then 	
									'3' -- Separated
								when vs_family_structure_cd in ('293', '295', '297', 'SG', 'WD', 'UK') then	
									'4' -- Single adult 
								else
									'4' -- For Compliance Single adult 
								end )
						into vs_E123_marital_status_of_foster_parents ;
					end if;
					
					if vs_E123_marital_status_of_foster_parents is null
						or btrim(vs_E123_marital_status_of_foster_parents) = '' then
						vs_E123_marital_status_of_foster_parents := '4' ; -- For Compliance Single adult 
					end if;
					
					-- Get CPA Home Co-Applicant Details
					select provider_cpa_adop_person_id,
						date_part('year', dob_dt::date)::varchar as dob_year,
						'9' as tribal_membership, 
						(case when btrim(primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
							'1'
						else
							'0'
						end) as	E127_foster_parent1_race_american_indian_alaska_native,
						(case when btrim(primary_race_cd) in ('6310', '6346' ) then -- Asian
							'1'
						else
							'0'
						end) as	E128_foster_parent1_race_asian,
						(case when btrim(primary_race_cd) = '1801' then -- Black/African-American
							'1'
						else
							'0'
						end) as	E129_foster_parent1_race_black,
						(case when btrim(primary_race_cd) in ('6311', '6347', '1804') then 
							-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
							'1'
						else
							'0'
						end) as	E130_foster_parent1_race_native_hawaiian_pacific_islander,
						(case when btrim(primary_race_cd) = '1806' then -- White/Caucasian 
							'1'
						else
							'0'
						end) as	E131_foster_parent1_race_white, 
						(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
							'1'
						else
							'0'
						end) as	E132_foster_parent1_race_unknown, 
						(case when btrim(primary_race_cd) = '6314' then -- Declined
							'1'
						else
							'0'
						end) as	E133_foster_parent1_race_declined, 
						(case when hispanic_cd = 'Y' then 
							'1'  -- Yes
						when hispanic_cd = 'N' then 
							'0' -- No
						when hispanic_cd = 'U' then 
							'9' -- Unknown
						else 
							NULL
						end) as hispanic_cd,
						(case when btrim(gender_cd) = '1282' then -- Male
							'1'
						 when btrim(gender_cd) = '1281' then -- Female
							'2'
						 else
							Null
						end) gender_cd
					into vl_provider_cpa_adop_person_id,
						vs_E136_foster_parent2_birth_year,
						vs_E137_foster_parent2_tribal_membership,
						vs_E138_foster_parent2_race_american_indian_alaska_native,
						vs_E139_foster_parent2_race_asian,
						vs_E140_foster_parent2_race_black,
						vs_E141_foster_parent2_race_native_hawaiian_pacific_islander,
						vs_E142_foster_parent2_race_white,
						vs_E143_foster_parent2_race_unknown,
						vs_E144_foster_parent2_race_declined,
						vs_E145_foster_parent2_hispanic_latino,
						vs_E146_foster_parent2_sex
					from prov.tb_prov_cpa_adop_person 
					where provider_id = vl_cpahome_altproviderid
						and delete_sw = 'N' 
						and btrim(person_type_cd) = '3611' -- Co-Applicant
					order by provider_cpa_adop_person_id desc
					limit 1;
					
					
					-- CIDM-11353 04/21/2026
					if vl_provider_cpa_adop_person_id is null then 
						vs_E123_marital_status_of_foster_parents := '4' ; -- For Compliance Single adult 
					end if;	
					
					INSERT INTO cjams.afcars_fc_placements
					(	afcarsfostercareid, 
						recordno, 
						removalid, 
						e112_date_living_arrangement, 
						e113_foster_family_home, 
						e114_licensed_home, 
						e115_therapeutic_home, 
						e116_shelter_care_home, 
						e117_relative_foster_family, 
						e118_pre_adopt_home, 
						e119_kin_foster_family, 
						e120_other_living_arrangement_type, 
						e121_location_of_living_arrangement, 
						e122_jurisdiction_or_country, 
						e123_marital_status_of_foster_parents, 
						e124_relationship_to_foster_parents, 
						e125_foster_parent1_birth_year, 
						e126_foster_parent1_tribal_membership, 
						e127_foster_parent1_race_american_indian_alaska_native, 
						e128_foster_parent1_race_asian, 
						e129_foster_parent1_race_black, 
						e130_foster_parent1_race_native_hawaiian_pacific_islander, 
						e131_foster_parent1_race_white, 
						e132_foster_parent1_race_unknown, 
						e133_foster_parent1_race_declined, 
						e134_foster_parent1_hispanic_latino, 
						e135_foster_parent1_sex, 
						e136_foster_parent2_birth_year, 
						e137_foster_parent2_tribal_membership, 
						e138_foster_parent2_race_american_indian_alaska_native, 
						e139_foster_parent2_race_asian, 
						e140_foster_parent2_race_black, 
						e141_foster_parent2_race_native_hawaiian_pacific_islander, 
						e142_foster_parent2_race_white, 
						e143_foster_parent2_race_unknown, 
						e144_foster_parent2_race_declined, 
						e145_foster_parent2_hispanic_latino, 
						e146_foster_parent2_sex, 
						placementid, 
						cjamspid, 
						caseid,
						placementtype,
						placementcpahomeid,
						start_date,
						placementsubtype,
						original_removalid
						)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_removalid, 
						vd_cpahome_startdate,  -- vs_e112_date_living_arrangement, 
						vs_e113_foster_family_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e114_licensed_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e115_therapeutic_home, '0') -- Does not apply
						else
							NULL
						end),
												
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e116_shelter_care_home, '0') -- Does not apply
						else
							NULL
						end), 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e117_relative_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
						
						vs_e118_pre_adopt_home, 
						
						(case when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e119_kin_foster_family, '0') -- Does not apply
						else
							NULL
						end), 
												
						(case when vs_e113_foster_family_home = '0' then -- No
							vs_e120_other_living_arrangement_type
						else	
							NULL  -- For Compliance
						end),
						
						vs_e121_location_of_living_arrangement, 
						
						(case when vs_e121_location_of_living_arrangement = '1'	
							or vs_e121_location_of_living_arrangement = '4' then
							NULL -- For Compliance
						else	
							vs_e122_jurisdiction_or_country
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e123_marital_status_of_foster_parents
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e124_relationship_to_foster_parents
						end), 
						-- vs_e124_relationship_to_foster_parents,

						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e125_foster_parent1_birth_year
						end),
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						else	
							coalesce(vs_e126_foster_parent1_tribal_membership, '9')
							-- '9' --  Unknown
						end),
						-- vs_e126_foster_parent1_tribal_membership, -- e126 ??
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') -- No
						else
							vs_e127_foster_parent1_race_american_indian_alaska_native						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e128_foster_parent1_race_asian, '0') -- No
						else
							vs_e128_foster_parent1_race_asian						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e129_foster_parent1_race_black, '0') -- No
						else
							vs_e129_foster_parent1_race_black						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') -- No
						else
							vs_e130_foster_parent1_race_native_hawaiian_pacific_islander						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e131_foster_parent1_race_white, '0') -- No
						else
							vs_e131_foster_parent1_race_white						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e132_foster_parent1_race_unknown, '0') -- No
						else
							vs_e132_foster_parent1_race_unknown						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							(case when coalesce(vs_e127_foster_parent1_race_american_indian_alaska_native, '0') = '0'
								and coalesce(vs_e128_foster_parent1_race_asian, '0') = '0'
								and coalesce(vs_e129_foster_parent1_race_black, '0') = '0'
								and coalesce(vs_e130_foster_parent1_race_native_hawaiian_pacific_islander, '0') = '0'
								and coalesce(vs_e131_foster_parent1_race_white, '0') = '0'
								and coalesce(vs_e132_foster_parent1_race_unknown, '0') = '0' then
							'1' -- For Test Compliance
							else
								coalesce(vs_e133_foster_parent1_race_declined, '0') -- No
							end)
						else
							vs_e133_foster_parent1_race_declined						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL -- For Compliance
						when vs_e113_foster_family_home = '1' then -- Yes
							coalesce(vs_e134_foster_parent1_hispanic_latino, '9') -- Unknown
						else
							vs_e134_foster_parent1_hispanic_latino						
						end), 
						
						(case when vs_e113_foster_family_home = '0' then -- No
							NULL
						else
							vs_e135_foster_parent1_sex
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e136_foster_parent2_birth_year
							end)
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								'9'-- vs_e137_foster_parent2_tribal_membership, -- e137 ?? --  Unknown
							end)						 
						end),	
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e138_foster_parent2_race_american_indian_alaska_native
							end)						 
						end),
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e139_foster_parent2_race_asian
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e140_foster_parent2_race_black
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e141_foster_parent2_race_native_hawaiian_pacific_islander
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e142_foster_parent2_race_white
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e143_foster_parent2_race_unknown
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e144_foster_parent2_race_declined
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else	
								vs_e145_foster_parent2_hispanic_latino
							end)						 
						end), 
						
						(case when vs_e123_marital_status_of_foster_parents = '3' -- Separated
							or vs_e123_marital_status_of_foster_parents = '4' -- Single adult
							or vs_e123_marital_status_of_foster_parents is null -- Not applicable
							then
							null -- For Compliance  must be null (No second parent or Not applicable).
						 else
							(case when vs_e113_foster_family_home = '0' then -- No
								NULL -- For Compliance
							else		
								vs_e146_foster_parent2_sex
							end)						 
						end),
						
						vu_placementid, 
						vs_client_id, 
						vs_caseid,
						vs_placement_type,
						vu_placementcpahomeid,
						vd_cpahome_startdate, -- vd_pl_startdate,
						vl_placement_sructure_id::character varying,
						vs_removalid
					);
					
				END LOOP;	
				close cur_cap_home_REFCURSOR;	
				
			END LOOP;		
			close cur_la_placement_REFCURSOR;	

			-- Capture Provider Placement Details (with CPA Homes) - END
			
			-- RAISE NOTICE 'Adoptive Parents Details';
			-- Capture Adoptive Parents Details
			if vs_E155_exit_reason = '3' then -- Adoption
				-- RAISE NOTICE 'vs_client_id >> %',vs_client_id;
				
				-- Reset 
				vl_adoption_client_id := NULL;
				vl_adop_casenumber := NULL; 
				vl_adop_plan_id := NULL; 
				vl_client_id := NULL;
				vl_post_adopt_id := NULL; 
				vl_adop_case_id := NULL;
				vl_servicecaseid := NULL;
					
				select pr_adop.cjamspid as adoption_client_id
					into vl_adoption_client_id
				from adoptionlink adl,
					person pr_bio,
					person pr_adop,
					adoptioncase adc
				where adl.preadoptionclientid = pr_bio.personid
					and adl.adoptionclientid = pr_adop.personid
					and adl.adoptioncaseid = adc.adoptioncaseid
					and adl.activeflag = 1
					and pr_bio.activeflag = 1
					and pr_adop.activeflag = 1
					and adc.activeflag = 1
					and pr_bio.cjamspid = vs_client_id::bigint ;

				-- Get Adoption Details 
				SELECT DISTINCT adoptioncasenumber,
				   adoptionplanningid,
				   cjamspid, 
				   cjamspid1, 
				   adoptioncaseid ,  
				   servicecaseid 
				into vl_adop_casenumber, 
					vl_adop_plan_id , 
					vl_client_id,
					vl_post_adopt_id, 
					vl_adop_case_id,
					vl_servicecaseid
				 FROM 
					(WITH cte as (
						select 	distinct ac.adoptioncasenumber, 
								ap.adoptionplanningid,
								p.cjamspid, 
								pr.cjamspid as cjamspid1, 
								ac.adoptioncaseid ,  
								ap.servicecaseid,
								- 2 as caseorder 
						from 	adoptioncase ac 
								join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
									and aca.actortypekey in ( 'CHILD', 'PVTADPCHILD')
								join person pr on pr.personid = aca.personid 
									and pr.activeflag = 1 
								join adoptionplanning ap on ac.adoptionplanningid = ap.adoptionplanningid 
									and ap.activeflag = 1
								join adoptionbreakthelink abl ON abl.adoptionplanningid = ap.adoptionplanningid
								join person p on p.personid = aca.personid 
									and p.activeflag = 1
						WHERE 	ac.activeflag = 1 
								and (
										( 	abl.finalizationdate::date IS NOT NULL 
											and abl.finalizationdate::date >= vdt_from::DATE 
											and abl.finalizationdate::date <= vdt_to::DATE 	
										)
										or
										(
											ac.startdate::date >= vdt_from::DATE 
											and ac.startdate::date <= vdt_to::DATE
										)
									)	
						UNION 
						select 	distinct ac.adoptioncasenumber, 
								bol.preadoptivecaseid as adoptionplanningid,
								pa.cjamspid, 
								pr.cjamspid as cjamspid1, 
								ac.adoptioncaseid,
								bol.biologicalcaseid as servicecaseid,
								- 1 as caseorder
						from 	adoptioncase ac 
								join adoptionlink al on al.adoptioncaseid = ac.adoptioncaseid
								join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
									and aca.actortypekey in ( 'CHILD', 'PVTADPCHILD')
								join person pr on pr.personid = aca.personid 
									and pr.activeflag = 1 
								join biologicaladoptionlink bol on al.preadoptionclientid = bol.preadoptiveclientid
								join adoptionbreakthelink abl ON abl.adoptionplanningid = bol.preadoptivecaseid
								join person pa on pa.personid = BOL.preadoptiveclientid 
									and pa.activeflag = 1
						WHERE 	ac.activeflag = 1 
								and (
										(	 abl.finalizationdate::date IS NOT NULL 
											and abl.finalizationdate::date >= vdt_from::DATE 
											and abl.finalizationdate::date <= vdt_to::DATE
										)
										or
										(
											ac.startdate::date >= vdt_from::DATE 
											and ac.startdate::date <= vdt_to::DATE
										)
									)					
						)	
					SELECT adoptioncasenumber, adoptionplanningid, cjamspid, cjamspid1, adoptioncaseid, 
					servicecaseid,
							LAG(adoptioncasenumber,1) 
							OVER (order by adoptioncasenumber, caseorder) as prevadoptioncasenumber
							FROM cte) a
				WHERE CASE WHEN adoptioncasenumber = prevadoptioncasenumber THEN false else true end
					and cjamspid = vl_adoption_client_id
				order by adoptioncasenumber desc 
				limit 1;
				
				-- Reset
				
				vs_E157_marital_status_of_adoptive_parents := NULL;
				vl_adop_parent_id := NULL;
				vl_family_structure := NULL;
				
				OPEN cur_adop_parents_REFCURSOR FOR
					select distinct acr.personid
					from adoptioncase ac, 
						adoptioncaseactor acr, 
						person p 
					where ac.adoptioncaseid = acr.adoptioncaseid 
						and acr.personid = p.personid 
						and acr.actortypekey = 'ADOPTIVEPARENT'
						and ac.adoptioncasenumber = vl_adop_casenumber::varchar; 
				LOOP
					fetch cur_adop_parents_REFCURSOR into cur_adop_parents;
					exit when not found;
					
					-- Reset
					vl_adop_parent_id := NULL;
					
					vl_adop_parent_id := cur_adop_parents.personid;
					
					If vl_adop_parent_id is not null 
						and vs_E157_marital_status_of_adoptive_parents is null then 
					
							SELECT ( CASE 
									WHEN (trim(p.maritalstatustypekey)) = 'LS' THEN '3' -- Legally Separated
									WHEN (
										   (trim(p.maritalstatustypekey) = 'S' 
										   or 
										   trim(p.maritalstatustypekey)= 'SG'
										   ) 
										   and 
										   ( btrim(p.gendertypekey) = 'M'
											or
											btrim(p.gendertypekey) = 'TGIF' -- Transgender- Identifies as Female
											or
											( btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 0 ) -- Assigned Male at Birth *
										   )
										 ) then '4' -- Single adult
									WHEN (
										  (trim(p.maritalstatustypekey) = 'S' 
										   or 
										   trim(p.maritalstatustypekey)= 'SG'
										   ) 
										  and 
										  ( btrim(p.gendertypekey) = 'F'
											or
											btrim(p.gendertypekey) = 'TGIM' 
											or
											( btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 1 ) -- Assigned Female at Birth *
										   )
										 ) then '4' -- Single adult
									WHEN (trim(p.maritalstatustypekey))= 'MR' THEN '1' -- Married couple
								END)  
						into vs_E157_marital_status_of_adoptive_parents 
						from person p 
						where p.personid::varchar = vl_adop_parent_id;
						
					end if;
						
				END LOOP;	
				close cur_adop_parents_REFCURSOR;		
				
				/*
				select distinct acr.personid
					into vl_adop_parent_id
				from adoptioncase ac, 
					adoptioncaseactor acr, 
					person p 
				where ac.adoptioncaseid = acr.adoptioncaseid 
					and acr.personid = p.personid 
					and acr.actortypekey = 'ADOPTIVEPARENT'
					and ac.adoptioncasenumber = vl_adop_casenumber::varchar
				limit 1;

				SELECT ( CASE 
							WHEN (trim(p.maritalstatustypekey)) = 'LS' THEN '3' -- Legally Separated
							WHEN (
								   (trim(p.maritalstatustypekey) = 'S' 
								   or 
								   trim(p.maritalstatustypekey)= 'SG'
								   ) 
								   and 
								   ( btrim(p.gendertypekey) = 'M'
									or
									btrim(p.gendertypekey) = 'TGIF' -- Transgender- Identifies as Female
									or
									( btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 0 ) -- Assigned Male at Birth *
								   )
								 ) then '4' -- Single adult
							WHEN (
								  (trim(p.maritalstatustypekey) = 'S' 
								   or 
								   trim(p.maritalstatustypekey)= 'SG'
								   ) 
								  and 
								  ( btrim(p.gendertypekey) = 'F'
									or
									btrim(p.gendertypekey) = 'TGIM' 
									or
									( btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 1 ) -- Assigned Female at Birth *
								   )
								 ) then '4' -- Single adult
							WHEN (trim(p.maritalstatustypekey))= 'MR' THEN '1' -- Married couple
						END)  
				into vs_E157_marital_status_of_adoptive_parents 
				from person p 
				where p.personid::varchar = vl_adop_parent_id;
				*/
				
				If vs_E157_marital_status_of_adoptive_parents is null then 
					select btrim(marital_status_cd),
							btrim(family_structure_cd)
						into vs_marital_status_cd,
							vl_family_structure 
					from tb_provider_approval tpa, 
						tb_prov_approval_person tpap
					where tpa.provider_approval_id = tpap.provider_approval_id 
						and tpap.person_type_cd in ('3610','3611')
						and tpa.provider_id = (	select adr.provider_id 
												 from adoptioncaseagreement adg,
													adoptioncaseagreementrate adr
												where adg.adoptionagreementid = adr.adoptionagreementid 
													and adg.adoptioncaseid::varchar = vl_adop_case_id 
													and adg.activeflag = 1
													and adr.activeflag = 1
													and adr.provider_id is not null
												order by adr.startdate desc limit 1
												)
						and ( 
							   ( family_structure_cd is not null and btrim(family_structure_cd) <> '' )
								or  
							   ( marital_status_cd is not null and btrim(marital_status_cd) <> '' )
							)
					limit 1;
							
							
					If vs_marital_status_cd is not null then 
						select (case when btrim(vs_marital_status_cd) in ('290', '1569')  then 
									'1' -- Married Couple
								when btrim(vs_marital_status_cd) in ('298', '1572') then 
									'2' -- Unmarried Couple
								when btrim(vs_marital_status_cd) in ('291', '292', '1570') then 
									'3' -- Separated
								when btrim(vs_marital_status_cd) in ('293', '294', '295', '296', '288', '289', '1568', '1571', '3673', '3674' )  then
									'4' -- Single adult 
								end )
						into vs_E157_marital_status_of_adoptive_parents ;		
					end if;
		
					if vs_E157_marital_status_of_adoptive_parents is null			
						or btrim(vs_E157_marital_status_of_adoptive_parents) = '' then 
						Select (case when vl_family_structure = '290' then '1' -- Married couple
									when vl_family_structure in	('291', '292') then '3' -- Legally Separated
									when vl_family_structure in ('293', '294', '295', '296', '288', '289') then '4' -- Single adult
									when vl_family_structure = '298' then '2' -- Unmarried couple
								end )
						into vs_E157_marital_status_of_adoptive_parents;
					end if;
					
					-- 09/25
					/*
					if vs_E157_marital_status_of_adoptive_parents is null
						or btrim(vs_E157_marital_status_of_adoptive_parents) = '' then
						vs_E157_marital_status_of_adoptive_parents := '4'; -- For Compliance Single adult 
					end if;
					*/
				end if;
				
				-- Reset 
				vs_E160_relationship_to_adoptive_parents_non_relative := NULL;
				vs_E158_relationship_to_adoptive_parents_relative := NULL;
				vs_E161_relationship_to_adoptive_parents_foster_parent := NULL;
				vs_E185_assistance_agreement_type := NULL;
				
				select (case when lower(acar.childrelationship) like '%non-relative%' then 
							'1' 
						else 
							'0'
						end) as adop_nonrelative,
						(case when lower(acar.childrelationship) like 'relative%' then 
							'1'
						else 
							'0'
						end) as adop_relative,
						(case when lower(acar.childrelationship) like '%foster%' then 
							'1'
						else 
							'0' 
						end) as adop_foster,
						(case when aca.agreementtyperefid = 'ATIAM' then -- 	Adoption Title IV-E Agreement Medicaid Only
							'4' -- Adoption-Title IV-E agreement Medicaid only
						when aca.agreementtyperefid = 'ATIAN' then -- Adoption Title IV-E Agreement non-recurring expense only
							'3' -- Adoption-Title IV-E agreement non-recurring expenses only
						when aca.agreementtyperefid = 'NOAGR' then -- No Agreement
							'0' --  No agreement
						when aca.agreementtyperefid = 'STAAA' then -- State/Tribal Adoption Assistance Agreement
							'2' -- State/tribal adoption assistance agreement
						when aca.agreementtyperefid = 'ATGAA' then -- State/Tribal Guardianship Assistance Agreement
							'6' -- State/Tribal guardianship assistance agreement 
						when aca.agreementtyperefid = 'TIAAA' then -- Title IV-E Adoption assistance agreement
							'1' -- Title IV-E adoption assistance agreement 
						when aca.agreementtyperefid = 'TIGAA' then -- Title IV-E Guardianship Assistance Agreement					
							'5' -- Title IV-E guardianship assistance agreement					
						end) as E185_assistance_agreement_type
					into vs_E160_relationship_to_adoptive_parents_non_relative,
						vs_E158_relationship_to_adoptive_parents_relative,
						vs_E161_relationship_to_adoptive_parents_foster_parent,
						vs_E185_assistance_agreement_type
				from adoptioncaseagreementrate acar
					join adoptioncaseagreement aca on aca.adoptionagreementid = acar.adoptionagreementid
				where aca.adoptioncaseid::varchar = vl_adop_case_id
					and acar.startdate::date <= vdt_to::date 
				order by acar.startdate desc 
				limit 1;
				
				vs_E159_relationship_to_adoptive_parents_kin := '0'; -- ???
				
				-- Get Mother Details
				
				-- Reset 
				vl_mother_pid := NULL; 
				-- vl_intake_actor_id
				vs_E162_adoptive_parent1_birth_date := NULL;
				vs_E163_adoptive_parent1_tribal_membership := NULL;
				vs_E164_adoptive_parent1_race_american_indian_alaska_native := NULL;
				vs_E165_adoptive_parent1_race_asian := NULL;
				vs_E166_adoptive_parent1_race_black := NULL;
				vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander := NULL;
				vs_E168_adoptive_parent1_race_white := NULL;
				vs_E169_adoptive_parent1_race_unknown := NULL;
				vs_E170_adoptive_parent1_race_declined := NULL;
				vs_E171_adoptive_parent1_hispanic_latino := NULL;
				vs_E172_adoptive_parent1_sex := NULL;
				
				select p.personid, 
					-- ar.intakeservicerequestactorid
					to_char(p.dob, 'YYYYMMDD') as dob,
					(case when upper(p.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					 when upper(p.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					 else
						'9' -- Unknown
					end) as E163_adoptive_parent1_tribal_membership, -- e163 ?? -- Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(p.ethnicgrouptypekey) = 'H' then -- 	Hispanic or Latino
						'1' 
					 when btrim(p.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(p.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(p.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(p.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					 when btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 
					 else
						NULL
					end) as gender
				into vl_mother_pid, 
					-- vl_intake_actor_id
					vs_E162_adoptive_parent1_birth_date,
					vs_E163_adoptive_parent1_tribal_membership,
					vs_E164_adoptive_parent1_race_american_indian_alaska_native,
					vs_E165_adoptive_parent1_race_asian,
					vs_E166_adoptive_parent1_race_black,
					vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander,
					vs_E168_adoptive_parent1_race_white,
					vs_E169_adoptive_parent1_race_unknown,
					vs_E170_adoptive_parent1_race_declined,
					vs_E171_adoptive_parent1_hispanic_latino,
					vs_E172_adoptive_parent1_sex
				from adoptioncaseactor acr
					join person p on p.personid = acr.personid 
						and p.activeflag = 1
						and ( p.gendertypekey = 'F'
							 or 
							 btrim(p.gendertypekey) = 'TGIM' -- Transgender- Identifies as Male
							 or
							 (btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 1 ) -- Assigned Female at Birth *
							)
							
				where acr.actortypekey = 'ADOPTIVEPARENT'
					and acr.activeflag = 1
					and acr.adoptioncaseid::varchar = vl_adop_case_id	
				;	
				/*	
				select ar.person2id, 
					-- ar.intakeservicerequestactorid
					to_char(p2.dob, 'YYYYMMDD') as dob,
					 '9' as E163_adoptive_parent1_tribal_membership, -- e163 ?? -- Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(p2.ethnicgrouptypekey) = 'H' then -- 	Hispanic or Latino
						'1' 
					 when btrim(p2.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(p2.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(p2.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(p2.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					 when btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 
					 else
						NULL
					end) as gender
				into vl_mother_pid, 
					-- vl_intake_actor_id
					vs_E162_adoptive_parent1_birth_date,
					vs_E163_adoptive_parent1_tribal_membership,
					vs_E164_adoptive_parent1_race_american_indian_alaska_native,
					vs_E165_adoptive_parent1_race_asian,
					vs_E166_adoptive_parent1_race_black,
					vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander,
					vs_E168_adoptive_parent1_race_white,
					vs_E169_adoptive_parent1_race_unknown,
					vs_E170_adoptive_parent1_race_declined,
					vs_E171_adoptive_parent1_hispanic_latino,
					vs_E172_adoptive_parent1_sex
				from intakeservicerequestactor ia
					left join actorrelationship ar on ar.intakeservicerequestactorid = ia.intakeservicerequestactorid
					join person p on p.personid = ia.personid 
						and p.cjamspid 
							= (select case when pp.fk_id is not null then 
										pp.fk_id::integer 
									  else 
										pp.cjamspid 
									  end 
							   from person pp 
							   where pp.cjamspid = VL_CLIENT_ID 
							   )
					join person p2 on p2.personid = ar.person2id 
						and ( p2.gendertypekey = 'F'
							 or 
 							 btrim(p2.gendertypekey) = 'TGIM' -- Transgender- Identifies as Male
							 or
							 (btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 1 ) -- Assigned Female at Birth *
							)	
				where ar.relationshiptypekey in ('BGCHLD') 
					and ar.caseid::varchar = VL_SERVICECASEID
				limit 1;
				*/
								  
				-- 09/25
				if vl_mother_pid is not null 
					and ( vs_E157_marital_status_of_adoptive_parents is null
						  or 
						  btrim(vs_E157_marital_status_of_adoptive_parents) = '' 
						) then
					vs_E157_marital_status_of_adoptive_parents := '4'; -- For Compliance Single adult 
				end if;
				
				-- Get Father Details
				
				-- Reset
				vl_father_pid := NULL; 
				-- vl_intake_actor_id
				vs_E173_adoptive_parent2_birth_date := NULL;
				vs_E174_adoptive_parent2_tribal_membership := NULL;
				vs_E175_adoptive_parent2_race_american_indian_alaska_native := NULL; 
				vs_E176_adoptive_parent2_race_asian := NULL; 
				vs_E177_adoptive_parent2_race_black := NULL; 
				vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander := NULL;
				vs_E179_adoptive_parent2_race_white := NULL; 
				vs_E180_adoptive_parent2_race_unknown := NULL; 
				vs_E181_adoptive_parent2_race_declined := NULL; 
				vs_E182_adoptive_parent2_hispanic_latino := NULL; 
				vs_E183_adoptive_parent2_sex := NULL;
				
				select p.personid, 
					-- ar.intakeservicerequestactorid
					to_char(p.dob, 'YYYYMMDD') as dob,
					(case when upper(p.icwaeligibleformembership) = 'YES' then 
						'1' -- Yes 
					 when upper(p.icwaeligibleformembership) = 'NO' then
						'0' -- No 
					 else
						'9' -- Unknown
					end) as E163_adoptive_parent1_tribal_membership, -- e163 ?? -- Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = p.personid
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(p.ethnicgrouptypekey) = 'H' then -- 	Hispanic or Latino
						'1' 
					 when btrim(p.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(p.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(p.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(p.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					 when btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 
					 else
						NULL
					end) as gender
				into vl_father_pid, 
					-- vl_intake_actor_id
					vs_E173_adoptive_parent2_birth_date,
					vs_E174_adoptive_parent2_tribal_membership,
					vs_E175_adoptive_parent2_race_american_indian_alaska_native, 
					vs_E176_adoptive_parent2_race_asian, 
					vs_E177_adoptive_parent2_race_black, 
					vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
					vs_E179_adoptive_parent2_race_white, 
					vs_E180_adoptive_parent2_race_unknown, 
					vs_E181_adoptive_parent2_race_declined, 
					vs_E182_adoptive_parent2_hispanic_latino, 
					vs_E183_adoptive_parent2_sex	
				from adoptioncaseactor acr
					join person p on p.personid = acr.personid 
						and p.activeflag = 1
						and ( p.gendertypekey = 'M'
							  or
							  btrim(p.gendertypekey) = 'TGIF' -- Transgender- Identifies as Female
							  or
							  ( btrim(p.gendertypekey) = 'O' and p.othergendertypekey = 0 ) -- Assigned Male at Birth *
							 )
				where acr.actortypekey = 'ADOPTIVEPARENT'
					and acr.activeflag = 1
					and acr.adoptioncaseid::varchar = vl_adop_case_id	
				;	
				/*
				select ar.person2id, 
					-- ar.intakeservicerequestactorid
					to_char(p2.dob, 'YYYYMMDD') as dob,
					 '9' as E174_adoptive_parent2_tribal_membership, -- e174 ?? -- Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key in ('AI', 'AN' )
					) as "Race – American Indian or Alaska Native", -- AI American Indian/ AN Alaskan Native
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'AS'
					) as "Race – Asian", -- AS Asian
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'BA'
					) as "Race – Black or African American", -- BA Black or African American
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'PI'
					) as "Race – Native Hawaiian or Other Pacific Islander", -- PI Native Hawaiian or Pacific Islander
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'WH'
					) as "Race – White", -- WH White
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'UN'
					) as "Race – Unknown", -- UN Unknown
					(select (case when count(*) > 0 then '1' else '0' end) 
						from personracetypemap prt,
							referencevalues race 
						where race.ref_key = prt.racetypekey
							and prt.personid = ar.person2id
							and prt.activeflag = 1
							and race.referencetypeid = 171
							and race.ref_key = 'DC'
					) as "Race – Declined", -- 0
					(case when btrim(p2.ethnicgrouptypekey) = 'H' then -- 	Hispanic or Latino
						'1' 
					 when btrim(p2.ethnicgrouptypekey) = 'X' then -- Not Hispanic or Latino
						'0'
					 when btrim(p2.ethnicgrouptypekey) = 'D' then  
						'8'
					 else 
						'9' -- Unknown
					 end ) as "Hispanic or Latino Ethnicity",
					 (case when btrim(p2.gendertypekey) in ( 'M', 'TGIF') then 
						'1'
					 when btrim(p2.gendertypekey) in ( 'F', 'TGIM') then 	
						'2'
					 -- Changes for newly added gender type/substype 
					 when btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 0 then -- Assigned Male at Birth *
						'1' -- Male 
					 when btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 1 then -- Assigned Female at Birth *
						'2' -- Female 
					 else
						NULL
					end) as gender
				into vl_father_pid, 
					-- vl_intake_actor_id
					vs_E173_adoptive_parent2_birth_date,
					vs_E174_adoptive_parent2_tribal_membership,
					vs_E175_adoptive_parent2_race_american_indian_alaska_native, 
					vs_E176_adoptive_parent2_race_asian, 
					vs_E177_adoptive_parent2_race_black, 
					vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
					vs_E179_adoptive_parent2_race_white, 
					vs_E180_adoptive_parent2_race_unknown, 
					vs_E181_adoptive_parent2_race_declined, 
					vs_E182_adoptive_parent2_hispanic_latino, 
					vs_E183_adoptive_parent2_sex
				from intakeservicerequestactor ia
					join actorrelationship ar on ar.intakeservicerequestactorid = ia.intakeservicerequestactorid
					join person p on p.personid = ia.personid 
						and p.cjamspid 
							= (select (case when pp.fk_id is not null then 
										 pp.fk_id::integer 
									   else 
										 pp.cjamspid 
									   end) 
							   from person pp 
							   where pp.cjamspid = vl_client_id 
							   limit 1
							   )
					join person p2 on p2.personid = ar.person2id 
						and ( p2.gendertypekey = 'M'
							  or
							  btrim(p2.gendertypekey) = 'TGIF' -- Transgender- Identifies as Female
							  or
							  ( btrim(p2.gendertypekey) = 'O' and p2.othergendertypekey = 0 ) -- Assigned Male at Birth *
							 ) 
				where ar.relationshiptypekey in ('BGCHLD','BGFTHR','DAUALG') 
					and ar.caseid::varchar = vl_servicecaseid
				order by ar.relationshiptypekey asc, 
					ar.insertedon 
				desc limit 1;
				*/
				
				-- Reset 
				vs_E184_inter_intrajurisdictional_adoption := NULL;
				
				select (case when lower(aa.childplacedfrom) = 'wtinst' then '1' 
							when lower(aa.childplacedfrom) = 'anst' then '2' 
							when lower(aa.childplacedfrom) = 'ancn' then '3' 
						end)
					into vs_E184_inter_intrajurisdictional_adoption
				from adoptioncaseagreement aa 
				where aa.adoptioncaseid::varchar = vl_adop_case_id 
				limit 1;
				
				if vs_E184_inter_intrajurisdictional_adoption is null then
					select (case when lower(aa.childplacedfrom) = 'wtinst' then  '1' 
								when lower(aa.childplacedfrom) = 'anst' then '2' 
								when lower(aa.childplacedfrom) = 'ancn' then '3' 
							end)
						into vs_E184_inter_intrajurisdictional_adoption
					from adoptionagreement AA,  
						adoptionplanning AP
					where AA.adoptionplanningid = AP.adoptionplanningid 
						and aa.adoptionplanningid::varchar = vl_adop_plan_id 
					limit 1;
				end if; 
				
				-- Reset 
				vl_provider_id := NULL;
				vu_adoptionagreementid := NULL;
				vs_E186_siblings_in_adoptive_home := NULL;
				
				-- Siblings in Adoptive Home
				select adr.provider_id, 
					adg.adoptionagreementid
					into vl_provider_id,
						vu_adoptionagreementid
				from adoptioncaseagreement adg,
					adoptioncaseagreementrate adr
				where adg.adoptionagreementid = adr.adoptionagreementid 
					and adg.adoptioncaseid::varchar = vl_adop_case_id 
					and adg.activeflag = 1
					and adr.activeflag = 1
					and adr.provider_id is not null
					and btrim(lower(adr.status::text)) = 'approved'::text
				order by adr.startdate desc 
				limit 1;
					
				If vl_provider_id is not null then
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_E186_siblings_in_adoptive_home
					 from adoptioncaseagreement adg,
						adoptioncaseagreementrate adr
					where adg.adoptionagreementid = adr.adoptionagreementid 
						and adg.activeflag = 1
						and adr.activeflag = 1
						and btrim(lower(adr.status::text)) = 'approved'::text
						and adr.provider_id = vl_provider_id
						and adg.adoptionagreementid <> vu_adoptionagreementid 
						and adg.enddate::date > vdt_to::date
						and adg.startdate <= vdt_to::date
					;
				end if;	


				INSERT INTO cjams.afcars_fc_adoptive_parents_info
					(	afcarsfostercareid, 
						recordno, 
						removalid, 
						e157_marital_status_of_adoptive_parents, 
						e158_relationship_to_adoptive_parents_relative, 
						e159_relationship_to_adoptive_parents_kin, 
						e160_relationship_to_adoptive_parents_non_relative, 
						e161_relationship_to_adoptive_parents_foster_parent, 
						e162_adoptive_parent1_birth_date, 
						e163_adoptive_parent1_tribal_membership, 
						e164_adoptive_parent1_race_american_indian_alaska_native, 
						e165_adoptive_parent1_race_asian, 
						e166_adoptive_parent1_race_black, 
						e167_adoptive_parent1_race_native_hawaiian_pacific_islander, 
						e168_adoptive_parent1_race_white, 
						e169_adoptive_parent1_race_unknown, 
						e170_adoptive_parent1_race_declined, 
						e171_adoptive_parent1_hispanic_latino, 
						e172_adoptive_parent1_sex, 
						e173_adoptive_parent2_birth_date, 
						e174_adoptive_parent2_tribal_membership, 
						e175_adoptive_parent2_race_american_indian_alaska_native, 
						e176_adoptive_parent2_race_asian, 
						e177_adoptive_parent2_race_black, 
						e178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
						e179_adoptive_parent2_race_white, 
						e180_adoptive_parent2_race_unknown, 
						e181_adoptive_parent2_race_declined, 
						e182_adoptive_parent2_hispanic_latino, 
						e183_adoptive_parent2_sex, 
						e184_inter_intrajurisdictional_adoption, 
						e185_assistance_agreement_type, 
						e186_siblings_in_adoptive_home, 
						adoption_cjamspid, 
						adoption_casenumber,
						cjamspid, 
						caseid,
						adoption_gap_casetype
					)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_removalid, 
						vs_e157_marital_status_of_adoptive_parents, 
						vs_e158_relationship_to_adoptive_parents_relative, 
						NULL ,-- vs_e159_relationship_to_adoptive_parents_kin, -- e159 ??
						vs_e160_relationship_to_adoptive_parents_non_relative, 
						vs_e161_relationship_to_adoptive_parents_foster_parent, 
						vs_e162_adoptive_parent1_birth_date, 
						'9', -- vs_e163_adoptive_parent1_tribal_membership, --  (Unknown)
						vs_e164_adoptive_parent1_race_american_indian_alaska_native, 
						vs_e165_adoptive_parent1_race_asian, 
						vs_e166_adoptive_parent1_race_black, 
						vs_e167_adoptive_parent1_race_native_hawaiian_pacific_islander, 
						vs_e168_adoptive_parent1_race_white, 
						vs_e169_adoptive_parent1_race_unknown, 
						vs_e170_adoptive_parent1_race_declined, 
						vs_e171_adoptive_parent1_hispanic_latino, 
						vs_e172_adoptive_parent1_sex, 
						vs_e173_adoptive_parent2_birth_date, 
						NULL ,-- vs_e174_adoptive_parent2_tribal_membership, -- e174 ??
						vs_e175_adoptive_parent2_race_american_indian_alaska_native, 
						vs_e176_adoptive_parent2_race_asian, 
						vs_e177_adoptive_parent2_race_black, 
						vs_e178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
						vs_e179_adoptive_parent2_race_white, 
						vs_e180_adoptive_parent2_race_unknown, 
						vs_e181_adoptive_parent2_race_declined, 
						vs_e182_adoptive_parent2_hispanic_latino, 
						vs_e183_adoptive_parent2_sex, 
						vs_e184_inter_intrajurisdictional_adoption, 
						vs_e185_assistance_agreement_type, 
						vs_e186_siblings_in_adoptive_home,
						vl_adoption_client_id,
						vl_adop_casenumber::character varying, 
						vs_client_id, 
						vs_caseid,
						'Adoption'
					);
			end if;
			
			-- Vineet 
			-- RAISE NOTICE 'Guardian Parents Details';
			-- Capture Guardian Parents Details
			if vs_E155_exit_reason = '5' then -- Guardianship
				-- RAISE NOTICE 'vs_client_id >> %',vs_client_id;

				-- Reset 
				vu_gap_id := NULL;
				vl_gap_provider_id := NULL;
				vl_gap_casenumber := NULL;
					
				select a.gapid,
					a.case_id,
					a.provider_id
				into vu_gap_id,
					vl_gap_casenumber,
					vl_gap_provider_id
				from tb_guardian_subsidy a 
				where a.client_id = vs_client_id::bigint
					and a.subsidy_start_dt::date >= vd_exitdate::date 
					and a.subsidy_start_dt::date <= vdt_to::date
					-- and a.subsidy_end_dt is not null
					and a.susbsidy_approval_status_cd = '3047'
					and a.delete_sw = 'N' ;

				IF vl_gap_provider_id is not null THEN

					-- Reset
					vs_E157_marital_status_of_adoptive_parents := NULL;
					vl_family_structure := NULL;
					
					select pr.maritalstatustypekey
						into vs_family_structure_cd
					from intakeservicerequestactor isr,
						person pr
					where isr.personid = pr.personid
						and isr.objectid = vl_gap_provider_id::character varying
						and isr.intakeservicerequestpersontypekey = 'APLCNT' -- Applicant
						and isr.activeflag = 1 ;
							
					Select (case when vl_family_structure = '290' then '1' -- Married couple
								when vl_family_structure in	('291', '292') then '3' -- Legally Separated
								when vl_family_structure in ('293', '294', '295', '296', '288', '289') then '4' -- Single adult
								when vl_family_structure = '298' then '2' -- Unmarried couple
							end )
					into vs_E157_marital_status_of_adoptive_parents;
					
					-- Reset
					vs_E158_relationship_to_adoptive_parents_relative := NULL;
					vs_E159_relationship_to_adoptive_parents_kin := NULL;		
					vs_E160_relationship_to_adoptive_parents_non_relative := NULL;
					vs_E161_relationship_to_adoptive_parents_foster_parent := NULL;
					
					select (case when coalesce(rel.personrelationship, false) = true then 
								'1' -- Applies
							 else
								'0' --Does not apply
							 end), 
						(case when lower(rel.relationshiptypekey) = 'kin' then
							'1' -- Applies
						 else
							'0' --Does not apply
						 end), 
						(case when coalesce(rel.personrelationship, false) = false then 
							'1' -- Applies
						 else
							'0' --Does not apply
						 end), 
						(case when lower(rel.relationshiptypekey) like '%foster%' then 
							'1' -- Applies
						else 
							'0' --Does not apply 
						end)
					into vs_E158_relationship_to_adoptive_parents_relative,
						vs_E159_relationship_to_adoptive_parents_kin,
						vs_E160_relationship_to_adoptive_parents_non_relative,
						vs_E161_relationship_to_adoptive_parents_foster_parent
					from guardianship gap
						left join relationshiptype rel on rel.relationshiptypekey = gap.primaryrelationshipkey
					where gapid = vu_gap_id
						and gap.activeflag = 1 ;
					
					if vs_E158_relationship_to_adoptive_parents_relative is null then
						vs_E158_relationship_to_adoptive_parents_relative := '0'; --Does not apply
					end if;
					
					if vs_E159_relationship_to_adoptive_parents_kin is null then
						vs_E159_relationship_to_adoptive_parents_kin := '0'; --Does not apply
					end if;
					
					if vs_E160_relationship_to_adoptive_parents_non_relative is null then
						vs_E160_relationship_to_adoptive_parents_non_relative := '0'; --Does not apply
					end if;
					
					if vs_E161_relationship_to_adoptive_parents_foster_parent is null then
						vs_E161_relationship_to_adoptive_parents_foster_parent := '0'; --Does not apply
					end if;
						
					vs_E185_assistance_agreement_type := NULL;
					
					select (case when ga.agreementtyperefid = 'ATIAM' then -- 	Adoption Title IV-E Agreement Medicaid Only
								'4' -- Adoption-Title IV-E agreement Medicaid only
							when ga.agreementtyperefid = 'ATIAN' then -- Adoption Title IV-E Agreement non-recurring expense only
								'3' -- Adoption-Title IV-E agreement non-recurring expenses only
							when ga.agreementtyperefid = 'NOAGR' then -- No Agreement
								'0' --  No agreement
							when ga.agreementtyperefid = 'STAAA' then -- State/Tribal Adoption Assistance Agreement
								'2' -- State/tribal adoption assistance agreement
							when ga.agreementtyperefid = 'ATGAA' then -- State/Tribal Guardianship Assistance Agreement
								'6' -- State/Tribal guardianship assistance agreement 
							when ga.agreementtyperefid = 'TIAAA' then -- Title IV-E Adoption assistance agreement
								'1' -- Title IV-E adoption assistance agreement 
							when ga.agreementtyperefid = 'TIGAA' then -- Title IV-E Guardianship Assistance Agreement					
								'5' -- Title IV-E guardianship assistance agreement					
							end) 
					into vs_E185_assistance_agreement_type		
					from gapagreement ga
					where gapid = vu_gap_id
						and activeflag = 1 ;

					if vs_E185_assistance_agreement_type is null then 
						vs_E185_assistance_agreement_type := '0'; --  No agreement
					end if;
					
					-- Provider Parents Info
					vs_E162_adoptive_parent1_birth_date := NULL;
					vs_E163_adoptive_parent1_tribal_membership := NULL;
					vs_E164_adoptive_parent1_race_american_indian_alaska_native := NULL;
					vs_E165_adoptive_parent1_race_asian := NULL;
					vs_E166_adoptive_parent1_race_black := NULL;
					vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander := NULL;
					vs_E168_adoptive_parent1_race_white := NULL;
					vs_E169_adoptive_parent1_race_unknown := NULL;
					vs_E170_adoptive_parent1_race_declined := NULL;
					vs_E171_adoptive_parent1_hispanic_latino := NULL;
					vs_E172_adoptive_parent1_sex := NULL;
							
					-- Reset
					vs_E173_adoptive_parent2_birth_date := NULL;
					vs_E174_adoptive_parent2_tribal_membership := NULL;
					vs_E175_adoptive_parent2_race_american_indian_alaska_native := NULL; 
					vs_E176_adoptive_parent2_race_asian := NULL; 
					vs_E177_adoptive_parent2_race_black := NULL; 
					vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander := NULL;
					vs_E179_adoptive_parent2_race_white := NULL; 
					vs_E180_adoptive_parent2_race_unknown := NULL; 
					vs_E181_adoptive_parent2_race_declined := NULL; 
					vs_E182_adoptive_parent2_hispanic_latino := NULL; 
					vs_E183_adoptive_parent2_sex := NULL;	
					
					-- Get Provider Home Approval 
					vl_provider_approval_id := NULL;
					
					select provider_approval_id
						into vl_provider_approval_id
					from prov.tb_provider_approval 
					where provider_id = vl_gap_provider_id
						and delete_sw = 'N'
					order by provider_approval_id desc 
					limit 1;

					if vl_provider_approval_id is not null then
						select marital_status_cd,
							family_structure_cd, 
							-- date_part('year', dob_dt::date)::varchar as dob_year,
							to_char(dob_dt, 'YYYYMMDD') as dob,
							'9' as E163_adoptive_parent1_tribal_membership, -- e163 ?? -- Unknown
							(case when btrim(primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
								'1'
							else
								'0'
							end) as	E127_foster_parent1_race_american_indian_alaska_native,
							(case when btrim(primary_race_cd) in ('6310', '6346' ) then -- Asian
								'1'
							else
								'0'
							end) as	E128_foster_parent1_race_asian,
							(case when btrim(primary_race_cd) = '1801' then -- Black/African-American
								'1'
							else
								'0'
							end) as	E129_foster_parent1_race_black,
							(case when btrim(primary_race_cd) in ('6311', '6347', '1804') then 
								-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
								'1'
							else
								'0'
							end) as	E130_foster_parent1_race_native_hawaiian_pacific_islander,
							(case when btrim(primary_race_cd) = '1806' then -- White/Caucasian 
								'1'
							else
								'0'
							end) as	E131_foster_parent1_race_white, 
							(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
								'1'
							else
								'0'
							end) as	E132_foster_parent1_race_unknown, 
							(case when btrim(primary_race_cd) = '6314' then -- Declined
								'1'
							else
								'0'
							end) as	E133_foster_parent1_race_declined, 
							(case when hispanic_cd = 'Y' then 
								'1'  -- Yes
							when hispanic_cd = 'N' then 
								'0' -- No
							when hispanic_cd = 'U' then 
								'9' -- Unknown
							else 
								NULL
							end) as hispanic_cd,
							(case when btrim(gender_cd) = '1282' then -- Male
								'1'
							 when btrim(gender_cd) = '1281' then -- Female
								'2'
							 else
								Null
							end) gender_cd
						into vs_marital_status_cd,
							vs_family_structure_cd,
							vs_E162_adoptive_parent1_birth_date,
							vs_E163_adoptive_parent1_tribal_membership,
							vs_E164_adoptive_parent1_race_american_indian_alaska_native,
							vs_E165_adoptive_parent1_race_asian,
							vs_E166_adoptive_parent1_race_black,
							vs_E167_adoptive_parent1_race_native_hawaiian_pacific_islander,
							vs_E168_adoptive_parent1_race_white,
							vs_E169_adoptive_parent1_race_unknown,
							vs_E170_adoptive_parent1_race_declined,
							vs_E171_adoptive_parent1_hispanic_latino,
							vs_E172_adoptive_parent1_sex
						from prov.tb_prov_approval_person
						where provider_approval_id = vl_provider_approval_id
							and delete_sw = 'N' 
							and btrim(person_type_cd) = '3610' -- Applicant
						order by approval_person_id desc
						limit 1;

						if vs_E157_marital_status_of_adoptive_parents is null then


							If vs_marital_status_cd is not null then 
								select (case when btrim(vs_marital_status_cd) in ('MR', '290', '1569') then 
											'1' -- Married Couple
										when btrim(vs_marital_status_cd) in ('294', '296', '298', '299', '1572') then 
											'2' -- Unmarried Couple
										when btrim(vs_marital_status_cd) in ('288', '289', '291', '292', 'DV', 'LS', '1570') then 
											'3' -- Separated
										when btrim(vs_marital_status_cd) in ('293', '295', '297', 'SG', 'WD', 'UK', '1568', '1571', '3673', '3674' ) then
											'4' -- Single adult 
										end )
								into vs_E123_marital_status_of_foster_parents ;		
							end if;
							
							if vs_E123_marital_status_of_foster_parents is null
								or btrim(vs_E123_marital_status_of_foster_parents) = '' then 
								select (case when vs_family_structure_cd in ('MR', '290') then -- 	Married Couple
											'1' -- Married couple
										when vs_family_structure_cd in ('294', '296', '298', '299') then
											'2' -- Unmarried couple
										when vs_family_structure_cd in ('288', '289', '291', '292', 'DV', 'LS') then 	
											'3' -- Separated
										when vs_family_structure_cd in ('293', '295', '297', 'SG', 'WD', 'UK') then	
											'4' -- Single adult 
										else
											'4' -- For Compliance Single adult 
										end )
									into vs_E123_marital_status_of_foster_parents ;
							end if;
							
							if vs_E123_marital_status_of_foster_parents is null
								or btrim(vs_E123_marital_status_of_foster_parents) = '' then
								vs_E123_marital_status_of_foster_parents := '4'; -- For Compliance Single adult 
							end if;
						end if;		
						
						-- Co-Applicant 
						select -- date_part('year', dob_dt::date)::varchar as dob_year,
							to_char(dob_dt, 'YYYYMMDD') as dob,
							'9' as E163_adoptive_parent1_tribal_membership, -- e163 ?? -- Unknown
							(case when btrim(primary_race_cd) in ('1802', '1803' ) then -- Alaskan Native / American Indian
								'1'
							else
								'0'
							end) as	E127_foster_parent1_race_american_indian_alaska_native,
							(case when btrim(primary_race_cd) in ('6310', '6346' ) then -- Asian
								'1'
							else
								'0'
							end) as	E128_foster_parent1_race_asian,
							(case when btrim(primary_race_cd) = '1801' then -- Black/African-American
								'1'
							else
								'0'
							end) as	E129_foster_parent1_race_black,
							(case when btrim(primary_race_cd) in ('6311', '6347', '1804') then 
								-- Native Hawaiian/Pacific Islander / Native Hawaiin/Pacific Islander /  Asian-Pacific Islander
								'1'
							else
								'0'
							end) as	E130_foster_parent1_race_native_hawaiian_pacific_islander,
							(case when btrim(primary_race_cd) = '1806' then -- White/Caucasian 
								'1'
							else
								'0'
							end) as	E131_foster_parent1_race_white, 
							(case when btrim(primary_race_cd) in ('6312', '6349') then -- Unknown / Unable To Determine
								'1'
							else
								'0'
							end) as	E132_foster_parent1_race_unknown, 
							(case when btrim(primary_race_cd) = '6314' then -- Declined
								'1'
							else
								'0'
							end) as	E133_foster_parent1_race_declined, 
							(case when hispanic_cd = 'Y' then 
								'1'  -- Yes
							when hispanic_cd = 'N' then 
								'0' -- No
							when hispanic_cd = 'U' then 
								'9' -- Unknown
							else 
								NULL
							end) as hispanic_cd,
							(case when btrim(gender_cd) = '1282' then -- Male
								'1'
							 when btrim(gender_cd) = '1281' then -- Female
								'2'
							 else
								Null
							end) gender_cd
						into vs_E173_adoptive_parent2_birth_date,
							vs_E174_adoptive_parent2_tribal_membership,
							vs_E175_adoptive_parent2_race_american_indian_alaska_native, 
							vs_E176_adoptive_parent2_race_asian, 
							vs_E177_adoptive_parent2_race_black, 
							vs_E178_adoptive_parent2_race_native_hawaiian_pacific_islander,
							vs_E179_adoptive_parent2_race_white, 
							vs_E180_adoptive_parent2_race_unknown, 
							vs_E181_adoptive_parent2_race_declined, 
							vs_E182_adoptive_parent2_hispanic_latino, 
							vs_E183_adoptive_parent2_sex	
						from prov.tb_prov_approval_person
						where provider_approval_id = vl_provider_approval_id
							and delete_sw = 'N' 
							and btrim(person_type_cd) = '3611' -- Co-Applicant
						order by approval_person_id desc
						limit 1;
					end if;

					-- Reset 
					vs_E184_inter_intrajurisdictional_adoption := NULL;	-- ???
					
					vs_E186_siblings_in_adoptive_home := NULL;
					
					select (case when count(*) > 0 then '1' else '0' end)
						into vs_E186_siblings_in_adoptive_home		
					from tb_guardian_subsidy a
					where client_id in 
						   ( select pr.cjamspid 
								 from actorrelationship acr,
									person pr
							  where acr.person1id = pr.personid
								and acr.person2id = vu_personid 
								and relationshiptypekey in ('BGSISTR','BIOBR')
							)
						and a.provider_id = vl_gap_provider_id
						and a.subsidy_end_dt > vdt_to::date
						and a.subsidy_start_dt <= vdt_to::date
						and a.susbsidy_approval_status_cd = '3047'
						and a.delete_sw = 'N' ;
						
					if vs_E186_siblings_in_adoptive_home is null then 
						vs_E186_siblings_in_adoptive_home := '0';
					end if;	
					
					INSERT INTO cjams.afcars_fc_adoptive_parents_info
						(	afcarsfostercareid, 
							recordno, 
							removalid, 
							e157_marital_status_of_adoptive_parents, 
							e158_relationship_to_adoptive_parents_relative, 
							e159_relationship_to_adoptive_parents_kin, 
							e160_relationship_to_adoptive_parents_non_relative, 
							e161_relationship_to_adoptive_parents_foster_parent, 
							e162_adoptive_parent1_birth_date, 
							e163_adoptive_parent1_tribal_membership, 
							e164_adoptive_parent1_race_american_indian_alaska_native, 
							e165_adoptive_parent1_race_asian, 
							e166_adoptive_parent1_race_black, 
							e167_adoptive_parent1_race_native_hawaiian_pacific_islander, 
							e168_adoptive_parent1_race_white, 
							e169_adoptive_parent1_race_unknown, 
							e170_adoptive_parent1_race_declined, 
							e171_adoptive_parent1_hispanic_latino, 
							e172_adoptive_parent1_sex, 
							e173_adoptive_parent2_birth_date, 
							e174_adoptive_parent2_tribal_membership, 
							e175_adoptive_parent2_race_american_indian_alaska_native, 
							e176_adoptive_parent2_race_asian, 
							e177_adoptive_parent2_race_black, 
							e178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
							e179_adoptive_parent2_race_white, 
							e180_adoptive_parent2_race_unknown, 
							e181_adoptive_parent2_race_declined, 
							e182_adoptive_parent2_hispanic_latino, 
							e183_adoptive_parent2_sex, 
							e184_inter_intrajurisdictional_adoption, 
							e185_assistance_agreement_type, 
							e186_siblings_in_adoptive_home, 
							adoption_cjamspid, 
							adoption_casenumber,
							cjamspid, 
							caseid,
							adoption_gap_casetype
						)
					VALUES
						(	vs_afcarsfostercareid, 
							vs_recordno, 
							vs_removalid, 
							vs_e157_marital_status_of_adoptive_parents, 
							vs_e158_relationship_to_adoptive_parents_relative, 
							NULL ,-- vs_e159_relationship_to_adoptive_parents_kin, -- e159 ??
							vs_e160_relationship_to_adoptive_parents_non_relative, 
							vs_e161_relationship_to_adoptive_parents_foster_parent, 
							vs_e162_adoptive_parent1_birth_date, 
							'9', -- vs_e163_adoptive_parent1_tribal_membership, --  (Unknown)
							vs_e164_adoptive_parent1_race_american_indian_alaska_native, 
							vs_e165_adoptive_parent1_race_asian, 
							vs_e166_adoptive_parent1_race_black, 
							vs_e167_adoptive_parent1_race_native_hawaiian_pacific_islander, 
							vs_e168_adoptive_parent1_race_white, 
							vs_e169_adoptive_parent1_race_unknown, 
							vs_e170_adoptive_parent1_race_declined, 
							vs_e171_adoptive_parent1_hispanic_latino, 
							vs_e172_adoptive_parent1_sex, 
							vs_e173_adoptive_parent2_birth_date, 
							NULL ,-- vs_e174_adoptive_parent2_tribal_membership, -- e174 ??
							vs_e175_adoptive_parent2_race_american_indian_alaska_native, 
							vs_e176_adoptive_parent2_race_asian, 
							vs_e177_adoptive_parent2_race_black, 
							vs_e178_adoptive_parent2_race_native_hawaiian_pacific_islander, 
							vs_e179_adoptive_parent2_race_white, 
							vs_e180_adoptive_parent2_race_unknown, 
							vs_e181_adoptive_parent2_race_declined, 
							vs_e182_adoptive_parent2_hispanic_latino, 
							vs_e183_adoptive_parent2_sex, 
							vs_e184_inter_intrajurisdictional_adoption, 
							vs_e185_assistance_agreement_type, 
							vs_e186_siblings_in_adoptive_home,
							NULL,
							vl_gap_casenumber::character varying, 
							vs_client_id, 
							vs_caseid,
							'GAP'
						);
				END IF;
			end if;	
			-- Vineet
			
			-- RAISE NOTICE 'Capture Permanency Hearings Details';
			-- Capture Permanency Hearings Details
			OPEN cur_permanency_hearing_REFCURSOR FOR
				select isrch.intakeservicerequestcourthearingid,
					isrco.courtorderdate::date as E150_permanency_hearing_date 
				from intakeservreqcourtorder isrco 
					join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid 
						and isrcr.activeflag = 1 
					join intakeservicerequestcourthearing isrch 
						on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid 
						and isrch.activeflag = 1
					join intakeservicerequestactor isra 
						on isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
					join intakeservreqcourtorderdetails iscod 
						on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
							and iscod.activeflag = 1
							and iscod.isselected = 1
				where isrco.activeflag = 1
					and isrco.servicecaseid = vu_servicecaseid
					and iscod.checklisttypekey = 'COLANG' 
					-- and iscod.checklistid = '37d62658-129a-4a25-b4b2-2c63424392df' -- Permanency plan
					-- Finalize permanency plan	
					-- Reasonable efforts were made to finalize the child's permanency plan
					and iscod.checklistid = '34993888-d849-4774-a5c0-6aa25a2b9a42'
					and isrco.courtorderdate::date between vd_removaldate::date and coalesce(vd_exitdate, vdt_to::date)::date
					and isrcr.removalid::bigint = vs_removalid::bigint
					and isra.personid = vu_personid 
				order by isrco.courtorderdate ;
			LOOP
				fetch cur_permanency_hearing_REFCURSOR into cur_permanency_hearing;
				exit when not found;
			
				-- Reset
				vu_intakeservicerequestcourthearingid := NULL;
				vs_E150_permanency_hearing_date := NULL;
				
				vu_intakeservicerequestcourthearingid := cur_permanency_hearing.intakeservicerequestcourthearingid ;
				vs_E150_permanency_hearing_date := cur_permanency_hearing.E150_permanency_hearing_date; 
				
				INSERT INTO cjams.afcars_fc_permanency_hearings
					(	afcarsfostercareid, 
						recordno, 
						removalid, 
						e150_permanency_hearing_date, 
						intakeservicerequestcourthearingid, 
						cjamspid, 
						caseid
					)
				VALUES
					(	vs_afcarsfostercareid, 
						vs_recordno, 
						vs_removalid, 
						vs_E150_permanency_hearing_date, 
						vu_intakeservicerequestcourthearingid, 
						vs_client_id, 
						vs_caseid
					);
			END LOOP;	
			close cur_permanency_hearing_REFCURSOR;	
		End if ;
		-- Capture Details for Current Period Removals only - End
		
		-- RAISE NOTICE 'Sex Trafficking Details';
		-- Capture Sex Trafficking Details
		-- Reset 
		vs_E106_prior_victim_sex_trafficking := NULL;
		vs_E107_prior_victim_sex_trafficking_reported := NULL;
		vs_E108_prior_victim_sex_trafficking_reported_date := NULL;
		vs_E109_victim_sex_trafficking := NULL;
		vs_E110_victim_sex_trafficking_reported := NULL;
		vs_E111_victim_sex_trafficking_reported_date := NULL;
		
		
		select -- Does The Child Have A History Of Being Victim Of Sex Trafficking (Before The Current Removal, If Applicable)?
			(case when ischildhassextraffichistory = true then '1' else '0' end) as E106_prior_victim_sex_trafficking,
			-- Was It Reported To Law Enforcement?
			(case when ischildhassextraffichistory = true then
				(case when issextraffichistoryreported = true then '1' else '0' end)
			else 
				NULL 
			end) as E107_prior_victim_sex_trafficking_reported,
			-- Reported Date
			(case when ischildhassextraffichistory = true then
				(case when issextraffichistoryreported = true then 
					sextraffichistoryreportedon 
				else 
					NULL 
				end)
			else
				NULL
			end) as E108_prior_victim_sex_trafficking_reported_date,
			-- Is The Child CURRENTLY A Victim Of Sex Trafficking (During The Current Removal, If Applicable)?
			(case when ischildhassextraffic = true then '1' else '0' end) as E109_victim_sex_trafficking,
			-- Was It Reported To Law Enforcement?
			(case when ischildhassextraffic = true then 
				(case when issextrafficreported = true then '1' else '0' end) 
			else 
				NULL 
			end)as E110_victim_sex_trafficking_reported,
			-- Reported Date
			(case when ischildhassextraffic = true then 
				(case when issextrafficreported = true then 
					sextrafficreportedon 
				else 
					NULL 
				end) 
			else 
				NULL 
			end) as E111_victim_sex_trafficking_reported_date
		into vs_E106_prior_victim_sex_trafficking,
			vs_E107_prior_victim_sex_trafficking_reported,
			vs_E108_prior_victim_sex_trafficking_reported_date,
			vs_E109_victim_sex_trafficking,
			vs_E110_victim_sex_trafficking_reported,
			vs_E111_victim_sex_trafficking_reported_date	
		from personabusesubstance
		where personid = vu_personid
			and activeflag = 1
		order by insertedon desc
		limit 1 ;

		IF vs_E106_prior_victim_sex_trafficking is null THEN
			vs_E106_prior_victim_sex_trafficking := '0'; -- FOr Compliance
		END IF;
		
		IF vs_E109_victim_sex_trafficking is null THEN
			vs_E109_victim_sex_trafficking := '0'; -- FOr Compliance
		END IF;
		
		/*
		-- 04/14	
		If vs_e99_sex_trafficking = '1' then 
			vs_E109_victim_sex_trafficking := '1' ;
		else	
			vs_E109_victim_sex_trafficking := '0' ;
		end if;
		
		select (case when count(*) > 0 then '1' else '0' end)
			into vs_E106_prior_victim_sex_trafficking
		from cjams.afcars_fc_child_removals
		where cjamspid = vs_client_id
			and E99_sex_trafficking = '1'
			and removalid <> vs_removalid 
			and E69_removal_date::date < vd_removaldate::date ;
		*/
		
		INSERT INTO cjams.afcars_fc_sex_trafficking
			(	afcarsfostercareid, 
				recordno, 
				removalid, 
				e106_prior_victim_sex_trafficking, 
				e107_prior_victim_sex_trafficking_reported, 
				e108_prior_victim_sex_trafficking_reported_date, 
				e109_victim_sex_trafficking, 
				e110_victim_sex_trafficking_reported,
				e111_victim_sex_trafficking_reported_date,
				cjamspid, 
				caseid	
			)
		VALUES
			(	vs_afcarsfostercareid, 
				vs_recordno, 
				vs_removalid, 
				vs_E106_prior_victim_sex_trafficking, 
				NULL ,-- vs_E107_prior_victim_sex_trafficking_reported, -- e107 ??
				NULL ,-- vs_E108_prior_victim_sex_trafficking_reported_date, -- e108 ??
				vs_E109_victim_sex_trafficking,
				NULL ,-- vs_E110_victim_sex_trafficking_reported, -- e110 ??
				NULL ,-- vs_E111_victim_sex_trafficking_reported_date, -- e111 ??
				vs_client_id, 
				vs_caseid
			);
		
	END LOOP;	
	close cur_child_removal_REFCURSOR;
	
	-- B-214951 - CIDM-10253 - Acceptance Criteria 2
	-- 1) For all qualifying placements, if the placement start date < child removal date
	-- update placement start date as child removal date
		
	update cjams.afcars_fc_placements pl
		set e112_date_living_arrangement = e69_removal_date
	from cjams.afcars_fc_child_removals rm 
	where pl.removalid = rm.removalid 
		and pl.e112_date_living_arrangement::date < rm.e69_removal_date::date  
		and pl.placementsubtype 
		not in 
			(	'FSMPH', -- Father and Step Mother/Paramour Home 
				'FH', -- Father's Home
				'MOFH', -- Mother and Father's Home
				'MOSFPH', -- Mother and Step Father/Paramour Home
				'MOH', -- Mother's Home
				'TVH', -- Trial Visit Home
				'73', -- After care room and board
				'BP', -- Biological Parent
				-- # 2
				'ERM', -- ER Medical
				'IMC', -- Inpatient Medical Care
				'IMCNA', -- Inpatient Medical Care Non-Acute
				'MH', -- Medical Hospital
				'ERP', -- ER Psychiatric 
				'PSYH', -- Inpatient Psychiatric Hospital
				'IPC', -- Inpatient Psychiatric Care
				'ACI', -- Adult Correctional Institution
				'DJS', -- DJS Funded Facility/not detention
				'SJD' -- Secure Juvenile Detention	
			) ;
		
		
	-- 2) Fix the remaining 
	
	delete from ttb_removal_placement_date_fix ;
	
	-- Fix Gap between Removal date and the first placement date 
	-- Removal date is after first placement date 
	OPEN cur_removal_placement_data_REFCURSOR FOR
		select *
		from (
			select 
				(case when tab.first_qualifying_placement_date::date = tab.first_placement_date::date 
						and tab.e69_removal_date::date <> tab.first_placement_date::date then
						-- Update Placement Date with Child Removal Date
						'Update_Placement_Date'
					when tab.first_qualifying_placement_date::date < tab.e69_removal_date::date then
						-- Update Placement Date with Child Removal Date	
						'Update_Placement_Date'
					when tab.first_qualifying_placement_date::date > tab.e69_removal_date::date 
						-- and tab.first_qualifying_placement_date::date > tab.first_placement_date::date 
						then 
						-- Update Child Removal with Placement Date Date
						'Update_Child_Removal_Date'
					when tab.first_qualifying_placement_date::date = tab.e69_removal_date::date then
						-- Child Removal Date and Qualifying Placement Date are the same - Do Nothing
						'Do_Nothing'
					when tab.first_qualifying_placement_date is null then 
						-- No Qualifying Placement Found
						'No_Qualifying_Placement_Found'
					else
						'??'
				end) as fix_type
				,*
		from (
			select rm.removalid,
				rm.cjamspid,
				rm.caseid,
				rm.e69_removal_date,
				(select pl.e112_date_living_arrangement
					from cjams.afcars_fc_placements pl
				 where pl.removalid = rm.removalid
					and pl.placementsubtype 
					not in 
						(	'FSMPH', -- Father and Step Mother/Paramour Home 
							'FH', -- Father's Home
							'MOFH', -- Mother and Father's Home
							'MOSFPH', -- Mother and Step Father/Paramour Home
							'MOH', -- Mother's Home
							'TVH', -- Trial Visit Home
							'73', -- After care room and board
							'BP', -- Biological Parent
							-- # 2
							'ERM', -- ER Medical
							'IMC', -- Inpatient Medical Care
							'IMCNA', -- Inpatient Medical Care Non-Acute
							'MH', -- Medical Hospital
							'ERP', -- ER Psychiatric 
							'PSYH', -- Inpatient Psychiatric Hospital
							'IPC', -- Inpatient Psychiatric Care
							'ACI', -- Adult Correctional Institution
							'DJS', -- DJS Funded Facility/not detention
							'SJD' -- Secure Juvenile Detention	
						)
				 order by pl.e112_date_living_arrangement::date
				 limit 1 
				 ) as first_qualifying_placement_date,
				 (select pl.e112_date_living_arrangement
					from cjams.afcars_fc_placements pl
				 where pl.removalid = rm.removalid
				 order by pl.e112_date_living_arrangement::date
				 limit 1 
				 ) as first_placement_date,
				(select pl.placementid
					from cjams.afcars_fc_placements pl
				 where pl.removalid = rm.removalid
					and pl.placementsubtype 
					not in 
						(	'FSMPH', -- Father and Step Mother/Paramour Home 
							'FH', -- Father's Home
							'MOFH', -- Mother and Father's Home
							'MOSFPH', -- Mother and Step Father/Paramour Home
							'MOH', -- Mother's Home
							'TVH', -- Trial Visit Home
							'73', -- After care room and board
							'BP', -- Biological Parent
							-- # 2
							'ERM', -- ER Medical
							'IMC', -- Inpatient Medical Care
							'IMCNA', -- Inpatient Medical Care Non-Acute
							'MH', -- Medical Hospital
							'ERP', -- ER Psychiatric 
							'PSYH', -- Inpatient Psychiatric Hospital
							'IPC', -- Inpatient Psychiatric Care
							'ACI', -- Adult Correctional Institution
							'DJS', -- DJS Funded Facility/not detention
							'SJD' -- Secure Juvenile Detention	
						)
				 order by pl.e112_date_living_arrangement::date
				 limit 1 
				) as first_qalifying_placement_id,
				(select pl.placementcpahomeid
					from cjams.afcars_fc_placements pl
				 where pl.removalid = rm.removalid
					and pl.placementsubtype 
					not in 
						(	'FSMPH', -- Father and Step Mother/Paramour Home 
							'FH', -- Father's Home
							'MOFH', -- Mother and Father's Home
							'MOSFPH', -- Mother and Step Father/Paramour Home
							'MOH', -- Mother's Home
							'TVH', -- Trial Visit Home
							'73', -- After care room and board
							'BP', -- Biological Parent
							-- # 2
							'ERM', -- ER Medical
							'IMC', -- Inpatient Medical Care
							'IMCNA', -- Inpatient Medical Care Non-Acute
							'MH', -- Medical Hospital
							'ERP', -- ER Psychiatric 
							'PSYH', -- Inpatient Psychiatric Hospital
							'IPC', -- Inpatient Psychiatric Care
							'ACI', -- Adult Correctional Institution
							'DJS', -- DJS Funded Facility/not detention
							'SJD' -- Secure Juvenile Detention	
						)
				 order by pl.e112_date_living_arrangement::date
				 limit 1 
				) as first_qalifying_placementcpahomeid	 
			from cjams.afcars_fc_child_removals rm
			where rm.current_period_removal_sw = 'Y'
			) tab
		) tb_main
		-- where tb_main.fix_type not in ('Do_Nothing', 'No_Qualifying_Placement_Found', '??')
		where tb_main.fix_type <> 'Do_Nothing'
		order by tb_main.cjamspid,
			tb_main.removalid ;
	LOOP
		fetch cur_removal_placement_data_REFCURSOR into cur_removal_placement_data;
		exit when not found;

		-- Reset
		vs_removalid := NULL;
		vs_fix_type := NULL;
		vs_e69_removal_date := NULL;
		vs_first_placementcpahomeid := NULL;
		vs_first_placementid := NULL;
		
		vs_removalid := cur_removal_placement_data.removalid;
		vs_fix_type := cur_removal_placement_data.fix_type;
		vs_e69_removal_date := cur_removal_placement_data.e69_removal_date;
		vs_first_qualifying_placement_date := cur_removal_placement_data.first_qualifying_placement_date;
		vs_first_placementcpahomeid := cur_removal_placement_data.first_qalifying_placementcpahomeid; 
		vs_first_placementid := cur_removal_placement_data.first_qalifying_placement_id; 
						
		Insert into ttb_removal_placement_date_fix 
			(   removalid,
				fix_type,
				e69_removal_date,
				first_qualifying_placement_date, 
				first_placementcpahomeid, 
				first_placementid 
			)
		values
			( 	vs_removalid,
				vs_fix_type,
				vs_e69_removal_date,
				vs_first_qualifying_placement_date,
				vs_first_placementcpahomeid,
				vs_first_placementid							
			)
		;
	END LOOP;	
	close cur_removal_placement_data_REFCURSOR;

	OPEN cur_removal_placement_date_fix_REFCURSOR FOR
		select removalid,
			fix_type,
			e69_removal_date,
			first_qualifying_placement_date, 
			first_placementcpahomeid, 
			first_placementid 
		from ttb_removal_placement_date_fix; 
	LOOP
		fetch cur_removal_placement_date_fix_REFCURSOR into cur_removal_placement_date_fix;
		exit when not found;
		
		-- Reset
		vs_removalid := NULL;
		vs_fix_type := NULL;
		vs_e69_removal_date := NULL;
		vs_first_qualifying_placement_date := NULL;
		vs_first_placementcpahomeid := NULL;
		vs_first_placementid := NULL;
		
		vs_removalid := cur_removal_placement_date_fix.removalid;
		vs_fix_type := cur_removal_placement_date_fix.fix_type;
		vs_e69_removal_date := cur_removal_placement_date_fix.e69_removal_date;
		vs_first_qualifying_placement_date := cur_removal_placement_date_fix.first_qualifying_placement_date;
		vs_first_placementcpahomeid := cur_removal_placement_date_fix.first_placementcpahomeid; 
		vs_first_placementid := cur_removal_placement_date_fix.first_placementid; 
						
		If vs_fix_type = 'Update_Placement_Date' then 
			If vs_first_placementcpahomeid is not null then 
				update cjams.afcars_fc_placements 
					set e112_date_living_arrangement = vs_e69_removal_date
				where placementcpahomeid = vs_first_placementcpahomeid::uuid
					and removalid = vs_removalid ;
			else
				update cjams.afcars_fc_placements 
					set e112_date_living_arrangement = vs_e69_removal_date
				where placementid = vs_first_placementid
					and removalid = vs_removalid ;
			end if;
		elseif vs_fix_type = 'Update_Child_Removal_Date' then 
			update cjams.afcars_fc_child_removals
				set e69_removal_date = vs_first_qualifying_placement_date,
					e70_removal_transaction_date = vs_first_qualifying_placement_date
			where removalid	= vs_removalid ;
		elseif vs_fix_type = 'No_Qualifying_Placement_Found' then
			-- Delete all Placements (No need to report on AFCARS)
			update cjams.afcars_fc_placements
				set removalid = null
			where removalid	= vs_removalid ;	
		else
			RAISE NOTICE 'vs_removalid NO Fix ?? >> %',vs_removalid ;	
			RAISE NOTICE 'vs_fix_type ?? >> %',vs_fix_type ;	
		end if;	
	END LOOP;	
	close cur_removal_placement_date_fix_REFCURSOR;
	
	-- Delete all non-qualifying placements prior to Child Removal Date 
	update cjams.afcars_fc_placements
		set removalid = null
	where placementid 
	in ( select pl.placementid
		from cjams.afcars_fc_placements pl,
			cjams.afcars_fc_child_removals rm
		where pl.removalid = rm.removalid 	
			and pl.e112_date_living_arrangement::date < e69_removal_date::date  
		) ;	
	
	-- Delete all non-qualifying periodic reviews prior to Child Removal Date 
	update cjams.afcars_fc_periodic_reviews rw
		set removalid = null
	from afcars_fc_child_removals rm 
	where rw.removalid = rm.removalid 
		and rw.e149_periodic_review_date::date < rm.e69_removal_date::date 
	;	
		
	-- Delete all non-qualifying permanency plans prior to Child Removal Date 
	update afcars_fc_permanency_plans pp
		set removalid = null
	from afcars_fc_child_removals rm 
	where pp.removalid = rm.removalid 
		and pp.e147_permanency_plan_date::date < rm.e69_removal_date::date 
	;
	
	-- Delete all non-qualifying caseworker visits prior to Child Removal Date 
	update afcars_fc_caseworker_visits cv
		set removalid = null
	from afcars_fc_child_removals rm 
	where cv.removalid = rm.removalid 
		and cv.e151_case_worker_visit_date::date < rm.e69_removal_date::date 
	;	
	
	-- Delete all non-qualifying permanency hearings prior to Child Removal Date 
	update afcars_fc_permanency_hearings ph
		set removalid = null
	from afcars_fc_child_removals rm 
	where ph.removalid = rm.removalid 
		and ph.e150_permanency_hearing_date::date < rm.e69_removal_date::date 
	;	
	
	DROP TABLE IF EXISTS ttb_removal_placement_date_fix;	
	
	DROP TABLE IF EXISTS ttb_bio_client_removal;
	
END;

$function$
;

