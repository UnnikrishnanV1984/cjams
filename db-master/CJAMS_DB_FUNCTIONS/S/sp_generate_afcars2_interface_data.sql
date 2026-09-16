-- DROP FUNCTION IF EXISTS cjams.sp_generate_afcars2_interface_data( character varying, character varying) ;
DROP FUNCTION IF EXISTS cjams.sp_generate_afcars2_interface_data( character varying, character varying, bigint, bigint) ;
																	
CREATE OR REPLACE FUNCTION cjams.sp_generate_afcars2_interface_data( vs_report_type character varying, 
																	 vs_reporting_period character varying,
																	 v_lipagesize bigint, 
																	 v_lipagenumber bigint
																	)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Auhor: Vineet Tirodkar
-- Date : 03/15/2023
-- Description: 
-- CJAMS AFCARS SP to get  AFCARS 2.0 interface data in json format (CIDM-6942)

-- Revision(s)
-- 08/01/2023 - Vineet Tirodkar - To generate the XML with decrypted client info(CIDM-7597)
-- 10/27/2023 - Vineet Tirodkar - Modification to add pagination logic for Foster Care Data (CIDM-8011)
-- 09/25/2024 - Vineet Tirodkar - Modification to XML based on the new guidelines from NCWDMS (CIDM-9501)
-- 04/29/2025 - Vineet Tirodkar - Modifications to fix the duplicate E114_E146 submission error (CIDM-10253 - B-214951)
------------------------------------------------------------------------
DECLARE v_afcars_data json;
DECLARE v_pagenumber int;
DECLARE v_pageoffset int;
	
