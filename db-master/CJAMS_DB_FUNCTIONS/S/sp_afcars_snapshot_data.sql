DROP FUNCTION IF EXISTS cjams.sp_afcars_snapshot_data( character varying) ;
																	
CREATE OR REPLACE FUNCTION cjams.sp_afcars_snapshot_data( vs_report_type character varying, 
														  OUT al_sqlcode integer, 
														  OUT as_mess character varying
														)
														
 RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Auhor: Vineet Tirodkar
-- Date : 03/19/2025
-- Description: 
-- CJAMS AFCARS SP to snapshot the AFCARS FC & Adoption data prior to the next submission.(CIDM-10187)

-- Revision(s)
-- 03/21/2025 - Vineet Tirodkar - Modifications to include the newly added removal_date, exit_date columns (CIDM-10253 - B-214951)
------------------------------------------------------------------------
DECLARE sqlcode int default 0;
DECLARE v_afcars_history_id bigint;
	
BEGIN 

	IF vs_report_type = 'AD' THEN -- Adoption
		select nextval('sq_afcars_history'::regclass) into v_afcars_history_id ;
	
		RAISE NOTICE 'AD - v_afcars_history_id >> %',v_afcars_history_id;

		-- afcarsadoptioncount
		INSERT INTO cjams.afcarsadoptioncount_history
			(	countid, totalnorecords, periodendingdate, chunderoneyear, choneyear, chtwoyear, chthreeyear, 
				chfouryear, chfiveyear, chsixyear, chsevenyear, cheightyear, chnineyear, chtenyear, chelevenyear, 
				chtwelveyear, chthirteenyear, chfourteenyear, chfifteenyear, chsixteenyear, chseventeenyear, 
				cheighteenyear, chovereighteenyear, insertedon, insertedby, updatedon, updatedby, activeflag, 
				old_id, etl_userid, etl_load_date, history_insertedon, afcars_history_id
			)
		SELECT countid, totalnorecords, periodendingdate, chunderoneyear, choneyear, chtwoyear, chthreeyear, 
			chfouryear, chfiveyear, chsixyear, chsevenyear, cheightyear, chnineyear, chtenyear, chelevenyear, 
			chtwelveyear, chthirteenyear, chfourteenyear, chfifteenyear, chsixteenyear, chseventeenyear, 
			cheighteenyear, chovereighteenyear, insertedon, insertedby, updatedon, updatedby, activeflag, 
			old_id, etl_userid, etl_load_date, now(), v_afcars_history_id
		FROM cjams.afcarsadoptioncount;

		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_mess := 'Error capturing data in the afcarsadoptioncount_history table' ;
			al_sqlcode := -1;
		END IF ;
		
		
		IF al_sqlcode <> -1 Then
			-- afcarsadoptionsummary
			INSERT INTO cjams.afcarsadoptionsummary_history
				(	summaryid, reportingperiod, firstsubmitteddate, lastsubmitteddate, insertedon, insertedby, 
					updatedon, updatedby, activeflag, old_id, etl_userid, etl_load_date, history_insertedon, 
					afcars_history_id
				)
			SELECT summaryid, reportingperiod, firstsubmitteddate, lastsubmitteddate, insertedon, insertedby, 
				updatedon, updatedby, activeflag, old_id, etl_userid, etl_load_date, now(), v_afcars_history_id
			FROM cjams.afcarsadoptionsummary;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcarsadoptionsummary_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;
		
		IF al_sqlcode <> -1 Then
			-- afcarsadoptiondetail
			INSERT INTO cjams.afcarsadoptiondetail_history
				(	detailid, summaryid, personid, submittedperiod, actualperiod, statetypekey, reportpdenddate, 
					recordno, agencyinvolvementtypekey, childdob, gendertypekey, raceaitypekey, raceasiantypekey, 
					raceblacktypekey, racehawaiiantypekey, racewhitetypekey, raceuntypekey, hispanictypekey, 
					specialneedstypekey, primarybasistypekey, mentalretardationtypekey, visualhearingtypekey, 
					physicaldisabledtypekey, emotionaldisturbedtypekey, otherdiagnosedconditiontypekey, 
					bmotherbirthyear, bfatherbirthyear, mothermarriedatbirthtypekey, mothertprdt, fathertprdt, 
					adoptionfinalizeddt, adopfamilystructuretypekey, adopmotherbirthyear, adopfatherbirthyear, 
					adopmotherraceaitypekey, adopmotherraceasiantypekey, adopmotherraceblacktypekey, 
					adopmotherracehawaiiantypekey, adopmotherracewhitetypekey, adopmotherraceuntypekey, 
					adopmotherhispanictypekey, adopfatherraceaitypekey, adopfatherraceasiantypekey, 
					adopfatherraceblacktypekey, adopfatherracehawaiiantypekey, adopfatherracewhitetypekey, 
					adopfatherraceuntypekey, adopfatherhispanictypekey, adopparrelstepparenttypekey, 
					adopparrelotherreltypekey, adopparrelnonreltypekey, childplacedfromtypekey, childplacedbytypekey, 
					adoptionsubsidytypekey, subsidypaymentamount, iveadoptionflag, insertedon, insertedby, updatedon, 
					updatedby, activeflag, adopparrelfospartypekey, datavalidflag, old_id, clientid, etl_userid, 
					etl_load_date, a12_child_race_abandoned, a13_child_race_declined, a15_assistance_agreement_type, 
					agreement_start_date, a18_agreement_termination_date, a4_child_date_of_birth, adoption_gap_casetype, 
					history_insertedon, afcars_history_id
				)
			SELECT detailid, summaryid, personid, submittedperiod, actualperiod, statetypekey, reportpdenddate, 
				recordno, agencyinvolvementtypekey, childdob, gendertypekey, raceaitypekey, raceasiantypekey, 
				raceblacktypekey, racehawaiiantypekey, racewhitetypekey, raceuntypekey, hispanictypekey, 
				specialneedstypekey, primarybasistypekey, mentalretardationtypekey, visualhearingtypekey, 
				physicaldisabledtypekey, emotionaldisturbedtypekey, otherdiagnosedconditiontypekey, 
				bmotherbirthyear, bfatherbirthyear, mothermarriedatbirthtypekey, mothertprdt, fathertprdt, 
				adoptionfinalizeddt, adopfamilystructuretypekey, adopmotherbirthyear, adopfatherbirthyear, 
				adopmotherraceaitypekey, adopmotherraceasiantypekey, adopmotherraceblacktypekey, 
				adopmotherracehawaiiantypekey, adopmotherracewhitetypekey, adopmotherraceuntypekey, 
				adopmotherhispanictypekey, adopfatherraceaitypekey, adopfatherraceasiantypekey, 
				adopfatherraceblacktypekey, adopfatherracehawaiiantypekey, adopfatherracewhitetypekey, 
				adopfatherraceuntypekey, adopfatherhispanictypekey, adopparrelstepparenttypekey, 
				adopparrelotherreltypekey, adopparrelnonreltypekey, childplacedfromtypekey, childplacedbytypekey, 
				adoptionsubsidytypekey, subsidypaymentamount, iveadoptionflag, insertedon, insertedby, updatedon, 
				updatedby, activeflag, adopparrelfospartypekey, datavalidflag, old_id, clientid, etl_userid, 
				etl_load_date, a12_child_race_abandoned, a13_child_race_declined, a15_assistance_agreement_type, 
				agreement_start_date, a18_agreement_termination_date, a4_child_date_of_birth, adoption_gap_casetype,
				now(), v_afcars_history_id
			FROM cjams.afcarsadoptiondetail;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcarsadoptiondetail_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;

	
	ELSEIF vs_report_type = 'FC' THEN -- Fostercare
	
		select nextval('sq_afcars_history'::regclass) into v_afcars_history_id ;
	
		RAISE NOTICE 'FC - v_afcars_history_id >> %',v_afcars_history_id;
		
		-- afcarsfostercaresummary
		INSERT INTO cjams.afcarsfostercaresummary_history
			(	afcarsfostercaresummaryid, totalnorecords, periodendingdate, chunderoneyear, choneyear, chtwoyear, 
				chthreeyear, chfouryear, chfiveyear, chsixyear, chsevenyear, cheightyear, chnineyear, chtenyear, 
				chelevenyear, chtwelveyear, chthirteenyear, chfourteenyear, chfifteenyear, chsixteenyear, 
				chseventeenyear, cheighteenyear, chovereighteenyear, insertedon, insertedby, updatedon, updatedby, 
				activeflag, old_id, etl_userid, etl_load_date, history_insertedon, afcars_history_id
			)
		SELECT afcarsfostercaresummaryid, totalnorecords, periodendingdate, chunderoneyear, choneyear, chtwoyear, 
			chthreeyear, chfouryear, chfiveyear, chsixyear, chsevenyear, cheightyear, chnineyear, chtenyear, 
			chelevenyear, chtwelveyear, chthirteenyear, chfourteenyear, chfifteenyear, chsixteenyear, 
			chseventeenyear, cheighteenyear, chovereighteenyear, insertedon, insertedby, updatedon, updatedby, 
			activeflag, old_id, etl_userid, etl_load_date, now(), v_afcars_history_id
		FROM cjams.afcarsfostercaresummary;

		al_sqlcode := SQLCODE;
		IF al_sqlcode < 0 THEN
			as_mess := 'Error capturing data in the afcarsfostercaresummary_history table' ;
			al_sqlcode := -1;
		END IF ;

		
		IF al_sqlcode <> -1 Then
			-- afcarsfostercare_new
			INSERT INTO cjams.afcarsfostercare_new_history
				(	afcarsfostercareid, statetypekey, reportpdenddate, localagencytypekey, recordno, periodicreviewdate, 
					childdob, gendertypekey, raceaitypekey, raceasiantypekey, raceblacktypekey, racehawaiiantypekey, 
					racewhitetypekey, raceuntypekey, hispanictypekey, childdiagnosedtypekey, mentalretardationtypekey, 
					visualhearingtypekey, physicaldisabledtypekey, emotionaldisturbedtypekey, otherdiagnosedconditiontypekey, 
					childadoptedtypekey, ageadoptionlegalized, firstremovaldate, numremovals, lastdischargedate, 
					latestremovaldate, removaltransactiondate, placementdate, numplacement, removaltypetypekey, 
					physicalabuseflag, sexualabuseflag, neglectflag, paralcoholabuseflag, pardrugabuseflag, 
					childalcoholabuseflag, childdrugabuseflag, childdisabilityflag, childbehaviorflag, parentdeathflag, 
					parentincarcerationflag, caretakerillnessflag, abandonmentflag, relinquishmentflag, 
					inadequatehousingflag, placementsettingtypekey, outofstateplacementflag, caseplangoaltypekey, 
					caretakerfamilystructuretypekey, caretaker1birthyear, caretaker2birthyear, mothertprdate, 
					fathertprdate, fosterfamilystructuretypekey, fostercare1birthyear, fostercare2birthyear, 
					fostercare1raceaitypekey, fostercare1raceasiantypekey, fostercare1raceblacktypekey, 
					fostercare1racehawaiiantypekey, fostercare1racewhitetypekey, fostercare1raceuntypekey, 
					fostercare1hispanictypekey, fostercare2raceaitypekey, fostercare2raceasiantypekey, 
					fostercare2raceblacktypekey, fostercare2racehawaiiantypekey, fostercare2racewhitetypekey, 
					fostercare2raceuntypekey, fostercare2hispanictypekey, dischargedate, dischargetransactiondt, 
					dischargereasontypekey, ivefostercareflag, iveadoptionflag, ivaflag, ivdflag, xixflag, ssiorssaflag, 
					nofederalsupportflag, fostercarepaymentamt, insertedon, insertedby, updatedon, updatedby, activeflag, 
					fk_id, caseid, placementid, removalid, datavalidflag, old_id, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, statetypekey, reportpdenddate, localagencytypekey, recordno, periodicreviewdate, 
				childdob, gendertypekey, raceaitypekey, raceasiantypekey, raceblacktypekey, racehawaiiantypekey, 
				racewhitetypekey, raceuntypekey, hispanictypekey, childdiagnosedtypekey, mentalretardationtypekey, 
				visualhearingtypekey, physicaldisabledtypekey, emotionaldisturbedtypekey, otherdiagnosedconditiontypekey, 
				childadoptedtypekey, ageadoptionlegalized, firstremovaldate, numremovals, lastdischargedate, 
				latestremovaldate, removaltransactiondate, placementdate, numplacement, removaltypetypekey, 
				physicalabuseflag, sexualabuseflag, neglectflag, paralcoholabuseflag, pardrugabuseflag, 
				childalcoholabuseflag, childdrugabuseflag, childdisabilityflag, childbehaviorflag, parentdeathflag,
				parentincarcerationflag, caretakerillnessflag, abandonmentflag, relinquishmentflag, 
				inadequatehousingflag, placementsettingtypekey, outofstateplacementflag, caseplangoaltypekey, 
				caretakerfamilystructuretypekey, caretaker1birthyear, caretaker2birthyear, mothertprdate, 
				fathertprdate, fosterfamilystructuretypekey, fostercare1birthyear, fostercare2birthyear, 
				fostercare1raceaitypekey, fostercare1raceasiantypekey, fostercare1raceblacktypekey, 
				fostercare1racehawaiiantypekey, fostercare1racewhitetypekey, fostercare1raceuntypekey, 
				fostercare1hispanictypekey, fostercare2raceaitypekey, fostercare2raceasiantypekey, 
				fostercare2raceblacktypekey, fostercare2racehawaiiantypekey, fostercare2racewhitetypekey, 
				fostercare2raceuntypekey, fostercare2hispanictypekey, dischargedate, dischargetransactiondt, 
				dischargereasontypekey, ivefostercareflag, iveadoptionflag, ivaflag, ivdflag, xixflag, ssiorssaflag, 
				nofederalsupportflag, fostercarepaymentamt, insertedon, insertedby, updatedon, updatedby, activeflag, 
				fk_id, caseid, placementid, removalid, datavalidflag, old_id, now(), v_afcars_history_id
			FROM cjams.afcarsfostercare_new;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcarsfostercare_new_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcarscaresin
			INSERT INTO cjams.afcarscaresin_history
				(	id, cjamspid, cisid, removaldate, returndate, activeflag, insertedon, updatedon, updatedby, 
					insertedby, "extract", old_id, etl_userid, etl_load_date, history_insertedon, afcars_history_id
				)
			SELECT id, cjamspid, cisid, removaldate, returndate, activeflag, insertedon, updatedon, updatedby, 
				insertedby, "extract", old_id, etl_userid, etl_load_date, now(), v_afcars_history_id
			FROM cjams.afcarscaresin;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcarscaresin_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then	
			-- afcars_fc_adoptive_parents_info
			INSERT INTO cjams.afcars_fc_adoptive_parents_info_history
				(	afcarsfostercareid, recordno, removalid, e157_marital_status_of_adoptive_parents, 
					e158_relationship_to_adoptive_parents_relative, e159_relationship_to_adoptive_parents_kin, 
					e160_relationship_to_adoptive_parents_non_relative, 
					e161_relationship_to_adoptive_parents_foster_parent, e162_adoptive_parent1_birth_date, 
					e163_adoptive_parent1_tribal_membership, e164_adoptive_parent1_race_american_indian_alaska_native, 
					e165_adoptive_parent1_race_asian, e166_adoptive_parent1_race_black, 
					e167_adoptive_parent1_race_native_hawaiian_pacific_islander, e168_adoptive_parent1_race_white,
					e169_adoptive_parent1_race_unknown, e170_adoptive_parent1_race_declined, 
					e171_adoptive_parent1_hispanic_latino, e172_adoptive_parent1_sex, e173_adoptive_parent2_birth_date, 
					e174_adoptive_parent2_tribal_membership, e175_adoptive_parent2_race_american_indian_alaska_native, 
					e176_adoptive_parent2_race_asian, e177_adoptive_parent2_race_black, 
					e178_adoptive_parent2_race_native_hawaiian_pacific_islander, e179_adoptive_parent2_race_white, 
					e180_adoptive_parent2_race_unknown, e181_adoptive_parent2_race_declined, 
					e182_adoptive_parent2_hispanic_latino, e183_adoptive_parent2_sex, 
					e184_inter_intrajurisdictional_adoption, e185_assistance_agreement_type, 
					e186_siblings_in_adoptive_home, adoption_cjamspid, adoption_casenumber, cjamspid, caseid, 
					adoption_gap_casetype, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e157_marital_status_of_adoptive_parents, 
				e158_relationship_to_adoptive_parents_relative, e159_relationship_to_adoptive_parents_kin, 
				e160_relationship_to_adoptive_parents_non_relative, 
				e161_relationship_to_adoptive_parents_foster_parent, e162_adoptive_parent1_birth_date, 
				e163_adoptive_parent1_tribal_membership, e164_adoptive_parent1_race_american_indian_alaska_native, 
				e165_adoptive_parent1_race_asian, e166_adoptive_parent1_race_black, 
				e167_adoptive_parent1_race_native_hawaiian_pacific_islander, e168_adoptive_parent1_race_white, 
				e169_adoptive_parent1_race_unknown, e170_adoptive_parent1_race_declined, 
				e171_adoptive_parent1_hispanic_latino, e172_adoptive_parent1_sex, e173_adoptive_parent2_birth_date, 
				e174_adoptive_parent2_tribal_membership, e175_adoptive_parent2_race_american_indian_alaska_native, 
				e176_adoptive_parent2_race_asian, e177_adoptive_parent2_race_black, 
				e178_adoptive_parent2_race_native_hawaiian_pacific_islander, e179_adoptive_parent2_race_white, 
				e180_adoptive_parent2_race_unknown, e181_adoptive_parent2_race_declined, 
				e182_adoptive_parent2_hispanic_latino, e183_adoptive_parent2_sex, 
				e184_inter_intrajurisdictional_adoption, e185_assistance_agreement_type, 
				e186_siblings_in_adoptive_home, adoption_cjamspid, adoption_casenumber, cjamspid, caseid, 
				adoption_gap_casetype, now(), v_afcars_history_id
			FROM cjams.afcars_fc_adoptive_parents_info;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_adoptive_parents_info_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;

		
		IF al_sqlcode <> -1 Then
			-- afcars_fc_caseworker_visits
			INSERT INTO cjams.afcars_fc_caseworker_visits_history
				(	afcarsfostercareid, recordno, removalid, e151_case_worker_visit_date, 
					e152_case_worker_visit_location, progressnoteid, cjamspid, caseid, history_insertedon, 
					afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e151_case_worker_visit_date, 
				e152_case_worker_visit_location, progressnoteid, cjamspid, caseid, now(), 
				v_afcars_history_id
			FROM cjams.afcars_fc_caseworker_visits;
		
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_caseworker_visits_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;
		
		IF al_sqlcode <> -1 Then
			-- afcars_fc_child_removals
			INSERT INTO cjams.afcars_fc_child_removals_history
				(	afcarsfostercareid, recordno, e3_local_agency, e69_removal_date, e70_removal_transaction_date, 
					e71_removal_environment, e72_runaway, e73_whereabouts_unknown, e74_physical_abuse, e75_sexual_abuse, 
					e76_psychological_abuse, e77_neglect, e78_medical_neglect, e79_domestic_violence, e80_abandonment, 
					e81_failure_to_return, e82_caretaker_alcohol_use, e83_caretaker_drug_use, e84_child_alcohol_use, 
					e85_child_drug_use, e86_prenatal_alcohol_exposure, e87_prenatal_drug_exposure, 
					e88_diagnosed_condition, e89_inadequate_access_to_mental_health, 
					e90_inadequate_access_to_medical_service, e91_child_behavior_problem, e92_death_of_caretaker, 
					e93_incarceration_of_caretaker, e94_caretaker_impairment_physical_emotional, 
					e95_caretaker_impairment_cognitive, e96_inadequate_housing, e97_voluntary_adoption, 
					e98_child_requested_placement, e99_sex_trafficking, e100_parental_immigration_detainment_deportation, 
					e101_family_conflict_gender_orientation, e102_educational_neglect, 
					e103_public_agency_title_iv_agreement, e104_tribal_agreement, e105_homelessness, e153_exit_date, 
					e154_exit_transaction_date, e155_exit_reason, e156_transfer_to_another_agency, removalid, cjamspid, 
					caseid, current_period_removal_sw, bio_cjamspid, history_insertedon, afcars_history_id,
					removal_date, exit_date
				)
			SELECT afcarsfostercareid, recordno, e3_local_agency, e69_removal_date, e70_removal_transaction_date, 
					e71_removal_environment, e72_runaway, e73_whereabouts_unknown, e74_physical_abuse, e75_sexual_abuse, 
					e76_psychological_abuse, e77_neglect, e78_medical_neglect, e79_domestic_violence, e80_abandonment, 
					e81_failure_to_return, e82_caretaker_alcohol_use, e83_caretaker_drug_use, e84_child_alcohol_use, 
					e85_child_drug_use, e86_prenatal_alcohol_exposure, e87_prenatal_drug_exposure, 
					e88_diagnosed_condition, e89_inadequate_access_to_mental_health, 
					e90_inadequate_access_to_medical_service, e91_child_behavior_problem, e92_death_of_caretaker, 
					e93_incarceration_of_caretaker, e94_caretaker_impairment_physical_emotional, 
					e95_caretaker_impairment_cognitive, e96_inadequate_housing, e97_voluntary_adoption, 
					e98_child_requested_placement, e99_sex_trafficking, e100_parental_immigration_detainment_deportation, 
					e101_family_conflict_gender_orientation, e102_educational_neglect, 
					e103_public_agency_title_iv_agreement, e104_tribal_agreement, e105_homelessness, e153_exit_date, 
					e154_exit_transaction_date, e155_exit_reason, e156_transfer_to_another_agency, removalid, cjamspid, 
					caseid, current_period_removal_sw, bio_cjamspid, now(), v_afcars_history_id,
					removal_date, exit_date
			FROM cjams.afcars_fc_child_removals;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_child_removals_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;

		IF al_sqlcode <> -1 Then
			-- afcars_fc_client_data
			INSERT INTO cjams.afcars_fc_client_data_history
				(	afcarsfostercareid, recordno, cjamspid, e1_title_iv_agency, e2_report_date, e3_local_agency, 
					e4_child_record_number, e5_date_of_birth, e6_sex, e7_agency_made_inquiries, e8_tribal_membership, 
					e10_icwa, e11_icwa_date, e12_icwa_notification, e13_child_race_american_indian_alaska_native, 
					e14_child_race_asian, e15_child_race_black, e16_child_race_native_hawaiian_pacific_islander, 
					e17_child_race_white, e18_child_race_unknown, e19_child_race_abandoned, e20_child_race_declined, 
					e21_child_hispanic_latino, e22_health_assessment, e23_health_conditions, 
					e24_health_intellectual_disability, e25_health_autism_spectrum_disorder, 
					e26_health_visual_impairment, e27_health_hearing_impairment, e28_health_orthopedic_impairment, 
					e29_health_mental_disorder, e30_health_adhd_add, e31_health_serious_mental_disorder, 
					e32_health_developmental_delay, e33_health_developmental_disability, e34_health_other_condition, 
					e35_school_enrollment, e36_school_highest_completed, e37_school_special_education, e38_pregnant, 
					e39_fathered_or_bore_child, e40_child_and_children_together, e41_prior_adoption, 
					e42_prior_adoption_date, e43_prior_adoption_intercountry, e44_prior_guardianship, 
					e45_prior_guardianship_date, e46_support_assistance, e47_state_tribal_adoption_assistance, 
					e48_state_tribal_foster_care, e49_adoption_subsidy, e50_guardianship_assistance, 
					e51_tanf_assistance, e52_title_iv_b, e53_chafee_foster_program, e54_other_financial_support, 
					e55_foster_care_payment, e56_total_siblings, e57_siblings_in_foster_care, 
					e58_siblings_in_living_arrangement, e59_first_parent_birth_year, e60_second_parent_birth_year, 
					e61_tribal_membership_mother, e62_tribal_membership_father, e63_tpr_parent1, e64_tpr_parent2, 
					e65_tpr_petition_date_parent1, e66_tpr_petition_date_parent2, e67_tpr_date_parent1, 
					e68_tpr_date_parent2, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, cjamspid, e1_title_iv_agency, e2_report_date, e3_local_agency, 
					e4_child_record_number, e5_date_of_birth, e6_sex, e7_agency_made_inquiries, e8_tribal_membership, 
					e10_icwa, e11_icwa_date, e12_icwa_notification, e13_child_race_american_indian_alaska_native, 
					e14_child_race_asian, e15_child_race_black, e16_child_race_native_hawaiian_pacific_islander, 
					e17_child_race_white, e18_child_race_unknown, e19_child_race_abandoned, e20_child_race_declined, 
					e21_child_hispanic_latino, e22_health_assessment, e23_health_conditions, 
					e24_health_intellectual_disability, e25_health_autism_spectrum_disorder, 
					e26_health_visual_impairment, e27_health_hearing_impairment, e28_health_orthopedic_impairment, 
					e29_health_mental_disorder, e30_health_adhd_add, e31_health_serious_mental_disorder, 
					e32_health_developmental_delay, e33_health_developmental_disability, e34_health_other_condition, 
					e35_school_enrollment, e36_school_highest_completed, e37_school_special_education, e38_pregnant, 
					e39_fathered_or_bore_child, e40_child_and_children_together, e41_prior_adoption, 
					e42_prior_adoption_date, e43_prior_adoption_intercountry, e44_prior_guardianship, 
					e45_prior_guardianship_date, e46_support_assistance, e47_state_tribal_adoption_assistance, 
					e48_state_tribal_foster_care, e49_adoption_subsidy, e50_guardianship_assistance, 
					e51_tanf_assistance, e52_title_iv_b, e53_chafee_foster_program, e54_other_financial_support, 
					e55_foster_care_payment, e56_total_siblings, e57_siblings_in_foster_care, 
					e58_siblings_in_living_arrangement, e59_first_parent_birth_year, e60_second_parent_birth_year, 
					e61_tribal_membership_mother, e62_tribal_membership_father, e63_tpr_parent1, e64_tpr_parent2, 
					e65_tpr_petition_date_parent1, e66_tpr_petition_date_parent2, e67_tpr_date_parent1, 
					e68_tpr_date_parent2, now(), v_afcars_history_id
			FROM cjams.afcars_fc_client_data;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_client_data_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_periodic_reviews
			INSERT INTO cjams.afcars_fc_periodic_reviews_history
				(	afcarsfostercareid, recordno, removalid, e149_periodic_review_date, 
					intakeservicerequestcourthearingid, cjamspid, caseid, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e149_periodic_review_date, 
				intakeservicerequestcourthearingid, cjamspid, caseid, now(), v_afcars_history_id
			FROM cjams.afcars_fc_periodic_reviews;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_periodic_reviews_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_permanency_hearings
			INSERT INTO cjams.afcars_fc_permanency_hearings_history
				(	afcarsfostercareid, recordno, removalid, e150_permanency_hearing_date, 
					intakeservicerequestcourthearingid, cjamspid, caseid, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e150_permanency_hearing_date, 
				intakeservicerequestcourthearingid, cjamspid, caseid, now(), v_afcars_history_id
			FROM cjams.afcars_fc_permanency_hearings;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_permanency_hearings_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_permanency_plans
			INSERT INTO cjams.afcars_fc_permanency_plans_history
				(	afcarsfostercareid, recordno, removalid, e147_permanency_plan_date, e148_permanency_plan_type, 
					permanencyplanid, cjamspid, caseid, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e147_permanency_plan_date, e148_permanency_plan_type,
				permanencyplanid, cjamspid, caseid, now(), v_afcars_history_id
			FROM cjams.afcars_fc_permanency_plans;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_permanency_plans_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_placements
			INSERT INTO cjams.afcars_fc_placements_history
				(	afcarsfostercareid, recordno, removalid, e112_date_living_arrangement, e113_foster_family_home, 
					e114_licensed_home, e115_therapeutic_home, e116_shelter_care_home, e117_relative_foster_family, 
					e118_pre_adopt_home, e119_kin_foster_family, e120_other_living_arrangement_type, 
					e121_location_of_living_arrangement, e122_jurisdiction_or_country, 
					e123_marital_status_of_foster_parents, e124_relationship_to_foster_parents, 
					e125_foster_parent1_birth_year, e126_foster_parent1_tribal_membership, 
					e127_foster_parent1_race_american_indian_alaska_native, e128_foster_parent1_race_asian, 
					e129_foster_parent1_race_black, e130_foster_parent1_race_native_hawaiian_pacific_islander, 
					e131_foster_parent1_race_white, e132_foster_parent1_race_unknown, e133_foster_parent1_race_declined, 
					e134_foster_parent1_hispanic_latino, e135_foster_parent1_sex, e136_foster_parent2_birth_year, 
					e137_foster_parent2_tribal_membership, e138_foster_parent2_race_american_indian_alaska_native, 
					e139_foster_parent2_race_asian, e140_foster_parent2_race_black, 
					e141_foster_parent2_race_native_hawaiian_pacific_islander, e142_foster_parent2_race_white, 
					e143_foster_parent2_race_unknown, e144_foster_parent2_race_declined, 
					e145_foster_parent2_hispanic_latino, e146_foster_parent2_sex, placementid, cjamspid, caseid, 
					placementtype, placementcpahomeid, history_insertedon, afcars_history_id, start_date, 
					placementsubtype, original_removalid
				)
			SELECT afcarsfostercareid, recordno, removalid, e112_date_living_arrangement, e113_foster_family_home, 
				e114_licensed_home, e115_therapeutic_home, e116_shelter_care_home, e117_relative_foster_family, 
				e118_pre_adopt_home, e119_kin_foster_family, e120_other_living_arrangement_type, 
				e121_location_of_living_arrangement, e122_jurisdiction_or_country, 
				e123_marital_status_of_foster_parents, e124_relationship_to_foster_parents, 
				e125_foster_parent1_birth_year, e126_foster_parent1_tribal_membership, 
				e127_foster_parent1_race_american_indian_alaska_native, e128_foster_parent1_race_asian, 
				e129_foster_parent1_race_black, e130_foster_parent1_race_native_hawaiian_pacific_islander, 
				e131_foster_parent1_race_white, e132_foster_parent1_race_unknown, e133_foster_parent1_race_declined, 
				e134_foster_parent1_hispanic_latino, e135_foster_parent1_sex, e136_foster_parent2_birth_year, 
				e137_foster_parent2_tribal_membership, e138_foster_parent2_race_american_indian_alaska_native, 
				e139_foster_parent2_race_asian, e140_foster_parent2_race_black, 
				e141_foster_parent2_race_native_hawaiian_pacific_islander, e142_foster_parent2_race_white, 
				e143_foster_parent2_race_unknown, e144_foster_parent2_race_declined, 
				e145_foster_parent2_hispanic_latino, e146_foster_parent2_sex, placementid, cjamspid, caseid, 
				placementtype, placementcpahomeid, now(), v_afcars_history_id, start_date, 
				placementsubtype, original_removalid
			FROM cjams.afcars_fc_placements;

			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_placements_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_recognized_tribes
			INSERT INTO cjams.afcars_fc_recognized_tribes_history
				(	
					afcarsfostercareid, recordno, cjamspid, e9_recognized_tribes, history_insertedon, afcars_history_id 
				)
			SELECT afcarsfostercareid, recordno, cjamspid, e9_recognized_tribes, now(), v_afcars_history_id
			FROM cjams.afcars_fc_recognized_tribes;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_recognized_tribes_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;


		IF al_sqlcode <> -1 Then
			-- afcars_fc_sex_trafficking
			INSERT INTO cjams.afcars_fc_sex_trafficking_history
				(	afcarsfostercareid, recordno, removalid, e106_prior_victim_sex_trafficking, 
					e107_prior_victim_sex_trafficking_reported, e108_prior_victim_sex_trafficking_reported_date, 
					e109_victim_sex_trafficking, e110_victim_sex_trafficking_reported, 
					e111_victim_sex_trafficking_reported_date, cjamspid, caseid, history_insertedon, afcars_history_id
				)
			SELECT afcarsfostercareid, recordno, removalid, e106_prior_victim_sex_trafficking, 
				e107_prior_victim_sex_trafficking_reported, e108_prior_victim_sex_trafficking_reported_date, 
				e109_victim_sex_trafficking, e110_victim_sex_trafficking_reported, 
				e111_victim_sex_trafficking_reported_date, cjamspid, caseid, now(), v_afcars_history_id
			FROM cjams.afcars_fc_sex_trafficking;
			
			al_sqlcode := SQLCODE;
			IF al_sqlcode < 0 THEN
				as_mess := 'Error capturing data in the afcars_fc_sex_trafficking_history table' ;
				al_sqlcode := -1;
			END IF ;
		END IF ;

	ELSE
		as_mess := 'Invalid Report Type.';	
	END IF;
	
	if al_sqlcode <> 0 then 
		rollback; 
	else
		al_sqlcode := 0 ;	
	end if;	

END;

$function$
;