BEGIN 

	IF COALESCE(v_liPageSize, 0) < 1 THEN                     
		v_liPageSize := 1000;
	END IF;

	IF COALESCE(v_liPageNumber, 0) < 1 
	THEN
		v_liPageNumber := 1;    
	end if;

	v_pagenumber := v_liPageNumber - 1;
	v_pageoffset := v_pagenumber * v_liPageSize;

	IF vs_report_type = 'AD' THEN -- Adoption
		SELECT json_agg(afcars_data) INTO v_afcars_data FROM 
			(select json_build_object('A1_title_iv_agency',	
						( select statetypekey 
							from cjams.afcarsadoptiondetail 
						  limit 1
						 ),
					'A2_report_date',	
						 ( select reportpdenddate 
							from cjams.afcarsadoptiondetail 
						  limit 1
						 ),
					'records',
					(
					select json_agg(json_build_object(
					'record', (
						(select json_agg(x) from
							(select 
								afd.recordno as "A3_child_record_number",
								to_char(afd.a4_child_date_of_birth::date, 'YYYYMMDD') as "A4_child_date_of_birth",
								-- to_char(pr.dob::date, 'YYYYMMDD') as "A4_child_date_of_birth", -- afd.childdob 
								afd.gendertypekey as "A5_child_sex",
								afd.raceaitypekey as "A6_child_race_american_indian_alaska_native",
								afd.raceasiantypekey as "A7_child_race_asian",
								afd.raceblacktypekey as "A8_child_race_black_african_american",  
								afd.racehawaiiantypekey as "A9_child_race_hawaiian_pacific_islander", 
								afd.racewhitetypekey as "A10_child_race_white", 
								afd.raceuntypekey as "A11_child_race_unknown",
								afd.a12_child_race_abandoned as "A12_child_race_abandoned",
								afd.a13_child_race_declined as "A13_child_race_declined",
								(case when afd.hispanictypekey = '1' then
									'1' -- Yes
								when afd.hispanictypekey = '2' then
									'0' -- No
								when afd.hispanictypekey = '3' then	
									'9' -- Unknown
								else
									'9' -- Unknown
								end) as "A14_child_hispanic_latino", 
								afd.a15_assistance_agreement_type as "A15_assistance_agreement_type", -- adoptionsubsidytypekey  
								afd.subsidypaymentamount as "A16_adoption_subsidy_amount",
								to_char(afd.adoptionfinalizeddt::date, 'YYYYMMDD') as "A17_adoption_finalization_date", 
								to_char(afd.a18_agreement_termination_date::date, 'YYYYMMDD') as "A18_agreement_termination_date", 
								afd.childplacedbytypekey as "A19_adoption_placing_agency"
							from cjams.afcarsadoptiondetail afd
								--, person pr
							-- where afd.clientid = pr.cjamspid::bigint
							-- Unit Testing
							-- and clientid in ('200972542', '200986706')
							order by afd.clientid
							LIMIT v_liPageSize OFFSET v_pageoffset 
							) x
						)
					)))
				)
				)
			) as afcars_data;
			
	ELSEIF vs_report_type = 'FC' THEN -- Fostercare
		SELECT json_agg(afcars_data) INTO v_afcars_data FROM 
			(select json_build_object('E1_title_iv_agency',	
						( select e1_title_iv_agency 
							from cjams.afcars_fc_client_data 
						limit 1
						 ),
					'E2_report_date',	
						 ( select e2_report_date 
							from cjams.afcars_fc_client_data 
						limit 1
						 ),
					'records',
					(
					select json_agg(json_build_object(
					'record', (
						(select json_agg(x) from
							(select 
								fc.e4_child_record_number as "E4_child_record_number",
								fc.e5_date_of_birth as "E5_date_of_birth", 
								fc.e6_sex as "E6_sex",
								-- E7_E12_tribal_information
								-- E7_E12_tribal_information
								(select json_agg(y1) from
									(select fc1.e7_agency_made_inquiries as "E7_agency_made_inquiries",
											fc1.e8_tribal_membership as "E8_tribal_membership",
											-- frt.e9_recognized_tribes as "E9_recognized_tribe",
											-- E150_permanency_hearings
											(select json_agg(y22) from
												(select ARRAY_AGG (
													   frt.e9_recognized_tribes
													   ) as "E9_recognized_tribe"
													from cjams.afcars_fc_recognized_tribes frt
												 where frt.afcarsfostercareid = fc1.afcarsfostercareid
												)as y22)
											as "E9_recognized_tribes",
											fc1.e10_icwa as "E10_icwa",
											to_char(fc1.e11_icwa_date::date, 'YYYYMMDD') as "E11_icwa_date",
											fc1.e12_icwa_notification as "E12_icwa_notification"
										from afcars_fc_client_data fc1 -- ,
											-- cjams.afcars_fc_recognized_tribes frt
										where fc1.afcarsfostercareid = fc.afcarsfostercareid
											-- and fc1.afcarsfostercareid = frt.afcarsfostercareid

								)as y1) 
								 as "E7_E12_tribal_information",
								/*
								(select json_agg(y1) from
									(select fc1.e7_agency_made_inquiries as "E7_agency_made_inquiries",
											fc1.e8_tribal_membership as "E8_tribal_membership",
											frt.e9_recognized_tribes as "E9_recognized_tribe",
											fc1.e10_icwa as "E10_icwa",
											to_char(fc1.e11_icwa_date::date, 'YYYYMMDD') as "E11_icwa_date",
											fc1.e12_icwa_notification as "E12_icwa_notification"
										from afcars_fc_client_data fc1,
											cjams.afcars_fc_recognized_tribes frt
										where fc1.afcarsfostercareid = fc.afcarsfostercareid
											and fc1.afcarsfostercareid = frt.afcarsfostercareid

								)as y1) 
								 as "E7_E12_tribal_information",
								 */
								 
								 fc.e13_child_race_american_indian_alaska_native as "E13_child_race_american_indian_alaska_native",
								 fc.e14_child_race_asian as "E14_child_race_asian",
								 fc.e15_child_race_black as "E15_child_race_black",
								 fc.e16_child_race_native_hawaiian_pacific_islander as "E16_child_race_native_hawaiian_pacific_islander",
								 fc.e17_child_race_white as "E17_child_race_white",
								 fc.e18_child_race_unknown as "E18_child_race_unknown",
								 fc.e19_child_race_abandoned as "E19_child_race_abandoned",
								 fc.e20_child_race_declined as "E20_child_race_declined",
								 fc.e21_child_hispanic_latino as "E21_child_hispanic_latino",
								 fc.e22_health_assessment as "E22_health_assessment",
								 fc.e23_health_conditions as "E23_health_conditions",
								 -- E24_34_specific_health_conditions
								 (select json_agg(y2) from
									(select fc2.e24_health_intellectual_disability as "E24_health_intellectual_disability",
										fc2.e25_health_autism_spectrum_disorder as "E25_health_autism_spectrum_disorder",
										fc2.e26_health_visual_impairment as "E26_health_visual_impairment",
										fc2.e27_health_hearing_impairment as "E27_health_hearing_impairment",
										fc2.e28_health_orthopedic_impairment as "E28_health_orthopedic_impairment",
										fc2.e29_health_mental_disorder as "E29_health_mental_disorder",
										fc2.e30_health_adhd_add as "E30_health_adhd_add",
										fc2.e31_health_serious_mental_disorder as "E31_health_serious_mental_disorder",
										fc2.e32_health_developmental_delay as "E32_health_developmental_delay",
										fc2.e33_health_developmental_disability as "E33_health_developmental_disability",
										fc2.e34_health_other_condition "E34_health_other_condition"
									from afcars_fc_client_data fc2
									where fc2.afcarsfostercareid = fc.afcarsfostercareid
								)as y2) 
								as "E24_34_specific_health_conditions",
								fc.e35_school_enrollment as "E35_school_enrollment",
								fc.e36_school_highest_completed as "E36_school_highest_completed",
								fc.e37_school_special_education as "E37_school_special_education",
								fc.e38_pregnant as "E38_pregnant",
								fc.e39_fathered_or_bore_child as "E39_fathered_or_bore_child",
								fc.e40_child_and_children_together as "E40_child_and_children_together",
								fc.e41_prior_adoption as "E41_prior_adoption",
								-- E42_E43_prior_adoption_information
								(select json_agg(y3) from
									(select to_char(fc3.e42_prior_adoption_date::date, 'YYYYMM') as"E42_prior_adoption_date", 
										fc3.e43_prior_adoption_intercountry as "E43_prior_adoption_intercountry"
									from afcars_fc_client_data fc3
									where fc3.afcarsfostercareid = fc.afcarsfostercareid
								)as y3) 
								as "E42_E43_prior_adoption_information",
								fc.e44_prior_guardianship as "E44_prior_guardianship",
								to_char(fc.e45_prior_guardianship_date::date, 'YYYYMM') "E45_prior_guardianship_date", 
								fc.e46_support_assistance as "E46_support_assistance",
								-- E47_E54_type_financial_assistance
								(select json_agg(y4) from
									(select fc4.e47_state_tribal_adoption_assistance as "E47_state_tribal_adoption_assistance",
										fc4.e48_state_tribal_foster_care as "E48_state_tribal_foster_care",
										fc4.e49_adoption_subsidy as "E49_adoption_subsidy",
										fc4.e50_guardianship_assistance as "E50_guardianship_assistance",
										fc4.e51_tanf_assistance as "E51_tanf_assistance",
										fc4.e52_title_iv_b as "E52_title_iv_b",
										fc4.e53_chafee_foster_program as "E53_chafee_foster_program",
										fc4.e54_other_financial_support as "E54_other_financial_support"
									from afcars_fc_client_data fc4
									where fc4.afcarsfostercareid = fc.afcarsfostercareid
								)as y4) 
								as "E47_E54_type_financial_assistance",
								fc.e55_foster_care_payment as "E55_foster_care_payment",
								fc.e56_total_siblings as "E56_total_siblings",
								-- E57_E58_siblings_in_foster_care
								(select json_agg(y5) from
									(select fc5.e57_siblings_in_foster_care as "E57_siblings_in_foster_care",
											fc5.e58_siblings_in_living_arrangement as "E58_siblings_in_living_arrangement"
									from afcars_fc_client_data fc5
									where fc5.afcarsfostercareid = fc.afcarsfostercareid
								)as y5) 
								as "E57_E58_siblings_in_foster_care",
								fc.e59_first_parent_birth_year as "E59_first_parent_birth_year",
								fc.e60_second_parent_birth_year as "E60_second_parent_birth_year",
								fc.e61_tribal_membership_mother as "E61_tribal_membership_mother",
								fc.e62_tribal_membership_father as "E62_tribal_membership_father",
								-- E63_E68_termination_of_parental_rights
								(select json_build_object(
								'tpr_first_parent',
								(select json_agg(y6) from
									 
									(select fc6.e63_tpr_parent1 as "E63_tpr_parent1",
										to_char(fc6.e65_tpr_petition_date_parent1::date, 'YYYYMMDD') as"E65_tpr_petition_date_parent1",
										to_char(fc6.e67_tpr_date_parent1::date, 'YYYYMMDD') as"E67_tpr_date_parent1"
									from afcars_fc_client_data fc6
									where fc6.afcarsfostercareid = fc.afcarsfostercareid
								)as y6),
								'tpr_second_parent',
								(select json_agg(y7) from
									 
									(select fc7.e64_tpr_parent2 as "E64_tpr_parent2",
										to_char(fc7.e66_tpr_petition_date_parent2::date, 'YYYYMMDD') as"E66_tpr_petition_date_parent2",
										to_char(fc7.e68_tpr_date_parent2::date, 'YYYYMMDD') as"E68_tpr_date_parent2"
									from afcars_fc_client_data fc7
									where fc7.afcarsfostercareid = fc.afcarsfostercareid
								)as y7)
								)as "E63_E68_termination_of_parental_rights"
								),
								
								-- E69_E186_removals
								(select json_build_object(
								'removal_1993',
								(select json_agg(y8) from
									(select to_char(rm_past.e69_removal_date::date, 'YYYYMMDD') as "E69_removal_date",
									 to_char(rm_past.e153_exit_date::date, 'YYYYMMDD') as "E153_exit_date",
									rm_past.e155_exit_reason as "E155_exit_reason"
									 from cjams.afcars_fc_child_removals rm_past
									 where rm_past.afcarsfostercareid = fc.afcarsfostercareid
										and rm_past.current_period_removal_sw = 'N'
								)as y8),
								
								'removal_2020',
								(select json_agg(y9) from
									(select to_char(rm_current.e69_removal_date::date, 'YYYYMMDD') as "E69_removal_date",
										to_char(rm_current.e70_removal_transaction_date::date, 'YYYYMMDD') as "E70_removal_transaction_date", 
										rm_current.e71_removal_environment as "E71_removal_environment",
										rm_current.e3_local_agency as "E3_local_agency",
										rm_current.e72_runaway as "E72_runaway", 
										rm_current.e73_whereabouts_unknown as "E73_whereabouts_unknown",
										rm_current.e74_physical_abuse as "E74_physical_abuse",
										rm_current.e75_sexual_abuse as "E75_sexual_abuse",
										rm_current.e76_psychological_abuse as "E76_psychological_abuse",
										rm_current.e77_neglect as "E77_neglect",
										rm_current.e78_medical_neglect as "E78_medical_neglect",
										rm_current.e79_domestic_violence as "E79_domestic_violence",
										rm_current.e80_abandonment as "E80_abandonment",
										rm_current.e81_failure_to_return as "E81_failure_to_return",
										rm_current.e82_caretaker_alcohol_use as "E82_caretaker_alcohol_use",
										rm_current.e83_caretaker_drug_use as "E83_caretaker_drug_use",
										rm_current.e84_child_alcohol_use as "E84_child_alcohol_use",
										rm_current.e85_child_drug_use as "E85_child_drug_use",
										rm_current.e86_prenatal_alcohol_exposure "E86_prenatal_alcohol_exposure",
										rm_current.e87_prenatal_drug_exposure as "E87_prenatal_drug_exposure",
										rm_current.e88_diagnosed_condition as "E88_diagnosed_condition",
										rm_current.e89_inadequate_access_to_mental_health as "E89_inadequate_access_to_mental_health",
										rm_current.e90_inadequate_access_to_medical_service as "E90_inadequate_access_to_medical_service",
										rm_current.e91_child_behavior_problem as "E91_child_behavior_problem",
										rm_current.e92_death_of_caretaker as "E92_death_of_caretaker",
										rm_current.e93_incarceration_of_caretaker as "E93_incarceration_of_caretaker",
										rm_current.e94_caretaker_impairment_physical_emotional as "E94_caretaker_impairment_physical_emotional",
										rm_current.e95_caretaker_impairment_cognitive as "E95_caretaker_impairment_cognitive",
										rm_current.e96_inadequate_housing as "E96_inadequate_housing",
										rm_current.e97_voluntary_adoption as "E97_voluntary_adoption",
										rm_current.e98_child_requested_placement as "E98_child_requested_placement",
										rm_current.e99_sex_trafficking as "E99_sex_trafficking",
										rm_current.e100_parental_immigration_detainment_deportation as "E100_parental_immigration_detainment_deportation",
										rm_current.e101_family_conflict_gender_orientation as "E101_family_conflict_gender_orientation",
										rm_current.e102_educational_neglect as "E102_educational_neglect",
										rm_current.e103_public_agency_title_iv_agreement as "E103_public_agency_title_iv_agreement",
										rm_current.e104_tribal_agreement as "E104_tribal_agreement",
										rm_current.e105_homelessness as "E105_homelessness",
										
										-- E112_E146_living_arrangements
										(select json_build_object(
											'living_arrangement',
											(select json_agg(y17) from
												(select to_char(afpl.e112_date_living_arrangement::date, 'YYYYMMDD') as "E112_date_living_arrangement",
													afpl.e113_foster_family_home as "E113_foster_family_home",
													
													-- "E114_E146_foster_family_home_type"
													(select json_agg(y18) from
														(select afpl1.e114_licensed_home as "E114_licensed_home",
																afpl1.e115_therapeutic_home as "E115_therapeutic_home",
																afpl1.e116_shelter_care_home as "E116_shelter_care_home",
																afpl1.e117_relative_foster_family as "E117_relative_foster_family",
																afpl1.e118_pre_adopt_home as "E118_pre_adopt_home",
																afpl1.e119_kin_foster_family as "E119_kin_foster_family",
																
																-- "E123_E146_foster_parent_information"
																(select json_agg(y19) from
																	(select afpl2.e123_marital_status_of_foster_parents as "E123_marital_status_of_foster_parents",
																		afpl2.e124_relationship_to_foster_parents as "E124_relationship_to_foster_parents",
																		
																		-- "E125_E135_first_foster_parent_information"
																		(select json_agg(y20) from
																			(select afpl3.e125_foster_parent1_birth_year as "E125_foster_parent1_birth_year",
																					afpl3.e126_foster_parent1_tribal_membership as "E126_foster_parent1_tribal_membership",
																					afpl3.e127_foster_parent1_race_american_indian_alaska_native as "E127_foster_parent1_race_american_indian_alaska_native",
																					afpl3.e128_foster_parent1_race_asian as "E128_foster_parent1_race_asian",
																					afpl3.e129_foster_parent1_race_black as "E129_foster_parent1_race_black",
																					afpl3.e130_foster_parent1_race_native_hawaiian_pacific_islander as "E130_foster_parent1_race_native_hawaiian_pacific_islander",
																					afpl3.e131_foster_parent1_race_white as "E131_foster_parent1_race_white",
																					afpl3.e132_foster_parent1_race_unknown as "E132_foster_parent1_race_unknown",
																					afpl3.e133_foster_parent1_race_declined as "E133_foster_parent1_race_declined",
																					afpl3.e134_foster_parent1_hispanic_latino as "E134_foster_parent1_hispanic_latino",
																					afpl3.e135_foster_parent1_sex as "E135_foster_parent1_sex"	
																				from cjams.afcars_fc_placements afpl3
																			 where afpl3.placementid = afpl2.placementid
																					and (case when afpl3.placementcpahomeid is null then
																							true
																						 else
																							afpl3.placementcpahomeid = afpl2.placementcpahomeid
																						 end )
																					and afpl3.removalid = afpl2.removalid
																					and afpl3.afcarsfostercareid = afpl2.afcarsfostercareid	

																		)as y20) 
																		as "E125_E135_first_foster_parent_information",	
																		
																		-- "E136_E146_second_foster_parent_information"
																		(select json_agg(y21) from
																			(select afpl4.e136_foster_parent2_birth_year as "E136_foster_parent2_birth_year",
																				afpl4.e137_foster_parent2_tribal_membership as "E137_foster_parent2_tribal_membership",
																				afpl4.e138_foster_parent2_race_american_indian_alaska_native as "E138_foster_parent2_race_american_indian_alaska_native",
																				afpl4.e139_foster_parent2_race_asian as "E139_foster_parent2_race_asian",
																				afpl4.e140_foster_parent2_race_black as "E140_foster_parent2_race_black",
																				afpl4.e141_foster_parent2_race_native_hawaiian_pacific_islander as "E141_foster_parent2_race_native_hawaiian_pacific_islander",
																				afpl4.e142_foster_parent2_race_white as "E142_foster_parent2_race_white",
																				afpl4.e143_foster_parent2_race_unknown as "E143_foster_parent2_race_unknown",
																				afpl4.e144_foster_parent2_race_declined as "E144_foster_parent2_race_declined",
																				afpl4.e145_foster_parent2_hispanic_latino as "E145_foster_parent2_hispanic_latino",
																				afpl4.e146_foster_parent2_sex as "E146_foster_parent2_sex"
																				from cjams.afcars_fc_placements afpl4
																			 where afpl4.placementid = afpl2.placementid
																				and (case when afpl4.placementcpahomeid is null then
																						true
																					 else
																						afpl4.placementcpahomeid = afpl2.placementcpahomeid
																					 end )
																				and afpl4.removalid = afpl2.removalid
																				and afpl4.afcarsfostercareid = afpl2.afcarsfostercareid	
																		)as y21) 
																		as "E136_E146_second_foster_parent_information"
																	from cjams.afcars_fc_placements afpl2
																	where afpl2.placementid = afpl1.placementid
																		and (case when afpl2.placementcpahomeid is null then
																				true
																			 else
																				afpl2.placementcpahomeid = afpl1.placementcpahomeid
																			 end )
																		and afpl2.removalid = afpl1.removalid	
																		and afpl2.afcarsfostercareid = afpl1.afcarsfostercareid			
																)as y19) 
																as "E123_E146_foster_parent_information"
															 from cjams.afcars_fc_placements afpl1
														 where afpl1.placementid = afpl.placementid
															and (case when afpl1.placementcpahomeid is null then
																	true
																 else
																	afpl1.placementcpahomeid = afpl.placementcpahomeid
																 end )
															and afpl1.removalid = afpl.removalid	
															and afpl1.afcarsfostercareid = afpl.afcarsfostercareid	
													)as y18) 
													as "E114_E146_foster_family_home_type",
													
													afpl.e120_other_living_arrangement_type as "E120_other_living_arrangement_type",
													afpl.e121_location_of_living_arrangement as "E121_location_of_living_arrangement",
													afpl.e122_jurisdiction_or_country as "E122_jurisdiction_or_country"
												 from cjams.afcars_fc_placements afpl
												 where afpl.afcarsfostercareid = fc.afcarsfostercareid
													and afpl.removalid = rm_current.removalid
											)as y17)
											)as "E112_E146_living_arrangements"
										),
										
										-- E147_E148_permanency_plans
										(select json_build_object(
											'permanency_plan',
											(select json_agg(y10) from
												(select to_char(afpp.e147_permanency_plan_date::date, 'YYYYMMDD') as "E147_permanency_plan_date",
												afpp.e148_permanency_plan_type as "E148_permanency_plan_type"
												 from cjams.afcars_fc_permanency_plans afpp
												 where afpp.afcarsfostercareid = fc.afcarsfostercareid
													and afpp.removalid = rm_current.removalid
											)as y10)
											)as "E147_E148_permanency_plans"
										),
										
										-- E149_periodic_reviews
										(select json_agg(y11) from
											(select ARRAY_AGG (
												   distinct(to_char(afpr.e149_periodic_review_date::date, 'YYYYMMDD')) 
												   ) as "E149_periodic_review_date"
												from cjams.afcars_fc_periodic_reviews afpr
											where afpr.afcarsfostercareid = fc.afcarsfostercareid
												and afpr.removalid = rm_current.removalid
											)as y11)
										as "E149_periodic_reviews",
										/*
										(select json_agg(y11) from
											(select distinct to_char(afpr.e149_periodic_review_date::date, 'YYYYMMDD') as "E149_periodic_review_date"
												from cjams.afcars_fc_periodic_reviews afpr
											 where afpr.afcarsfostercareid = fc.afcarsfostercareid
												and afpr.removalid = rm_current.removalid 
											)as y11)
										as "E149_periodic_reviews",
										*/

										-- E150_permanency_hearings
										(select json_agg(y12) from
											(select ARRAY_AGG (
												   distinct to_char(afph.e150_permanency_hearing_date::date, 'YYYYMMDD')
												   ) as "E150_permanency_hearing_date"
												from cjams.afcars_fc_permanency_hearings afph
											 where afph.afcarsfostercareid = fc.afcarsfostercareid
												and afph.removalid = rm_current.removalid
											)as y12)
										as "E150_permanency_hearings",
										/*
										(select json_agg(y12) from
											(select distinct to_char(afph.e150_permanency_hearing_date::date, 'YYYYMMDD') as "E150_permanency_hearing_date"
												from cjams.afcars_fc_permanency_hearings afph
											 where afph.afcarsfostercareid = fc.afcarsfostercareid
												and afph.removalid = rm_current.removalid
											)as y12)
										as "E150_permanency_hearings",
										*/

										-- E151_E152_case_worker_visits
										(select json_build_object(
											'case_worker_visit',
											coalesce(
												(select json_agg(y13) from
													(select distinct to_char(afcv.e151_case_worker_visit_date::date, 'YYYYMMDD') as "E151_case_worker_visit_date",
													afcv.e152_case_worker_visit_location as "E152_case_worker_visit_location"
													 from cjams.afcars_fc_caseworker_visits afcv
													 where afcv.afcarsfostercareid = fc.afcarsfostercareid
														and afcv.removalid = rm_current.removalid
												)as y13),
													'[{
														"E151_case_worker_visit_date": null,
														"E152_case_worker_visit_location": null
													}]'
												)
											)as "E151_E152_case_worker_visits"
										),
										
										to_char(rm_current.e153_exit_date::date, 'YYYYMMDD') as "E153_exit_date",
										to_char(rm_current.e154_exit_transaction_date::date, 'YYYYMMDD') as "E154_exit_transaction_date",
										rm_current.e155_exit_reason as "E155_exit_reason",
										rm_current.e156_transfer_to_another_agency as "E156_transfer_to_another_agency",
										
										-- "E157_E186_adoptive_parents_information"
										(select json_agg(Y14) from
												(select afap.e157_marital_status_of_adoptive_parents as "E157_marital_status_of_adoptive_parents",
											afap.e158_relationship_to_adoptive_parents_relative as "E158_relationship_to_adoptive_parents_relative",
											afap.e159_relationship_to_adoptive_parents_kin as "E159_relationship_to_adoptive_parents_kin",
											afap.e160_relationship_to_adoptive_parents_non_relative as "E160_relationship_to_adoptive_parents_non_relative",
											afap.e161_relationship_to_adoptive_parents_foster_parent as "E161_relationship_to_adoptive_parents_foster_parent",
											-- "E162_E172_first_adoptive_parent_information"
											coalesce((select json_agg(Y15) from
												(select to_char(afap1.e162_adoptive_parent1_birth_date::date, 'YYYYMMDD') as "E162_adoptive_parent1_birth_date",
													afap1.e163_adoptive_parent1_tribal_membership as "E163_adoptive_parent1_tribal_membership",
													afap1.e164_adoptive_parent1_race_american_indian_alaska_native as "E164_adoptive_parent1_race_american_indian_alaska_native",
													afap1.e165_adoptive_parent1_race_asian as "E165_adoptive_parent1_race_asian",
													afap1.e166_adoptive_parent1_race_black as "E166_adoptive_parent1_race_black",
													afap1.e167_adoptive_parent1_race_native_hawaiian_pacific_islander as "E167_adoptive_parent1_race_native_hawaiian_pacific_islander",
													afap1.e168_adoptive_parent1_race_white as "E168_adoptive_parent1_race_white",
													afap1.e169_adoptive_parent1_race_unknown as "E169_adoptive_parent1_race_unknown",
													afap1.e170_adoptive_parent1_race_declined as "E170_adoptive_parent1_race_declined",
													afap1.e171_adoptive_parent1_hispanic_latino as "E171_adoptive_parent1_hispanic_latino",
													afap1.e172_adoptive_parent1_sex as "E172_adoptive_parent1_sex"
												from afcars_fc_adoptive_parents_info afap1
												where afap1.afcarsfostercareid = afap.afcarsfostercareid
													and afap1.removalid = afap.removalid
													and afap1.adoption_casenumber = afap.adoption_casenumber
										)as Y15), 
											'[
													{
														"E162_adoptive_parent1_birth_date": null,
														"E163_adoptive_parent1_tribal_membership": null,
														"E164_adoptive_parent1_race_american_indian_alaska_native": null,
														"E165_adoptive_parent1_race_asian": null,
														"E166_adoptive_parent1_race_black": null,
														"E167_adoptive_parent1_race_native_hawaiian_pacific_islander": null,
														"E168_adoptive_parent1_race_white": null,
														"E169_adoptive_parent1_race_unknown": null,
														"E170_adoptive_parent1_race_declined": null,
														"E171_adoptive_parent1_hispanic_latino": null,
														"E172_adoptive_parent1_sex": null
													}
											  ]'
										)	 
										as "E162_E172_first_adoptive_parent_information",
											
										-- "E173_E183_second_adoptive_parent_information"
										(select json_agg(Y16) from
											(select to_char(afap2.e173_adoptive_parent2_birth_date::date, 'YYYYMMDD') as "E173_adoptive_parent2_birth_date",
												afap2.e174_adoptive_parent2_tribal_membership as "E174_adoptive_parent2_tribal_membership",
												afap2.e175_adoptive_parent2_race_american_indian_alaska_native as "E175_adoptive_parent2_race_american_indian_alaska_native",
												afap2.e176_adoptive_parent2_race_asian as "E176_adoptive_parent2_race_asian",
												afap2.e177_adoptive_parent2_race_black as "E177_adoptive_parent2_race_black",
												afap2.e178_adoptive_parent2_race_native_hawaiian_pacific_islander as "E178_adoptive_parent2_race_native_hawaiian_pacific_islander",
												afap2.e179_adoptive_parent2_race_white as "E179_adoptive_parent2_race_white",
												afap2.e180_adoptive_parent2_race_unknown as "E180_adoptive_parent2_race_unknown",
												afap2.e181_adoptive_parent2_race_declined as "E181_adoptive_parent2_race_declined",
												afap2.e182_adoptive_parent2_hispanic_latino as "E182_adoptive_parent2_hispanic_latino",
												afap2.e183_adoptive_parent2_sex as "E183_adoptive_parent2_sex"
											from afcars_fc_adoptive_parents_info afap2
											where afap2.afcarsfostercareid = afap.afcarsfostercareid
												and afap2.removalid = afap.removalid
												and afap2.adoption_casenumber = afap.adoption_casenumber
										)as Y16) 
										as "E173_E183_second_adoptive_parent_information",

										afap.e184_inter_intrajurisdictional_adoption as "E184_inter_intrajurisdictional_adoption",
										afap.e185_assistance_agreement_type as "E185_assistance_agreement_type",
										afap.e186_siblings_in_adoptive_home as "E186_siblings_in_adoptive_home"
											from afcars_fc_adoptive_parents_info afap
											where afap.afcarsfostercareid = fc.afcarsfostercareid
												and afap.removalid = rm_current.removalid
										)as Y14) 
										as "E157_E186_adoptive_parents_information"
									 from cjams.afcars_fc_child_removals rm_current
									 where rm_current.afcarsfostercareid = fc.afcarsfostercareid
										and rm_current.current_period_removal_sw = 'Y'
										-- Check for at least One Associated Placement
										and (select count(*) 
												from cjams.afcars_fc_placements pl_current
											 where pl_current.removalid = rm_current.removalid
											) > 0
								)as y9)
								)as "E69_E186_removals"
								),
								
								-- Prior Victim Sex Trafficking
								(select (case when count(*) > 0 then '1' else '0' end)
									from cjams.afcars_fc_sex_trafficking ast
								 where ast.afcarsfostercareid = fc.afcarsfostercareid
									and ast.e106_prior_victim_sex_trafficking = '1'
								) as "E106_prior_victim_sex_trafficking",
								
								-- E107_E108_prior_victim_sex_trafficking_reporting
								(select json_agg(y8) from
									(select astp.e107_prior_victim_sex_trafficking_reported as "E107_prior_victim_sex_trafficking_reported",
										(select ARRAY_AGG (
											   distinct(to_char(astp1.e108_prior_victim_sex_trafficking_reported_date::date, 'YYYYMMDD'))
											   ) as "E108_prior_victim_sex_trafficking_reported_date"
											from afcars_fc_sex_trafficking astp1
										 where astp1.afcarsfostercareid = astp.afcarsfostercareid
											and astp1.removalid = astp.removalid
											and astp1.e108_prior_victim_sex_trafficking_reported_date is not null
										) as "E108_prior_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp
									where astp.afcarsfostercareid = fc.afcarsfostercareid
									limit 1
								)as y8) 
								as "E107_E108_prior_victim_sex_trafficking_reporting",
								/*
								(select json_agg(y8) from
									(select astp.e107_prior_victim_sex_trafficking_reported as "E107_prior_victim_sex_trafficking_reported",
											to_char(astp.e108_prior_victim_sex_trafficking_reported_date::date, 'YYYYMMDD') as "E108_prior_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp
									where astp.afcarsfostercareid = fc.afcarsfostercareid
								)as y8) 
								as "E107_E108_prior_victim_sex_trafficking_reporting",
								*/
								
								
								-- Victim Sex Trafficking
								(select (case when count(*) > 0 then '1' else '0' end)
									from cjams.afcars_fc_sex_trafficking ast
								 where ast.afcarsfostercareid = fc.afcarsfostercareid
									and ast.e109_victim_sex_trafficking = '1'
								) as "E109_victim_sex_trafficking",
								
								-- E110_E111_victim_sex_trafficking_reporting
								(select json_agg(Y9) from
									(select astp1.e110_victim_sex_trafficking_reported as "E110_victim_sex_trafficking_reported",
										(select ARRAY_AGG (
											   distinct(to_char(astp2.e111_victim_sex_trafficking_reported_date::date, 'YYYYMMDD'))
											   ) as "E111_victim_sex_trafficking_reported_date"
											from afcars_fc_sex_trafficking astp2
										 where astp2.afcarsfostercareid = astp1.afcarsfostercareid
											and astp2.removalid = astp1.removalid
											and astp2.e111_victim_sex_trafficking_reported_date is not null
										) as "E111_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp1
									where astp1.afcarsfostercareid = fc.afcarsfostercareid
									limit 1
								)as Y9) 
								as "E110_E111_victim_sex_trafficking_reporting"
								
								/*
								(select json_agg(Y9) from
									(select astp1.e110_victim_sex_trafficking_reported as "E110_victim_sex_trafficking_reported",
											to_char(astp1.e111_victim_sex_trafficking_reported_date::date, 'YYYYMMDD') as "E111_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp1
									where astp1.afcarsfostercareid = fc.afcarsfostercareid
								)as Y9) 
								as "E110_E111_victim_sex_trafficking_reporting"
								*/
								
								-- ,recordno as "recordno"
								-- ,cjamspid as "cjamspid",
								-- ,fc.afcarsfostercareid
							from cjams.afcars_fc_client_data fc
							where ( select count(*) 
										from cjams.afcars_fc_child_removals rm
									where rm.cjamspid = fc.cjamspid
										and rm.current_period_removal_sw = 'Y'
										-- Check for at least One Associated Placement
										and (select count(*) 
												from cjams.afcars_fc_placements pl_current
											 where pl_current.removalid = rm.removalid
											) > 0
								   ) > 0
							-- Unit Testing 	   
							-- where cjamspid in ('200302700', '1882479', '200567851') -- , '3517719', '4275862' )
							-- where cjamspid in('4295917', '1946717','1295973' , '200841242', '2459601' )
							-- and recordno not in ('100657892766')
							-- and recordno = '100467279012' -- cjamspid: 10040264
							order by fc.cjamspid
							LIMIT v_liPageSize OFFSET v_pageoffset 
							) x
						)
					)))
				)
				)		
			) as afcars_data;
			
	ELSEIF vs_report_type = 'AD_RPT' THEN -- Adoption
		SELECT json_agg(afcars_data) INTO v_afcars_data FROM 
			(select json_build_object('A1_title_iv_agency',	
						( select statetypekey 
							from cjams.afcarsadoptiondetail 
						  limit 1
						 ),
					'A2_report_date',	
						 ( select reportpdenddate 
							from cjams.afcarsadoptiondetail 
						  limit 1
						 ),
					'records',
					(
					select json_agg(json_build_object(
					'record', (
						(select json_agg(x) from
							(select 
								afd.recordno as "A3_child_record_number",
								cjams.f_afcars_decrypt(afd.recordno) as "PID",  -- Adoption Client
								-- pr.cjamspid as "PID",
								pr.firstname as "First_Name",
								pr.middlename as "Middle_Name",
								pr.lastname as "Last_Name",
								to_char(afd.a4_child_date_of_birth::date, 'YYYYMMDD') as "A4_child_date_of_birth",
								-- to_char(pr.dob::date, 'YYYYMMDD') as "A4_child_date_of_birth", -- afd.childdob 
								afd.gendertypekey as "A5_child_sex",
								afd.raceaitypekey as "A6_child_race_american_indian_alaska_native",
								afd.raceasiantypekey as "A7_child_race_asian",
								afd.raceblacktypekey as "A8_child_race_black_african_american",  
								afd.racehawaiiantypekey as "A9_child_race_hawaiian_pacific_islander", 
								afd.racewhitetypekey as "A10_child_race_white", 
								afd.raceuntypekey as "A11_child_race_unknown",
								afd.a12_child_race_abandoned as "A12_child_race_abandoned",
								afd.a13_child_race_declined as "A13_child_race_declined",
								(case when afd.hispanictypekey = '1' then
									'1' -- Yes
								when afd.hispanictypekey = '2' then
									'0' -- No
								when afd.hispanictypekey = '3' then	
									'9' -- Unknown
								else
									'9' -- Unknown
								end) as "A14_child_hispanic_latino", 
								afd.a15_assistance_agreement_type as "A15_assistance_agreement_type", -- adoptionsubsidytypekey  
								afd.subsidypaymentamount as "A16_adoption_subsidy_amount",
								to_char(afd.adoptionfinalizeddt::date, 'YYYYMMDD') as "A17_adoption_finalization_date", 
								to_char(afd.a18_agreement_termination_date::date, 'YYYYMMDD') as "A18_agreement_termination_date", 
								afd.childplacedbytypekey as "A19_adoption_placing_agency"
							from cjams.afcarsadoptiondetail afd, 
								person pr
							where afd.clientid = pr.cjamspid::bigint
							-- Unit Testing
							-- and clientid in ('200972542', '200986706')
							order by afd.clientid
							LIMIT v_liPageSize OFFSET v_pageoffset 
							) x
						)
					)))
				)
				)
			) as afcars_data;	
			
	ELSEIF vs_report_type = 'FC_RPT' THEN -- Fostercare		
		SELECT json_agg(afcars_data) INTO v_afcars_data FROM 
			(select json_build_object('E1_title_iv_agency',	
						( select e1_title_iv_agency 
							from cjams.afcars_fc_client_data 
						limit 1
						 ),
					'E2_report_date',	
						 ( select e2_report_date 
							from cjams.afcars_fc_client_data 
						limit 1
						 ),
					'records',
					(
					select json_agg(json_build_object(
					'record', (
						(select json_agg(x) from
							(select 
								fc.e4_child_record_number as "E4_child_record_number",
								pr.cjamspid as "PID",
								pr.firstname as "First_Name",
								pr.middlename as "Middle_Name",
								pr.lastname as "Last_Name",
								fc.e5_date_of_birth as "E5_date_of_birth", 
								fc.e6_sex as "E6_sex",
								-- E7_E12_tribal_information
								-- E7_E12_tribal_information
								(select json_agg(y1) from
									(select fc1.e7_agency_made_inquiries as "E7_agency_made_inquiries",
											fc1.e8_tribal_membership as "E8_tribal_membership",
											-- frt.e9_recognized_tribes as "E9_recognized_tribe",
											-- E150_permanency_hearings
											(select json_agg(y22) from
												(select ARRAY_AGG (
													   frt.e9_recognized_tribes
													   ) as "E9_recognized_tribe"
													from cjams.afcars_fc_recognized_tribes frt
												 where frt.afcarsfostercareid = fc1.afcarsfostercareid
												)as y22)
											as "E9_recognized_tribes",
											fc1.e10_icwa as "E10_icwa",
											to_char(fc1.e11_icwa_date::date, 'YYYYMMDD') as "E11_icwa_date",
											fc1.e12_icwa_notification as "E12_icwa_notification"
										from afcars_fc_client_data fc1 -- ,
											-- cjams.afcars_fc_recognized_tribes frt
										where fc1.afcarsfostercareid = fc.afcarsfostercareid
											-- and fc1.afcarsfostercareid = frt.afcarsfostercareid

								)as y1) 
								 as "E7_E12_tribal_information",
								/*
								(select json_agg(y1) from
									(select fc1.e7_agency_made_inquiries as "E7_agency_made_inquiries",
											fc1.e8_tribal_membership as "E8_tribal_membership",
											frt.e9_recognized_tribes as "E9_recognized_tribe",
											fc1.e10_icwa as "E10_icwa",
											to_char(fc1.e11_icwa_date::date, 'YYYYMMDD') as "E11_icwa_date",
											fc1.e12_icwa_notification as "E12_icwa_notification"
										from afcars_fc_client_data fc1,
											cjams.afcars_fc_recognized_tribes frt
										where fc1.afcarsfostercareid = fc.afcarsfostercareid
											and fc1.afcarsfostercareid = frt.afcarsfostercareid

								)as y1) 
								 as "E7_E12_tribal_information",
								 */
								 
								 fc.e13_child_race_american_indian_alaska_native as "E13_child_race_american_indian_alaska_native",
								 fc.e14_child_race_asian as "E14_child_race_asian",
								 fc.e15_child_race_black as "E15_child_race_black",
								 fc.e16_child_race_native_hawaiian_pacific_islander as "E16_child_race_native_hawaiian_pacific_islander",
								 fc.e17_child_race_white as "E17_child_race_white",
								 fc.e18_child_race_unknown as "E18_child_race_unknown",
								 fc.e19_child_race_abandoned as "E19_child_race_abandoned",
								 fc.e20_child_race_declined as "E20_child_race_declined",
								 fc.e21_child_hispanic_latino as "E21_child_hispanic_latino",
								 fc.e22_health_assessment as "E22_health_assessment",
								 fc.e23_health_conditions as "E23_health_conditions",
								 -- E24_34_specific_health_conditions
								 (select json_agg(y2) from
									(select fc2.e24_health_intellectual_disability as "E24_health_intellectual_disability",
										fc2.e25_health_autism_spectrum_disorder as "E25_health_autism_spectrum_disorder",
										fc2.e26_health_visual_impairment as "E26_health_visual_impairment",
										fc2.e27_health_hearing_impairment as "E27_health_hearing_impairment",
										fc2.e28_health_orthopedic_impairment as "E28_health_orthopedic_impairment",
										fc2.e29_health_mental_disorder as "E29_health_mental_disorder",
										fc2.e30_health_adhd_add as "E30_health_adhd_add",
										fc2.e31_health_serious_mental_disorder as "E31_health_serious_mental_disorder",
										fc2.e32_health_developmental_delay as "E32_health_developmental_delay",
										fc2.e33_health_developmental_disability as "E33_health_developmental_disability",
										fc2.e34_health_other_condition "E34_health_other_condition"
									from afcars_fc_client_data fc2
									where fc2.afcarsfostercareid = fc.afcarsfostercareid
								)as y2) 
								as "E24_34_specific_health_conditions",
								fc.e35_school_enrollment as "E35_school_enrollment",
								fc.e36_school_highest_completed as "E36_school_highest_completed",
								fc.e37_school_special_education as "E37_school_special_education",
								fc.e38_pregnant as "E38_pregnant",
								fc.e39_fathered_or_bore_child as "E39_fathered_or_bore_child",
								fc.e40_child_and_children_together as "E40_child_and_children_together",
								fc.e41_prior_adoption as "E41_prior_adoption",
								-- E42_E43_prior_adoption_information
								(select json_agg(y3) from
									(select to_char(fc3.e42_prior_adoption_date::date, 'YYYYMM') as"E42_prior_adoption_date", 
										fc3.e43_prior_adoption_intercountry as "E43_prior_adoption_intercountry"
									from afcars_fc_client_data fc3
									where fc3.afcarsfostercareid = fc.afcarsfostercareid
								)as y3) 
								as "E42_E43_prior_adoption_information",
								fc.e44_prior_guardianship as "E44_prior_guardianship",
								to_char(fc.e45_prior_guardianship_date::date, 'YYYYMM') "E45_prior_guardianship_date", 
								fc.e46_support_assistance as "E46_support_assistance",
								-- E47_E54_type_financial_assistance
								(select json_agg(y4) from
									(select fc4.e47_state_tribal_adoption_assistance as "E47_state_tribal_adoption_assistance",
										fc4.e48_state_tribal_foster_care as "E48_state_tribal_foster_care",
										fc4.e49_adoption_subsidy as "E49_adoption_subsidy",
										fc4.e50_guardianship_assistance as "E50_guardianship_assistance",
										fc4.e51_tanf_assistance as "E51_tanf_assistance",
										fc4.e52_title_iv_b as "E52_title_iv_b",
										fc4.e53_chafee_foster_program as "E53_chafee_foster_program",
										fc4.e54_other_financial_support as "E54_other_financial_support"
									from afcars_fc_client_data fc4
									where fc4.afcarsfostercareid = fc.afcarsfostercareid
								)as y4) 
								as "E47_E54_type_financial_assistance",
								fc.e55_foster_care_payment as "E55_foster_care_payment",
								fc.e56_total_siblings as "E56_total_siblings",
								-- E57_E58_siblings_in_foster_care
								(select json_agg(y5) from
									(select fc5.e57_siblings_in_foster_care as "E57_siblings_in_foster_care",
											fc5.e58_siblings_in_living_arrangement as "E58_siblings_in_living_arrangement"
									from afcars_fc_client_data fc5
									where fc5.afcarsfostercareid = fc.afcarsfostercareid
								)as y5) 
								as "E57_E58_siblings_in_foster_care",
								fc.e59_first_parent_birth_year as "E59_first_parent_birth_year",
								fc.e60_second_parent_birth_year as "E60_second_parent_birth_year",
								fc.e61_tribal_membership_mother as "E61_tribal_membership_mother",
								fc.e62_tribal_membership_father as "E62_tribal_membership_father",
								-- E63_E68_termination_of_parental_rights
								(select json_build_object(
								'tpr_first_parent',
								(select json_agg(y6) from
									 
									(select fc6.e63_tpr_parent1 as "E63_tpr_parent1",
										to_char(fc6.e65_tpr_petition_date_parent1::date, 'YYYYMMDD') as"E65_tpr_petition_date_parent1",
										to_char(fc6.e67_tpr_date_parent1::date, 'YYYYMMDD') as"E67_tpr_date_parent1"
									from afcars_fc_client_data fc6
									where fc6.afcarsfostercareid = fc.afcarsfostercareid
								)as y6),
								'tpr_second_parent',
								(select json_agg(y7) from
									 
									(select fc7.e64_tpr_parent2 as "E64_tpr_parent2",
										to_char(fc7.e66_tpr_petition_date_parent2::date, 'YYYYMMDD') as"E66_tpr_petition_date_parent2",
										to_char(fc7.e68_tpr_date_parent2::date, 'YYYYMMDD') as"E68_tpr_date_parent2"
									from afcars_fc_client_data fc7
									where fc7.afcarsfostercareid = fc.afcarsfostercareid
								)as y7)
								)as "E63_E68_termination_of_parental_rights"
								),
								
								-- E69_E186_removals
								(select json_build_object(
								'removal_1993',
								(select json_agg(y8) from
									(select to_char(rm_past.e69_removal_date::date, 'YYYYMMDD') as "E69_removal_date",
									 to_char(rm_past.e153_exit_date::date, 'YYYYMMDD') as "E153_exit_date",
									rm_past.e155_exit_reason as "E155_exit_reason"
									 from cjams.afcars_fc_child_removals rm_past
									 where rm_past.afcarsfostercareid = fc.afcarsfostercareid
										and rm_past.current_period_removal_sw = 'N'
								)as y8),
								
								'removal_2020',
								(select json_agg(y9) from
									(select to_char(rm_current.e69_removal_date::date, 'YYYYMMDD') as "E69_removal_date",
										to_char(rm_current.e70_removal_transaction_date::date, 'YYYYMMDD') as "E70_removal_transaction_date", 
										rm_current.e71_removal_environment as "E71_removal_environment",
										rm_current.e3_local_agency as "E3_local_agency",
										rm_current.e72_runaway as "E72_runaway", 
										rm_current.e73_whereabouts_unknown as "E73_whereabouts_unknown",
										rm_current.e74_physical_abuse as "E74_physical_abuse",
										rm_current.e75_sexual_abuse as "E75_sexual_abuse",
										rm_current.e76_psychological_abuse as "E76_psychological_abuse",
										rm_current.e77_neglect as "E77_neglect",
										rm_current.e78_medical_neglect as "E78_medical_neglect",
										rm_current.e79_domestic_violence as "E79_domestic_violence",
										rm_current.e80_abandonment as "E80_abandonment",
										rm_current.e81_failure_to_return as "E81_failure_to_return",
										rm_current.e82_caretaker_alcohol_use as "E82_caretaker_alcohol_use",
										rm_current.e83_caretaker_drug_use as "E83_caretaker_drug_use",
										rm_current.e84_child_alcohol_use as "E84_child_alcohol_use",
										rm_current.e85_child_drug_use as "E85_child_drug_use",
										rm_current.e86_prenatal_alcohol_exposure "E86_prenatal_alcohol_exposure",
										rm_current.e87_prenatal_drug_exposure as "E87_prenatal_drug_exposure",
										rm_current.e88_diagnosed_condition as "E88_diagnosed_condition",
										rm_current.e89_inadequate_access_to_mental_health as "E89_inadequate_access_to_mental_health",
										rm_current.e90_inadequate_access_to_medical_service as "E90_inadequate_access_to_medical_service",
										rm_current.e91_child_behavior_problem as "E91_child_behavior_problem",
										rm_current.e92_death_of_caretaker as "E92_death_of_caretaker",
										rm_current.e93_incarceration_of_caretaker as "E93_incarceration_of_caretaker",
										rm_current.e94_caretaker_impairment_physical_emotional as "E94_caretaker_impairment_physical_emotional",
										rm_current.e95_caretaker_impairment_cognitive as "E95_caretaker_impairment_cognitive",
										rm_current.e96_inadequate_housing as "E96_inadequate_housing",
										rm_current.e97_voluntary_adoption as "E97_voluntary_adoption",
										rm_current.e98_child_requested_placement as "E98_child_requested_placement",
										rm_current.e99_sex_trafficking as "E99_sex_trafficking",
										rm_current.e100_parental_immigration_detainment_deportation as "E100_parental_immigration_detainment_deportation",
										rm_current.e101_family_conflict_gender_orientation as "E101_family_conflict_gender_orientation",
										rm_current.e102_educational_neglect as "E102_educational_neglect",
										rm_current.e103_public_agency_title_iv_agreement as "E103_public_agency_title_iv_agreement",
										rm_current.e104_tribal_agreement as "E104_tribal_agreement",
										rm_current.e105_homelessness as "E105_homelessness",
										
										-- E112_E146_living_arrangements
										(select json_build_object(
											'living_arrangement',
											(select json_agg(y17) from
												(select to_char(afpl.e112_date_living_arrangement::date, 'YYYYMMDD') as "E112_date_living_arrangement",
													afpl.e113_foster_family_home as "E113_foster_family_home",
													
													-- "E114_E146_foster_family_home_type"
													(select json_agg(y18) from
														(select afpl1.e114_licensed_home as "E114_licensed_home",
																afpl1.e115_therapeutic_home as "E115_therapeutic_home",
																afpl1.e116_shelter_care_home as "E116_shelter_care_home",
																afpl1.e117_relative_foster_family as "E117_relative_foster_family",
																afpl1.e118_pre_adopt_home as "E118_pre_adopt_home",
																afpl1.e119_kin_foster_family as "E119_kin_foster_family",
																
																-- "E123_E146_foster_parent_information"
																(select json_agg(y19) from
																	(select afpl2.e123_marital_status_of_foster_parents as "E123_marital_status_of_foster_parents",
																		afpl2.e124_relationship_to_foster_parents as "E124_relationship_to_foster_parents",
																		
																		-- "E125_E135_first_foster_parent_information"
																		(select json_agg(y20) from
																			(select afpl3.e125_foster_parent1_birth_year as "E125_foster_parent1_birth_year",
																					afpl3.e126_foster_parent1_tribal_membership as "E126_foster_parent1_tribal_membership",
																					afpl3.e127_foster_parent1_race_american_indian_alaska_native as "E127_foster_parent1_race_american_indian_alaska_native",
																					afpl3.e128_foster_parent1_race_asian as "E128_foster_parent1_race_asian",
																					afpl3.e129_foster_parent1_race_black as "E129_foster_parent1_race_black",
																					afpl3.e130_foster_parent1_race_native_hawaiian_pacific_islander as "E130_foster_parent1_race_native_hawaiian_pacific_islander",
																					afpl3.e131_foster_parent1_race_white as "E131_foster_parent1_race_white",
																					afpl3.e132_foster_parent1_race_unknown as "E132_foster_parent1_race_unknown",
																					afpl3.e133_foster_parent1_race_declined as "E133_foster_parent1_race_declined",
																					afpl3.e134_foster_parent1_hispanic_latino as "E134_foster_parent1_hispanic_latino",
																					afpl3.e135_foster_parent1_sex as "E135_foster_parent1_sex"	
																				from cjams.afcars_fc_placements afpl3
																			 where afpl3.placementid = afpl2.placementid
																				and (case when afpl3.placementcpahomeid is null then
																						true
																					 else
																						afpl3.placementcpahomeid = afpl2.placementcpahomeid
																					 end )
																				and afpl3.removalid = afpl2.removalid
																				and afpl3.afcarsfostercareid = afpl2.afcarsfostercareid
																		)as y20) 
																		as "E125_E135_first_foster_parent_information",	
																		
																		-- "E136_E146_second_foster_parent_information"
																		(select json_agg(y21) from
																			(select afpl4.e136_foster_parent2_birth_year as "E136_foster_parent2_birth_year",
																				afpl4.e137_foster_parent2_tribal_membership as "E137_foster_parent2_tribal_membership",
																				afpl4.e138_foster_parent2_race_american_indian_alaska_native as "E138_foster_parent2_race_american_indian_alaska_native",
																				afpl4.e139_foster_parent2_race_asian as "E139_foster_parent2_race_asian",
																				afpl4.e140_foster_parent2_race_black as "E140_foster_parent2_race_black",
																				afpl4.e141_foster_parent2_race_native_hawaiian_pacific_islander as "E141_foster_parent2_race_native_hawaiian_pacific_islander",
																				afpl4.e142_foster_parent2_race_white as "E142_foster_parent2_race_white",
																				afpl4.e143_foster_parent2_race_unknown as "E143_foster_parent2_race_unknown",
																				afpl4.e144_foster_parent2_race_declined as "E144_foster_parent2_race_declined",
																				afpl4.e145_foster_parent2_hispanic_latino as "E145_foster_parent2_hispanic_latino",
																				afpl4.e146_foster_parent2_sex as "E146_foster_parent2_sex"
																				from cjams.afcars_fc_placements afpl4
																			 where afpl4.placementid = afpl2.placementid
																				 and (case when afpl4.placementcpahomeid is null then
																						true
																					 else
																						afpl4.placementcpahomeid = afpl2.placementcpahomeid
																					 end )
																				and afpl4.removalid = afpl2.removalid
																				and afpl4.afcarsfostercareid = afpl2.afcarsfostercareid	
																		)as y21) 
																		as "E136_E146_second_foster_parent_information"
																	from cjams.afcars_fc_placements afpl2
																	where afpl2.placementid = afpl1.placementid
																		and (case when afpl2.placementcpahomeid is null then
																				true
																			 else
																				afpl2.placementcpahomeid = afpl1.placementcpahomeid
																			 end )
																		and afpl2.removalid = afpl1.removalid
																		and afpl2.afcarsfostercareid = afpl1.afcarsfostercareid	
																)as y19) 
																as "E123_E146_foster_parent_information"
															 from cjams.afcars_fc_placements afpl1
														 where afpl1.placementid = afpl.placementid
															and (case when afpl1.placementcpahomeid is null then
																	true
																 else
																	afpl1.placementcpahomeid = afpl.placementcpahomeid
																 end )
															and afpl1.removalid = afpl.removalid	
															and afpl1.afcarsfostercareid = afpl.afcarsfostercareid	
													)as y18) 
													as "E114_E146_foster_family_home_type",
													
													afpl.e120_other_living_arrangement_type as "E120_other_living_arrangement_type",
													afpl.e121_location_of_living_arrangement as "E121_location_of_living_arrangement",
													afpl.e122_jurisdiction_or_country as "E122_jurisdiction_or_country"
												 from cjams.afcars_fc_placements afpl
												 where afpl.afcarsfostercareid = fc.afcarsfostercareid
													and afpl.removalid = rm_current.removalid
											)as y17)
											)as "E112_E146_living_arrangements"
										),
										
										-- E147_E148_permanency_plans
										(select json_build_object(
											'permanency_plan',
											(select json_agg(y10) from
												(select to_char(afpp.e147_permanency_plan_date::date, 'YYYYMMDD') as "E147_permanency_plan_date",
												afpp.e148_permanency_plan_type as "E148_permanency_plan_type"
												 from cjams.afcars_fc_permanency_plans afpp
												 where afpp.afcarsfostercareid = fc.afcarsfostercareid
													and afpp.removalid = rm_current.removalid
											)as y10)
											)as "E147_E148_permanency_plans"
										),
										
										-- E149_periodic_reviews
										(select json_agg(y11) from
											(select ARRAY_AGG (
												   distinct(to_char(afpr.e149_periodic_review_date::date, 'YYYYMMDD')) 
												   ) as "E149_periodic_review_date"
												from cjams.afcars_fc_periodic_reviews afpr
											where afpr.afcarsfostercareid = fc.afcarsfostercareid
												and afpr.removalid = rm_current.removalid
											)as y11)
										as "E149_periodic_reviews",
										/*
										(select json_agg(y11) from
											(select distinct to_char(afpr.e149_periodic_review_date::date, 'YYYYMMDD') as "E149_periodic_review_date"
												from cjams.afcars_fc_periodic_reviews afpr
											 where afpr.afcarsfostercareid = fc.afcarsfostercareid
												and afpr.removalid = rm_current.removalid 
											)as y11)
										as "E149_periodic_reviews",
										*/

										-- E150_permanency_hearings
										(select json_agg(y12) from
											(select ARRAY_AGG (
												   distinct to_char(afph.e150_permanency_hearing_date::date, 'YYYYMMDD')
												   ) as "E150_permanency_hearing_date"
												from cjams.afcars_fc_permanency_hearings afph
											 where afph.afcarsfostercareid = fc.afcarsfostercareid
												and afph.removalid = rm_current.removalid
											)as y12)
										as "E150_permanency_hearings",
										/*
										(select json_agg(y12) from
											(select distinct to_char(afph.e150_permanency_hearing_date::date, 'YYYYMMDD') as "E150_permanency_hearing_date"
												from cjams.afcars_fc_permanency_hearings afph
											 where afph.afcarsfostercareid = fc.afcarsfostercareid
												and afph.removalid = rm_current.removalid
											)as y12)
										as "E150_permanency_hearings",
										*/

										-- E151_E152_case_worker_visits
										(select json_build_object(
											'case_worker_visit',
											(select json_agg(y13) from
												(select distinct to_char(afcv.e151_case_worker_visit_date::date, 'YYYYMMDD') as "E151_case_worker_visit_date",
												afcv.e152_case_worker_visit_location as "E152_case_worker_visit_location"
												 from cjams.afcars_fc_caseworker_visits afcv
												 where afcv.afcarsfostercareid = fc.afcarsfostercareid
													and afcv.removalid = rm_current.removalid
											)as y13)
											)as "E151_E152_case_worker_visits"
										),
										
										to_char(rm_current.e153_exit_date::date, 'YYYYMMDD') as "E153_exit_date",
										to_char(rm_current.e154_exit_transaction_date::date, 'YYYYMMDD') as "E154_exit_transaction_date",
										rm_current.e155_exit_reason as "E155_exit_reason",
										rm_current.e156_transfer_to_another_agency as "E156_transfer_to_another_agency",
										
										-- "E157_E186_adoptive_parents_information"
										(select json_agg(Y14) from
												(select afap.e157_marital_status_of_adoptive_parents as "E157_marital_status_of_adoptive_parents",
											afap.e158_relationship_to_adoptive_parents_relative as "E158_relationship_to_adoptive_parents_relative",
											afap.e159_relationship_to_adoptive_parents_kin as "E159_relationship_to_adoptive_parents_kin",
											afap.e160_relationship_to_adoptive_parents_non_relative as "E160_relationship_to_adoptive_parents_non_relative",
											afap.e161_relationship_to_adoptive_parents_foster_parent as "E161_relationship_to_adoptive_parents_foster_parent",
											-- "E162_E172_first_adoptive_parent_information"
											(select json_agg(Y15) from
												(select to_char(afap1.e162_adoptive_parent1_birth_date::date, 'YYYYMMDD') as "E162_adoptive_parent1_birth_date",
													afap1.e163_adoptive_parent1_tribal_membership as "E163_adoptive_parent1_tribal_membership",
													afap1.e164_adoptive_parent1_race_american_indian_alaska_native as "E164_adoptive_parent1_race_american_indian_alaska_native",
													afap1.e165_adoptive_parent1_race_asian as "E165_adoptive_parent1_race_asian",
													afap1.e166_adoptive_parent1_race_black as "E166_adoptive_parent1_race_black",
													afap1.e167_adoptive_parent1_race_native_hawaiian_pacific_islander as "E167_adoptive_parent1_race_native_hawaiian_pacific_islander",
													afap1.e168_adoptive_parent1_race_white as "E168_adoptive_parent1_race_white",
													afap1.e169_adoptive_parent1_race_unknown as "E169_adoptive_parent1_race_unknown",
													afap1.e170_adoptive_parent1_race_declined as "E170_adoptive_parent1_race_declined",
													afap1.e171_adoptive_parent1_hispanic_latino as "E171_adoptive_parent1_hispanic_latino",
													afap1.e172_adoptive_parent1_sex as "E172_adoptive_parent1_sex"
												from afcars_fc_adoptive_parents_info afap1
												where afap1.afcarsfostercareid = afap.afcarsfostercareid
													and afap1.removalid = afap.removalid
													and afap1.adoption_casenumber = afap.adoption_casenumber
										)as Y15) 
										as "E162_E172_first_adoptive_parent_information",
											
										-- "E173_E183_second_adoptive_parent_information"
										(select json_agg(Y16) from
											(select to_char(afap2.e173_adoptive_parent2_birth_date::date, 'YYYYMMDD') as "E173_adoptive_parent2_birth_date",
												afap2.e174_adoptive_parent2_tribal_membership as "E174_adoptive_parent2_tribal_membership",
												afap2.e175_adoptive_parent2_race_american_indian_alaska_native as "E175_adoptive_parent2_race_american_indian_alaska_native",
												afap2.e176_adoptive_parent2_race_asian as "E176_adoptive_parent2_race_asian",
												afap2.e177_adoptive_parent2_race_black as "E177_adoptive_parent2_race_black",
												afap2.e178_adoptive_parent2_race_native_hawaiian_pacific_islander as "E178_adoptive_parent2_race_native_hawaiian_pacific_islander",
												afap2.e179_adoptive_parent2_race_white as "E179_adoptive_parent2_race_white",
												afap2.e180_adoptive_parent2_race_unknown as "E180_adoptive_parent2_race_unknown",
												afap2.e181_adoptive_parent2_race_declined as "E181_adoptive_parent2_race_declined",
												afap2.e182_adoptive_parent2_hispanic_latino as "E182_adoptive_parent2_hispanic_latino",
												afap2.e183_adoptive_parent2_sex as "E183_adoptive_parent2_sex"
											from afcars_fc_adoptive_parents_info afap2
											where afap2.afcarsfostercareid = afap.afcarsfostercareid
												and afap2.removalid = afap.removalid
												and afap2.adoption_casenumber = afap.adoption_casenumber
										)as Y16) 
										as "E173_E183_second_adoptive_parent_information",

										afap.e184_inter_intrajurisdictional_adoption as "E184_inter_intrajurisdictional_adoption",
										afap.e185_assistance_agreement_type as "E185_assistance_agreement_type",
										afap.e186_siblings_in_adoptive_home as "E186_siblings_in_adoptive_home"
											from afcars_fc_adoptive_parents_info afap
											where afap.afcarsfostercareid = fc.afcarsfostercareid
												and afap.removalid = rm_current.removalid
										)as Y14) 
										as "E157_E186_adoptive_parents_information"
									 from cjams.afcars_fc_child_removals rm_current
									 where rm_current.afcarsfostercareid = fc.afcarsfostercareid
										and rm_current.current_period_removal_sw = 'Y'
										-- Check for at least One Associated Placement
										and (select count(*) 
												from cjams.afcars_fc_placements pl_current
											 where pl_current.removalid = rm_current.removalid
											) > 0
								)as y9)
								)as "E69_E186_removals"
								),
								
								-- Prior Victim Sex Trafficking
								(select (case when count(*) > 0 then '1' else '0' end)
									from cjams.afcars_fc_sex_trafficking ast
								 where ast.afcarsfostercareid = fc.afcarsfostercareid
									and ast.e106_prior_victim_sex_trafficking = '1'
								) as "E106_prior_victim_sex_trafficking",
								
								-- E107_E108_prior_victim_sex_trafficking_reporting
								(select json_agg(y8) from
									(select astp.e107_prior_victim_sex_trafficking_reported as "E107_prior_victim_sex_trafficking_reported",
										(select ARRAY_AGG (
											   distinct(to_char(astp1.e108_prior_victim_sex_trafficking_reported_date::date, 'YYYYMMDD'))
											   ) as "E108_prior_victim_sex_trafficking_reported_date"
											from afcars_fc_sex_trafficking astp1
										 where astp1.afcarsfostercareid = astp.afcarsfostercareid
											and astp1.removalid = astp.removalid
											and astp1.e108_prior_victim_sex_trafficking_reported_date is not null
										) as "E108_prior_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp
									where astp.afcarsfostercareid = fc.afcarsfostercareid
									limit 1
								)as y8) 
								as "E107_E108_prior_victim_sex_trafficking_reporting",
								/*
								(select json_agg(y8) from
									(select astp.e107_prior_victim_sex_trafficking_reported as "E107_prior_victim_sex_trafficking_reported",
											to_char(astp.e108_prior_victim_sex_trafficking_reported_date::date, 'YYYYMMDD') as "E108_prior_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp
									where astp.afcarsfostercareid = fc.afcarsfostercareid
								)as y8) 
								as "E107_E108_prior_victim_sex_trafficking_reporting",
								*/
								
								
								-- Victim Sex Trafficking
								(select (case when count(*) > 0 then '1' else '0' end)
									from cjams.afcars_fc_sex_trafficking ast
								 where ast.afcarsfostercareid = fc.afcarsfostercareid
									and ast.e109_victim_sex_trafficking = '1'
								) as "E109_victim_sex_trafficking",
								
								-- E110_E111_victim_sex_trafficking_reporting
								(select json_agg(Y9) from
									(select astp1.e110_victim_sex_trafficking_reported as "E110_victim_sex_trafficking_reported",
										(select ARRAY_AGG (
											   distinct(to_char(astp2.e111_victim_sex_trafficking_reported_date::date, 'YYYYMMDD'))
											   ) as "E111_victim_sex_trafficking_reported_date"
											from afcars_fc_sex_trafficking astp2
										 where astp2.afcarsfostercareid = astp1.afcarsfostercareid
											and astp2.removalid = astp1.removalid
											and astp2.e111_victim_sex_trafficking_reported_date is not null
										) as "E111_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp1
									where astp1.afcarsfostercareid = fc.afcarsfostercareid
									limit 1
								)as Y9) 
								as "E110_E111_victim_sex_trafficking_reporting"
								
								/*
								(select json_agg(Y9) from
									(select astp1.e110_victim_sex_trafficking_reported as "E110_victim_sex_trafficking_reported",
											to_char(astp1.e111_victim_sex_trafficking_reported_date::date, 'YYYYMMDD') as "E111_victim_sex_trafficking_reported_date"
									from afcars_fc_sex_trafficking astp1
									where astp1.afcarsfostercareid = fc.afcarsfostercareid
								)as Y9) 
								as "E110_E111_victim_sex_trafficking_reporting"
								*/
								
								-- ,recordno as "recordno"
								-- ,cjamspid as "cjamspid",
								-- ,fc.afcarsfostercareid
							from cjams.afcars_fc_client_data fc,
								person pr
							where fc.cjamspid = pr.cjamspid::character varying
								and ( select count(*) 
										from cjams.afcars_fc_child_removals rm
									where rm.cjamspid = fc.cjamspid
										and rm.current_period_removal_sw = 'Y'
										-- Check for at least One Associated Placement
										and (select count(*) 
												from cjams.afcars_fc_placements pl_current
											 where pl_current.removalid = rm.removalid
											) > 0
								   ) > 0
							-- Unit Testing 	   
							-- where cjamspid in ('200302700', '1882479', '200567851') -- , '3517719', '4275862' )
							-- where cjamspid in('4295917', '1946717','1295973' , '200841242', '2459601' )
							-- and recordno not in ('100657892766')
							-- and recordno = '100467279012' -- cjamspid: 10040264
							order by fc.cjamspid
							LIMIT v_liPageSize OFFSET v_pageoffset 
							) x
						)
					)))
				)
				)		
			) as afcars_data;	
	END IF;
			
	RETURN v_afcars_data;	
	
END;

$function$
;
