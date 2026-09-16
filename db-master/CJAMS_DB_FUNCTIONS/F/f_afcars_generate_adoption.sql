DROP FUNCTION if exists cjams.f_afcars_generate_adoption(character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.f_afcars_generate_adoption(vdt_from character varying, vdt_to character varying, OUT vl_output_sqlcode integer, OUT vs_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Description     : Stored Procedure to generate AFCARS Adoption Data

-- Revision(s):
-- 10/22/2020 - Vineet Tirodkar
-- Modifications to CASE_CLIENS_CUR for adding condition Adoption Case start date between reporting period 
-- and to removing some filter conditions (userprofile & other tables).
-- 07/16/2021 - Vineet Tirodkar - Modifications for DB 10.8 upgrade - Order by & Distinct Issue - B-107196
-- 10/21/2022 - Vineet Tirodkar - Modifications to fix Element 37 for Afcars Adoption Eligibilty Status (CIDM-5893)
-- 10/28/2022 - Vineet Tirodkar - Modifications to fix Element 34 for Afcars Child was placed by (CIDM-5960)
-- 02/13/2023 - Vineet Tirodkar - Modifications for AFCARS 2.0 (CIDM-6942)
-- 10/27/2023 - Vineet Tirodkar - Modification to include adoption subsidies in effect at some point during the current report period (CIDM-8011)
-- 04/18/2024 - Vineet Tirodkar - Modification to include GAP cases and changes to Element 19 Placing Agency (CIDM-8193)
--				 	              To add Migrated cases with Bio case in the system & Private Adoption Cases.  		
-- 04/22/2025 - Vineet Tirodkar - To fix 2025A Non-compliance errors (CIDM-10422)
--				1) A6_to_A13_declined_inconsistency If A13_child_race_declined = 1 (Yes), data elements A6-A12 must all be 0 (No).
------------------------------------------------------------------------

DECLARE VS_OUTPUT_STATE CHAR(5) DEFAULT '00000';

VL_EXCEP_MESSAGE VARCHAR;
VS_STATE_CD VARCHAR(2) DEFAULT '24';
VS_USER_ID VARCHAR(10) DEFAULT 'interface';
VL_PLACEMENT_ID INTEGER DEFAULT 0;
VL_CLIENT_ID INTEGER DEFAULT 0;
VL_MOTHER_PID Varchar DEFAULT   0;
VL_ADOP_CASENUMBER BIGINT DEFAULT 0;
VL_STAFF_ID INTEGER DEFAULT 0;
VDT_HEARING_DT DATE;
VDT_CASE_REVIEW_DT DATE;
VD_ADOPT_DOB_DT DATE;
VS_SEX_CD VARCHAR(5);
VS_PRIMARY_RACE_CD VARCHAR(5);
VS_PERIOD_SEND VARCHAR(6);
VS_PREV_PERIOD VARCHAR(6);
VS_SECONDARY_RACE_CD VARCHAR(5);
VS_ADOP_HISPANIC_CD VARCHAR(5);
VS_MENTAL_CD VARCHAR(5) DEFAULT '';
VS_VISUAL_CD VARCHAR(5) DEFAULT '';
VS_HEARING_CD VARCHAR(5) DEFAULT '';
VS_PHYSICAL_CD VARCHAR(5) DEFAULT '';
VS_EMOTION_CD VARCHAR(5) DEFAULT '';
VS_OTHER_CD VARCHAR(5) DEFAULT '';
VS_DUMMY_DIAGNOSED_CD VARCHAR(1);
VS_MENTALLY_RETRADED_SW VARCHAR(1);
VS_PREV_ADOPTION_AGE_CD VARCHAR(5) DEFAULT NULL;
VS_PROVIDER_TYPE VARCHAR(5) DEFAULT NULL;
VL_PLACEMENT_STRUCTURE_ID INTEGER DEFAULT 0;
VN_PROVIDER_APPROVAL_ID INTEGER DEFAULT 0;
VN_PREV_PROVIDER_APPROVAL_ID INTEGER DEFAULT 0;
VL_EXCEP_FLAG INTEGER;
VL_COUNT INTEGER DEFAULT 0;
VL_CNT INTEGER DEFAULT 0;
VL_INTERFACES_ERROR_LOG_ID INTEGER DEFAULT 0;
VL_LENGTH INTEGER DEFAULT 0;
VS_YEAR VARCHAR(4) DEFAULT NULL;
VS_MONTH VARCHAR(2) DEFAULT NULL;
VS_DAY VARCHAR(2) DEFAULT NULL;
VDT_YEAR_MNTH_DAY VARCHAR DEFAULT NULL;
VDT_YEAR_YEAR_DAY VARCHAR;
VS_YEAR_MNTH_DAY VARCHAR(10) DEFAULT NULL;
VL_PROVIDER_ID INTEGER DEFAULT 0;
VS_CODE VARCHAR(5) DEFAULT NULL;
VL_TEMP_CLIENT_ID INTEGER DEFAULT 0;
VL_FINAL_AMOUNT INTEGER DEFAULT 0;
VL_RC_CODE INTEGER DEFAULT 0;
VN_APP_PER_ID INTEGER;
VL_AFCARS_ADOPTION_ID INTEGER DEFAULT 0;
VS_REPORT_PD_END_DT VARCHAR(6);
VS_SUBMITTED_PERIOD VARCHAR(6);
VS_ACTUAL_PERIOD VARCHAR(6);
VS_RECORD_NO VARCHAR(12);
VS_PERIODIC_REVIEW_DT VARCHAR(8) DEFAULT NULL;
VS_AGENCY_INVOLVEMENT_CD VARCHAR(1) DEFAULT '1';
VS_CHILD_DOB VARCHAR(10);
VS_GENDER_CD VARCHAR(5);
VS_RACE_AI_CD VARCHAR(5) DEFAULT '';
VS_RACE_ASIAN_CD VARCHAR(5) DEFAULT '';
VS_RACE_BLACK_CD VARCHAR(5) DEFAULT '';
VS_RACE_HAWAIIAN_CD VARCHAR(5) DEFAULT '';
VS_RACE_WHITE_CD VARCHAR(5) DEFAULT '';
VS_RACE_UN_CD VARCHAR(5) DEFAULT '';
VS_HISPANIC_CD VARCHAR(5) DEFAULT '3';
VS_SPECIAL_NEEDS_CD VARCHAR(1) DEFAULT '';
VS_PRIMARY_BASIS_CD VARCHAR(5) DEFAULT '';
VS_PRIM_SPL_NEED VARCHAR(5) DEFAULT '';
VS_MENTAL_RETARDATION_CD VARCHAR(5) DEFAULT '0';
VS_VISUAL_HEARING_CD VARCHAR(5) DEFAULT '0';
VS_PHYSICAL_DISABLED_CD VARCHAR(5) DEFAULT '0';
VS_EMOTIONAL_DISTURBED_CD VARCHAR(5) DEFAULT '0';
VS_OTHER_DIAGNOSED_CONDITION_CD VARCHAR(5) DEFAULT '0';
VS_BMOTHER_BIRTH_YEAR VARCHAR(4);
VS_BFATHER_BIRTH_YEAR VARCHAR(4);
VS_MOTHER_MARRIED_AT_BIRTH_CD VARCHAR(1) DEFAULT '3';
VS_MOTHER_TPR_DT VARCHAR(10);
VS_FATHER_TPR_DT VARCHAR(10);
VS_ADOPTION_FINALIZED_DT VARCHAR(10);
VS_ADOP_FAMILY_STRUCTURE_CD VARCHAR(40) DEFAULT '';
VS_FAMILY_STRUCTURE_CD VARCHAR(5) DEFAULT '';
VS_ADOP_MOTHER_BIRTH_YEAR VARCHAR(4) ;
VS_ADOP_FATHER_BIRTH_YEAR VARCHAR(4) ;
VS_ADOP_MOTHER_RACE_AI_CD VARCHAR(5) ;
VS_ADOP_MOTHER_RACE_ASIAN_CD VARCHAR(5) ;
VS_ADOP_MOTHER_RACE_BLACK_CD VARCHAR(5) ;
VS_ADOP_MOTHER_RACE_HAWAIIAN_CD VARCHAR(5) ;
VS_ADOP_MOTHER_RACE_WHITE_CD VARCHAR(5) ;
VS_ADOP_MOTHER_RACE_UN_CD VARCHAR(5) ;
VS_ADOP_MOTHER_HISPANIC_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_AI_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_ASIAN_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_BLACK_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_HAWAIIAN_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_WHITE_CD VARCHAR(5) ;
VS_ADOP_FATHER_RACE_UN_CD VARCHAR(5) ;
VS_ADOP_FATHER_HISPANIC_CD VARCHAR(5) ;
VS_ADOP_PAR_REL_STEPPARENT_CD VARCHAR(5) DEFAULT '';
VS_ADOP_PAR_REL_OTHERREL_CD VARCHAR(5) DEFAULT '';
VS_ADOP_PAR_REL_FOSPAR_CD VARCHAR(5) DEFAULT '';
VS_ADOP_PAR_REL_NONREL_CD VARCHAR(5) DEFAULT '';
VS_CHILD_PLACED_FROM_CD VARCHAR(5) DEFAULT '';
VS_CHILD_PLACED_BY_CD VARCHAR(5) DEFAULT '';
VS_ADOPTION_SUBSIDY_CD VARCHAR(5) DEFAULT '2';
VS_SUBSIDY_PAYMENT_AMT VARCHAR(5) DEFAULT '00000';
VS_IV_E_ADOPTION_SW VARCHAR(1) DEFAULT '';
VS_ADOP_GENDER_CD VARCHAR(5) DEFAULT NULL;
VL_ADOP_PLAN_ID character varying;
VS_PREV_FAMILY_STRUC VARCHAR(5) DEFAULT NULL;
VS_PREV_GENDER_CD VARCHAR(5) DEFAULT NULL;
VS_MOTHER_PRIMARY_RACE_CD VARCHAR(5) DEFAULT NULL;
VN_NUM INTEGER;
vs_client_encrypt_id VARCHAR(15) DEFAULT '0';
VS_CIS_CLIENT_ID VARCHAR(12);
VN_CNT INTEGER DEFAULT 0;
VL_MOTHER_ID INTEGER DEFAULT 0;
VL_FATHER_ID INTEGER DEFAULT 0;
VL_RUNTIME_ID INTEGER DEFAULT 0;
VN_RPT_SENT_MTH INTEGER DEFAULT 0;
VN_RPE_SENT_YEAR INTEGER DEFAULT 0;
VD_RPT_SENT_DT DATE DEFAULT NULL;
VN_SENT_DAY INTEGER;
VD_ADOPT_FATHER_DOB_DT DATE DEFAULT NULL;
VD_ADOPT_MOTHER_DOB_DT DATE DEFAULT NULL;
VS_FATHER_PRIMARY_RACE_CD VARCHAR(5) DEFAULT NULL;
VI_SUMMARY_ID bigint;
VI_ACTUAL_CNT INTEGER DEFAULT 0;
VD_ADOPTION_FINALIZED_DT DATE;
VS_ADOPTION_FINALIZED_DT1 VARCHAR(20);
VS_PICKLIST_VALUE_CD record;

V_PLACEMENTID character varying;    
VL_ADOP_CASE_ID character varying;
VL_SERVICECASEID character varying;
vs_gendertypekey  character varying;
v_stepparentcount integer;
 
v_otherrelativecount integer;  -- RELOTHR
v_fosterparentcount integer; -- FSTRFTHR , FSTRMTHR
v_othercount integer; -- OTHER
VL_FATHER_PID	varchar;--
VL_ADOP_PARENT_ID	varchar;--
VL_ADOP_PARENT1_ID  varchar;
VL_ADOP_PARENT2_ID 	varchar;--
VL_Family_structure 	varchar;--
VL_Eligibility_status	varchar;--
VL_step_parent 			varchar;--
VL_other_rel			integer;--
VL_Other_rel_prov		varchar;--
VL_parent1_prov			varchar;
VL_parent2_prov			varchar;--
VL_Adop_prov_id			integer;--
VL_approval_personid	integer;--
VL_Post_Adopt_ID 		integer;--
VL_PARENT_COUNT 		integer;
VL_INTAKE_ACTOR_ID		VARCHAR;

vs_A12_child_race_abandoned character varying;
vs_A13_child_race_declined character varying;
vs_A15_assistance_agreement_type character varying;
vs_Agreement_Start_date character varying;
vs_A18_agreement_termination_date character varying;
vs_A4_child_date_of_birth character varying;

vl_record_count 		Bigint default 0;

vl_gap_output_sqlcode integer;
vs_gap_message character varying;
			
DECLARE CASE_CLIENS_CUR CURSOR FOR 
	SELECT DISTINCT adoptioncasenumber,
			adoptionplanningid,
			cjamspid, 
			cjamspid1, 
			adoptioncaseid ,  
		   servicecaseid FROM 
		(WITH cte as (
				select 	distinct   ac.adoptioncasenumber, 
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
						/*	
						join routing ru on ru.objectid = ac.adoptioncaseid::character varying 
							and ru.eventcode = 'ADPC' 
							and ru.toroleid = 'CWCW'
						join userprofile up on up.securityusersid = ru.tosecurityusersid 
							and up.activeflag = 1
						join userprofileaddress upa on upa.securityusersid = up.securityusersid
						join tb_picklist_values tpvp on lower(replace(tpvp.value_tx,' ','')) = lower(replace(upa.county,' ',''))
						*/
				WHERE 	ac.activeflag = 1 
						and (
								-- 03/21/2024
								/* 
								( 	abl.finalizationdate::date IS NOT NULL 
									and abl.finalizationdate::date >= vdt_from::DATE 
									and abl.finalizationdate::date <= vdt_to::DATE 	
								)
								or
								*/
								( -- Active Adoption CIDM-8011
									ac.startdate::date <= vdt_to::DATE
									and ac.enddate::date >= vdt_from::DATE 
									-- 03/21/2024
									-- and abl.finalizationdate::date IS NOT NULL 
									-- and abl.finalizationdate::date <= vdt_to::DATE 
									and (	case when abl.finalizationdate is null then 
												true
											else	
												abl.finalizationdate::date <= vdt_to::DATE 
											end
										)
								)	
							)	
						/*	
						-- Suspended before reporting period start date
						and (select count(*)
								from adoptioncasesuspension acs
							  where acs.adoptioncaseid = ac.adoptioncaseid
								and acs.suspensionbegindate < vdt_from::DATE 
								and acs.suspensionenddate is null
								and acs.activeflag = 1
								and coalesce(acs.approvalstatustypekey, '') = '3047'
							 ) = 0	
						*/	 
--						and tpvp.category_tx IN ('003','043')	
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
						/*	
						join routing ru on ru.objectid = ac.adoptioncaseid::character varying 
							and ru.eventcode = 'ADPC' 
							and ru.toroleid = 'CWCW'
						join userprofile up on up.securityusersid = ru.tosecurityusersid 
							and up.activeflag = 1
						join userprofileaddress upa on upa.securityusersid = up.securityusersid
						join tb_picklist_values tpvp on lower(replace(tpvp.value_tx,' ','')) = lower(replace(upa.county,' ',''))
						*/
				WHERE 	ac.activeflag = 1 
						and (	
								-- 03/21/2024
								/*
								(	abl.finalizationdate::date IS NOT NULL 
									and abl.finalizationdate::date >= vdt_from::DATE 
									and abl.finalizationdate::date <= vdt_to::DATE
								)
								or
								*/
								( -- Active Adoption CIDM-8011
									ac.startdate::date <= vdt_to::DATE
									and ac.enddate::date >= vdt_from::DATE 
									-- 03/21/2024
									-- and abl.finalizationdate::date IS NOT NULL 
									-- and abl.finalizationdate::date <= vdt_to::DATE 
									and (	case when abl.finalizationdate is null then 
												true
											else	
												abl.finalizationdate::date <= vdt_to::DATE 
											end
										)
								)
							)
						/*	
						-- Suspended before reporting period start date
						and (select count(*)
								from adoptioncasesuspension acs
							  where acs.adoptioncaseid = ac.adoptioncaseid
								and acs.suspensionbegindate < vdt_from::DATE 
								and acs.suspensionenddate is null
								and acs.activeflag = 1
								and coalesce(acs.approvalstatustypekey, '') = '3047'
							 ) = 0								
						*/	
				UNION		
				-- Migrated cases with Bio case in the system & Private Adoption Cases
				select 	distinct  ac.adoptioncasenumber, 
					null::uuid as adoptionplanningid,
					null::bigint as cjamspid, 
					pr.cjamspid as cjamspid1, 
					ac.adoptioncaseid ,  
					null::uuid as servicecaseid,
					- 3 as caseorder 
				from adoptioncase ac
					join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
						and aca.actortypekey in ( 'CHILD', 'PVTADPCHILD')
					join person pr on pr.personid = aca.personid 
						and pr.activeflag = 1
				where ac.activeflag = 1
					and ac.startdate::date <= vdt_to::DATE
					and ac.enddate::date >= vdt_from::DATE 
					and (select count(*)
							from adoptioncase ac1 
								join adoptioncaseactor aca on aca.adoptioncaseid = ac1.adoptioncaseid 
									and aca.actortypekey in ( 'CHILD', 'PVTADPCHILD')
								join person pr on pr.personid = aca.personid 
									and pr.activeflag = 1 
								join adoptionplanning ap on ac.adoptionplanningid = ap.adoptionplanningid 
									and ap.activeflag = 1
								join adoptionbreakthelink abl ON abl.adoptionplanningid = ap.adoptionplanningid
								join person p on p.personid = aca.personid 
									and p.activeflag = 1
							WHERE ac1.adoptioncaseid = ac.adoptioncaseid 
								and ac1.activeflag = 1 
						) = 0 	
					and (select count(*)
							from adoptioncase ac1 
								join adoptionlink al on al.adoptioncaseid = ac1.adoptioncaseid
								join adoptioncaseactor aca on aca.adoptioncaseid = ac.adoptioncaseid 
									and aca.actortypekey in ( 'CHILD', 'PVTADPCHILD')
								join person pr on pr.personid = aca.personid 
									and pr.activeflag = 1 
								join biologicaladoptionlink bol on al.preadoptionclientid = bol.preadoptiveclientid
								join adoptionbreakthelink abl ON abl.adoptionplanningid = bol.preadoptivecaseid
								join person pa on pa.personid = BOL.preadoptiveclientid 
									and pa.activeflag = 1
							WHERE ac1.activeflag = 1 
								and ac1.adoptioncaseid =  ac.adoptioncaseid
						) = 0					
						
				)	
--							and tpvp.category_tx IN ('003','043'))
			SELECT adoptioncasenumber, adoptionplanningid, cjamspid, cjamspid1, adoptioncaseid, servicecaseid,
					LAG(adoptioncasenumber,1) OVER (order by adoptioncasenumber, caseorder) as prevadoptioncasenumber
					FROM cte) a
	WHERE CASE WHEN adoptioncasenumber = prevadoptioncasenumber THEN false else true end
		-- Unit Testing
		-- and cjamspid1 in (1062593, 1073027, 2032290, 2411780, 2439752, 3877233, 2155101, 3032377, 1152074, 3148841 )
	;
						
BEGIN 
	RAISE NOTICE 'ADOPTION PROCESS START';
	
	if (select count(*) from afcarsadoptiondetail) > 0 
			then truncate afcarsadoptiondetail;
		end if ;
          
       select nextval('sq_afcares_adoption_summary')::int into VI_SUMMARY_ID;
       
       insert into afcarsadoptionsummary values (VI_SUMMARY_ID,vdt_to,now(),now(),now(),'AFCARS',now(),'AFCARS',1,null);
       
       
    OPEN CASE_CLIENS_CUR;

    << CASE_CLIENS_CUR >>
	
    LOOP FETCH CASE_CLIENS_CUR INTO 	VL_ADOP_CASENUMBER, 
										VL_ADOP_PLAN_ID , 
										VL_CLIENT_ID,
										VL_Post_Adopt_ID, 
										VL_ADOP_CASE_ID,
										VL_SERVICECASEID;
 
             
		EXIT WHEN NOT FOUND;
		
		vl_record_count := vl_record_count + 1 ;
		
		RAISE NOTICE 'vl_record_count %'      , vl_record_count;
		RAISE NOTICE 'VL_ADOP_CASENUMBER %', VL_ADOP_CASENUMBER; 
		-- RAISE NOTICE 'VL_ADOP_PLAN_ID %'   , VL_ADOP_PLAN_ID; 
		RAISE NOTICE 'VL_CLIENT_ID %'      , VL_CLIENT_ID;
		-- RAISE NOTICE 'VL_ADOP_CASE_ID %'   , VL_ADOP_CASE_ID;
		-- RAISE NOTICE 'VL_SERVICECASEID %'  , VL_SERVICECASEID;
		
		
		-- Migrated cases with Bio case in the system & Private Adoption Cases 
		if VL_CLIENT_ID is null then
			VL_CLIENT_ID := VL_Post_Adopt_ID;
		end if;
		
		if VL_SERVICECASEID is null then
			VL_SERVICECASEID := VL_ADOP_CASE_ID;
		end if;
		
		VL_EXCEP_FLAG:=0;--
		
	----------------------------- element 2-----------------------------

		
		VS_YEAR := SUBSTRING (vdt_to,1,4);
		VS_MONTH := SUBSTRING( vdt_to,6,2);
		VS_REPORT_PD_END_DT := LTRIM(VS_YEAR) ||  LTRIM(VS_MONTH);--09-30 

		-- Raise notice 'Element #2  VS_REPORT_PD_END_DT%', VS_REPORT_PD_END_DT;--


	----------------------------- element 3------------------------------
		BEGIN 
			
			-- Raise notice 'Client ID encryption ';
			
			SELECT F_AFCARS_ENCRYPTV1(VL_Post_Adopt_ID::varchar) INTO VS_RECORD_NO;
		
				EXCEPTION WHEN OTHERS THEN 
					VL_EXCEP_FLAG:= 1 ;--
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
					VS_MESSAGE := ' ELEMENT 3 CLIENT ID ECNCRYPTION FAILED';--
					RETURN;--
		END;--

	----------------------elements 5 to 8-------------------------------
		
		BEGIN 
		
			SELECT	case 	when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AI%'   ) > 0 then '1' 
								when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AN%' ) > 0 then '1' 
								else '0' 
						end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AS%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%BA%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%WH%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%PI%') > 0 then '1' else '0' end,
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%UN%'   ) > 0 then '1' 
							when COUNT(*) FILTER (WHERE pr.racetypekey  like '%DC%' ) > 0 then '1' 
							else '0' 
						end
				INTO 	VS_RACE_AI_CD,
						VS_RACE_ASIAN_CD,
						VS_RACE_BLACK_CD,
						VS_RACE_WHITE_CD,
						VS_RACE_HAWAIIAN_CD,
						VS_RACE_UN_CD
				FROM 	personracetypemap  pr
				WHERE 	pr.personid = ( select p.personid from person p where p.cjamspid=VL_Post_Adopt_ID)
				AND pr.activeflag = 1;
			
		
			SELECT  EXTRACT(MONTH FROM dob) AS DOBMONTH, 
				EXTRACT(YEARS FROM dob) AS DOBYEAR, 
				AFC.afcars_ref_cd as gendertype, 
				CASE WHEN pp.ethnicgrouptypekey = 'H' THEN '1'
					WHEN pp.ethnicgrouptypekey = 'X' THEN '2'
					WHEN pp.ethnicgrouptypekey = 'U' THEN '3'
					else '3'
				END,
				(dob::date)::character varying
		INTO 	VDT_YEAR_MNTH_DAY, 
				VDT_YEAR_YEAR_DAY, 
				VS_GENDER_CD, 
				VS_HISPANIC_CD,
				vs_A4_child_date_of_birth
		FROM 	person PP 
				LEFT JOIN afcars_ref_code afc on afc.afcars_ref_type = 'sex' and PP.gendertypekey = afc.cjams_cd and AFC.activeflag = 1 
		WHERE 	PP.cjamspid = VL_Post_Adopt_ID 
				and PP.activeflag = 1;
					
		IF (VS_RACE_AI_CD = '0' AND 
				VS_RACE_ASIAN_CD = '0' AND 
				VS_RACE_BLACK_CD = '0' AND  
				VS_RACE_HAWAIIAN_CD = '0' AND  
				VS_RACE_WHITE_CD = '0') THEN
				VS_RACE_UN_CD = '1';  
		END IF;		
		
		IF (VS_RACE_AI_CD = '1' OR 
				VS_RACE_ASIAN_CD = '1' OR 
				VS_RACE_BLACK_CD = '1' OR  
				VS_RACE_HAWAIIAN_CD = '1' OR  
				VS_RACE_WHITE_CD = '1') THEN
				VS_RACE_UN_CD = '0';  
		END IF;
				 
		VS_CHILD_DOB := VDT_YEAR_MNTH_DAY || VDT_YEAR_YEAR_DAY;

		--	raise notice ' VS_RACE_AI_CD %', VS_RACE_AI_CD;--
		--	raise notice ' VS_RACE_ASIAN_CD %', VS_RACE_ASIAN_CD;--
		--	raise notice ' VS_RACE_BLACK_CD %', VS_RACE_BLACK_CD;--
		--	raise notice ' VS_RACE_HAWAIIAN_CD %', VS_RACE_HAWAIIAN_CD;--
		--	raise notice ' VS_RACE_WHITE_CD %', VS_RACE_WHITE_CD;--
		--	raise notice ' VS_RACE_UN_CD %', VS_RACE_UN_CD;--
		--	raise notice ' VS_CHILD_DOB %', VS_CHILD_DOB;--
		--	raise notice ' VS_HISPANIC_CD %', VS_HISPANIC_CD;--
				
		EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 5 to 8 FAILED';--
						RETURN;--

		END;--


	--------------------------------- Elements 9, 10------------------------------------

		BEGIN 
			
			select 
				(case when AAR.specialneedtypekey = 'ADBG' then '1'
					  when AAR.specialneedtypekey = 'ADAG' then '2' 
					  when AAR.specialneedtypekey = 'ADMS' then '3' 
					  when AAR.specialneedtypekey = 'ADDA' then '4'  
				 else '5' end),
				case when AAR.isspeacialneeds is null then '2'
						 when AAR.isspeacialneeds = 2 then '2'
						  when AAR.isspeacialneeds = 1 then '1'
					end
			into VS_PRIMARY_BASIS_CD, VS_SPECIAL_NEEDS_CD
			from 
			  adoptioncaseagreementrate AAR,
			  adoptioncaseagreement AA, 
			  adoptioncase AC 
			where 
			  AAR.adoptionagreementid = AA.adoptionagreementid
			  AND AA.adoptioncaseid = AC.adoptioncaseid
			  AND AC.adoptioncasenumber = VL_ADOP_CASENUMBER::character varying  LIMIT 1;
			  
		--		raise notice ' VS_PRIMARY_BASIS_CD %', VS_PRIMARY_BASIS_CD;--
		--		raise notice ' VS_SPECIAL_NEEDS_CD %', VS_SPECIAL_NEEDS_CD;--
	  
			EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 9 and 10 FAILED';--
						RETURN;--

		END;--
	------------- elements 11 to 15   ------------------------------------------------

		BEGIN 
		
				select 
						case when  (upper(PD.disabilitytypekey) IN ('AUTDIS', 'INDIS', 'MRD') and pd.disabilityconditiontypekey = 'Yes') then '1' else  '0' end,
						case when  (upper(PD.disabilitytypekey) IN ('VIDY', 'HDY') and pd.disabilityconditiontypekey = 'Yes' )  then '1' else  '0' end,
						case when  (upper(PD.disabilitytypekey) IN ('PYDY') and pd.disabilityconditiontypekey = 'Yes' ) then '1' else  '0' end,
						case when  (upper(PD.disabilitytypekey) IN ('EMDY') and pd.disabilityconditiontypekey = 'Yes' )  then '1' else  '0' end,
						case when  (upper(PD.disabilitytypekey) IN ('ODY') and  pd.disabilityconditiontypekey = 'Yes' )  then '1' else  '0' end   
				INTO
						VS_MENTAL_RETARDATION_CD,
						VS_VISUAL_HEARING_CD,
						VS_PHYSICAL_DISABLED_CD,
						VS_EMOTIONAL_DISTURBED_CD,
						VS_OTHER_DIAGNOSED_CONDITION_CD
				
				FROM 	persondisability PD join  
						person PP on PP.personid = PD.personid
				WHERE   PD.activeflag = 1 
						and PP.activeflag = 1
						and PD.disabilityflag = 1
						AND PP.cjamspid = VL_CLIENT_ID
						AND   (PD.startdate <= vdt_to::DATE OR PD.startdate IS NULL)
						AND (PD.enddate IS NULL OR PD.enddate >= VDT_FROM::DATE);
						
		--			raise notice ' VS_MENTAL_RETARDATION_CD %', VS_MENTAL_RETARDATION_CD;--
		--			raise notice ' VS_VISUAL_HEARING_CD %', VS_VISUAL_HEARING_CD;--
		--			raise notice ' VS_PHYSICAL_DISABLED_CD %', VS_PHYSICAL_DISABLED_CD;--
		--			raise notice ' VS_EMOTIONAL_DISTURBED_CD %', VS_EMOTIONAL_DISTURBED_CD;--
		--			raise notice ' VS_OTHER_DIAGNOSED_CONDITION_CD %', VS_OTHER_DIAGNOSED_CONDITION_CD;--
					
				IF (COALESCE(VS_MENTAL_RETARDATION_CD,'0') = '0' 	AND 
					COALESCE(VS_VISUAL_HEARING_CD,'0') = '0' 		AND 
					COALESCE(VS_PHYSICAL_DISABLED_CD,'0') = '0' 	AND
					COALESCE(VS_EMOTIONAL_DISTURBED_CD,'0') = '0' 	AND
					COALESCE(VS_OTHER_DIAGNOSED_CONDITION_CD,'0') = '0' AND
					VS_PRIMARY_BASIS_CD = '4') THEN
						VS_PRIMARY_BASIS_CD := '5';
				END IF;
					
				EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 11 to 15 FAILED';--
						RETURN;--
		END;--
				 
	---------------- Element 16-----------------------------------------------------------

		VDT_YEAR_MNTH_DAY := NULL;
	  
		BEGIN 
			VS_BMOTHER_BIRTH_YEAR = '';
			
		--		RAISE NOTICE 'VL_CLIENT_ID %', VL_CLIENT_ID;
		--		RAISE NOTICE 'VL_SERVICECASEID %', VL_SERVICECASEID;
				
			select 	ar.person2id, ar.intakeservicerequestactorid
			into 	VL_MOTHER_PID, VL_INTAKE_ACTOR_ID
			FROM 	intakeservicerequestactor ia
					LEFT JOIN actorrelationship ar on ar.intakeservicerequestactorid = ia.intakeservicerequestactorid
					JOIN person p on p.personid = ia.personid and p.cjamspid = (select case when pp.fk_id is not null then pp.fk_id::integer else pp.cjamspid end from person pp where pp.cjamspid = VL_CLIENT_ID LIMIT 1)
					JOIN person p2 on p2.personid = ar.person2id and p2.gendertypekey = 'F'
			  WHERE 	ar.relationshiptypekey in  ('BGCHLD') 
				AND ar.caseid::varchar = VL_SERVICECASEID
				LIMIT 1;
			  
			IF (VL_MOTHER_PID IS NOT NULL) THEN 
				SELECT 
					COALESCE(EXTRACT(YEARS from dob)::varchar,'') INTO VS_BMOTHER_BIRTH_YEAR 
				FROM 
					person 
				WHERE 
					personid = VL_MOTHER_PID::uuid 
					AND person.activeflag = 1;
					
				IF (VS_BMOTHER_BIRTH_YEAR IS NULL) THEN
					VS_BMOTHER_BIRTH_YEAR = '';
				END IF;
			END IF;
				  
		--		raise notice ' VS_BMOTHER_BIRTH_YEAR %', VS_BMOTHER_BIRTH_YEAR;--
			
				  
			EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 16 FAILED';--
						RETURN;--
			
		END;--
		
	----------------  Element 19----------------------------------------------------

		BEGIN 
			
			VS_MOTHER_TPR_DT ='';
		
			SELECT
				CASE WHEN tpr.tprdecisiondate is not null then to_char(tpr.tprdecisiondate, 'MM/DD/YYYY')
					 WHEN tpr.terminationtypekey IN ('PARDEATH', '3608') then to_char(p.dateofdeath,'MM/DD/YYYY')
					ELSE ''
				end
			INTO
				VS_MOTHER_TPR_DT
			FROM tprdetails tpr
			JOIN intakeservicerequestactor ia on ia.intakeservicerequestactorid = tpr.intakeservicerequestactorid
			JOIN tprrecommendation tprc on tprc.tprrecommendationid = tpr.tprrecommendationid
			JOIN person p on p.personid = ia.personid
			where ia.personid = VL_MOTHER_PID::uuid
			 AND tprc.intakeservicerequestactorid = VL_INTAKE_ACTOR_ID::uuid   
		   order by tpr.insertedon desc limit 1 ;
		   
		--		RAISE NOTICE 'VS_MOTHER_TPR_DT;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%',	VS_MOTHER_TPR_DT;
				
			EXCEPTION WHEN OTHERS THEN 
							VL_EXCEP_FLAG:= 1 ;--
							VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
							VS_MESSAGE := 'Element 19 FAILED';--
							RETURN;--
			
		
		   
		END;--

		
	----------------- Element 17-----------------------------------------

		BEGIN 
		
			select 	ar.person2id, ar.intakeservicerequestactorid
			into 	VL_FATHER_PID, VL_INTAKE_ACTOR_ID
			FROM 	intakeservicerequestactor ia
					JOIN actorrelationship ar on ar.intakeservicerequestactorid = ia.intakeservicerequestactorid
					JOIN person p on p.personid = ia.personid and p.cjamspid = (select case when pp.fk_id is not null then pp.fk_id::integer else pp.cjamspid end from person pp where pp.cjamspid = VL_CLIENT_ID LIMIT 1)
					JOIN person p2 on p2.personid = ar.person2id and p2.gendertypekey = 'M'
			WHERE 	ar.relationshiptypekey in  ('BGCHLD','BGFTHR','DAUALG') 
				AND ar.caseid::varchar = VL_SERVICECASEID
				ORDER BY ar.relationshiptypekey asc, ar.insertedon desc LIMIT 1;

			----
			SELECT 
			  EXTRACT(YEARS from dob) INTO VS_BFATHER_BIRTH_YEAR 
			FROM 
			  person 
			WHERE 
			  personid = VL_FATHER_PID::uuid 
			  AND person.activeflag = 1;
			  
		--		raise notice ' VS_BFATHER_BIRTH_YEAR %', VS_BFATHER_BIRTH_YEAR;--

			  
			EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 17 FAILED';--
						RETURN;--
			 
		END;--
	------------------------------- ELEMENT 18 -------------------------------
		
		BEGIN 

			Select 	Case	when biologicalmothermarriedsw = 1 then '1'
							when biologicalmothermarriedsw = 0 then '2'
							when biologicalmothermarriedsw = 2 then '3'
							else '3'
					end 
			into 	VS_MOTHER_MARRIED_AT_BIRTH_CD 
			From 	Person 
			where 	cjamspid = VL_Post_Adopt_ID -- VL_CLIENT_ID
					and activeflag = 1 ;--
			
			EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 18 FAILED';--
						RETURN;--
	 
		END;     
	----------- Element 20-----------------------------------------------------


		BEGIN 
		
			VS_FATHER_TPR_DT = '';
				
			SELECT
				CASE WHEN tpr.tprdecisiondate is not null then to_char(tpr.tprdecisiondate, 'MM/DD/YYYY')
					 WHEN tpr.terminationtypekey IN ('PARDEATH', '3608') then to_char(p.dateofdeath,'MM/DD/YYYY')
					ELSE ''
				end
			INTO
				VS_FATHER_TPR_DT
			FROM tprdetails tpr
			JOIN intakeservicerequestactor ia on ia.intakeservicerequestactorid = tpr.intakeservicerequestactorid
			JOIN tprrecommendation tprc on tprc.tprrecommendationid = tpr.tprrecommendationid
			JOIN person p on p.personid = ia.personid
			where ia.personid = VL_FATHER_PID::uuid
			AND tprc.intakeservicerequestactorid = VL_INTAKE_ACTOR_ID::uuid
			order by tpr.insertedon desc limit 1 ;
			
			IF ((VS_MOTHER_TPR_DT IS NULL OR VS_MOTHER_TPR_DT = '') AND (VS_BMOTHER_BIRTH_YEAR IS NOT NULL AND VS_BMOTHER_BIRTH_YEAR != '')) THEN
				IF (VS_FATHER_TPR_DT IS NOT NULL AND VS_FATHER_TPR_DT != '') THEN
					VS_MOTHER_TPR_DT := VS_FATHER_TPR_DT;
				END IF;
			END IF;
			
			EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 18 FAILED';--
						RETURN;--

			
		
		END;--

	-------------------- Element 21------------------------------------------------------
		BEGIN 
			
			
				   
			SELECT 	cast(to_char(ABL.finalizationdate,'MM/DD/YYYY') as character varying) 
			INTO 	VS_ADOPTION_FINALIZED_DT 
			FROM 	adoptionbreakthelink ABL
					join adoptionplanning APL on ABL.adoptionplanningid = APL.adoptionplanningid   
						and apl.adoptionplanningid = VL_ADOP_PLAN_ID::uuid limit 1 ;--
			

			--	raise notice ' VS_ADOPTION_FINALIZED_DT %', VS_ADOPTION_FINALIZED_DT;--
			
			-- For Migrated cases with Bio case in the system & Private Adoption Cases
			if VS_ADOPTION_FINALIZED_DT is null then  
				select cast(to_char(startdate,'MM/DD/YYYY') as character varying) 
					into VS_ADOPTION_FINALIZED_DT
				from adoptioncaseagreement
				where adoptioncaseid = VL_ADOP_CASE_ID::uuid
					and activeflag = 1 ;
			end if;			
			
			
			VD_ADOPTION_FINALIZED_DT := VS_ADOPTION_FINALIZED_DT;
		
			if DATE_PART('MONTH', VD_ADOPTION_FINALIZED_DT) in (10, 11, 12, 1, 2, 3) then 
				if DATE_PART('MONTH', VD_ADOPTION_FINALIZED_DT) in (1, 2, 3) then 
					VS_ACTUAL_PERIOD := rtrim( DATE_PART('YEAR', VD_ADOPTION_FINALIZED_DT):: TEXT)|| '03';

				else VS_ACTUAL_PERIOD := rtrim(( DATE_PART('YEAR', VD_ADOPTION_FINALIZED_DT )+ 1 ):: TEXT)|| '03';
		--
				end if;
		
			else 
				VS_ACTUAL_PERIOD := rtrim(DATE_PART('YEAR', VD_ADOPTION_FINALIZED_DT ):: TEXT)|| '09';
		--
			end if;

			EXCEPTION WHEN OTHERS THEN 
							VL_EXCEP_FLAG:= 1 ;--
							VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
							VS_MESSAGE := 'Element 21 FAILED';--
							RETURN;--
			
		END;--
		
	--------------------Element 22 --------------------------------------------------

		BEGIN 
			
			VS_ADOP_FAMILY_STRUCTURE_CD = NULL;

			select	distinct acr.personid
			into 	VL_ADOP_PARENT_ID
			from 	adoptioncase ac , adoptioncaseactor acr , person p 
			where 	ac.adoptioncaseid = acr.adoptioncaseid 
					and acr.personid = p.personid 
					and acr.actortypekey = 'ADOPTIVEPARENT'
					and ac.adoptioncasenumber = VL_ADOP_CASENUMBER::varchar
			limit 1 ;--

		--		raise notice ' VL_ADOP_PARENT_ID %', VL_ADOP_PARENT_ID;--
			
			SELECT 	CASE 
						WHEN ( trim(p.maritalstatustypekey) ) = 'LS' THEN '2'
						WHEN ( (trim(p.maritalstatustypekey) = 'S' or trim(p.maritalstatustypekey)= 'SG') and p.gendertypekey = 'M') then  '4'
						WHEN ( (trim(p.maritalstatustypekey) = 'S' or trim(p.maritalstatustypekey)= 'SG') and p.gendertypekey = 'F') then  '3'
						WHEN ( trim(p.maritalstatustypekey) )= 'MR' THEN '1' 
					   
					END  
			INTO 	VS_ADOP_FAMILY_STRUCTURE_CD 
			from 	person p 
			where 	p.personid = VL_ADOP_PARENT_ID::uuid ;--
			
		--		raise notice ' VS_ADOP_FAMILY_STRUCTURE_CD %', VS_ADOP_FAMILY_STRUCTURE_CD;--
			
				
		If VS_ADOP_FAMILY_STRUCTURE_CD is null then 

		
			select	family_structure_cd 
			into 	VL_Family_structure 
			from 	tb_provider_approval tpa, tb_prov_approval_person tpap
			where 	tpa.provider_approval_id = tpap.provider_approval_id 
					and tpap.person_type_cd in ('3610','3611')
					and tpa.provider_id = (	select distinct parent1providerid 
											from adoptioncaseagreement 
											where adoptioncaseid = VL_ADOP_CASE_ID::uuid limit 1 )
					and family_structure_cd is not null LIMIT 1;--
					
			Select case when VL_Family_structure in  ('290', '291', '292') then '1'
						when VL_Family_structure in ('298', '299') then '2'
						when VL_Family_structure in ('288',  '293', '294') then '3'
						when VL_Family_structure in ('289',  '295', '296') then '4'
						--when VL_Family_structure = '297' then '5'
					end 
			into VS_ADOP_FAMILY_STRUCTURE_CD;--
			
		--		raise notice ' VL_ADOP_PARENT_ID %', VL_ADOP_PARENT_ID;--
		

		end if;--
		
			EXCEPTION WHEN OTHERS THEN 
							VL_EXCEP_FLAG:= 1 ;--
							VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
							VS_MESSAGE := 'Element 22 FAILED';--
							RETURN;--
				
				
		END;--

	------------------- Elements 23 to 28------------------------------------------------

		BEGIN 
		
			VS_ADOP_MOTHER_BIRTH_YEAR = NULL; 
			VS_ADOP_MOTHER_RACE_AI_CD = '0';  
			VS_ADOP_MOTHER_RACE_ASIAN_CD = '0';  
			VS_ADOP_MOTHER_RACE_BLACK_CD = '0';  
			VS_ADOP_MOTHER_RACE_HAWAIIAN_CD = '0';  
			VS_ADOP_MOTHER_RACE_WHITE_CD = '0';  
			VS_ADOP_MOTHER_RACE_UN_CD = '0';
			VS_ADOP_MOTHER_HISPANIC_CD = '0'; 
			VL_ADOP_PARENT1_ID =  NULL;
			VL_PARENT_COUNT = 0;
			
			-- B-107196
			select	distinct acr.personid, p.gendertypekey
				into VL_ADOP_PARENT1_ID,
					vs_gendertypekey
			from 	adoptioncase ac , adoptioncaseactor acr , person p 
			where 	ac.adoptioncaseid = acr.adoptioncaseid 
				and acr.personid = p.personid 
				and acr.actortypekey = 'ADOPTIVEPARENT'
				and ac.adoptioncasenumber::bigint = VL_ADOP_CASENUMBER
			ORDER BY p.gendertypekey ASC
			limit 1; 

			IF VL_ADOP_PARENT1_ID is not null then 
			
				SELECT 	DATE_PART('year', pp.dob::date)::VARCHAR as dob , 

								CASE 
									WHEN pp.ethnicgrouptypekey = 'H' THEN '1'
									WHEN pp.ethnicgrouptypekey = 'X' THEN '2'
									else '3'
								END  			
					INTO  	VS_ADOP_MOTHER_BIRTH_YEAR, 
							VS_ADOP_MOTHER_HISPANIC_CD 
				FROM  	person PP 
				WHERE 	pp.personid = VL_ADOP_PARENT1_ID::uuid 
				and pp.activeflag = 1 ;
				
				
				SELECT	case 	when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AI%'   ) > 0 then '1' 
								when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AN%' ) > 0 then '1' 
								else '0' 
						end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AS%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%BA%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%WH%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%PI%') > 0 then '1' else '0' end,
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%UN%'   ) > 0 then '1' 
							when COUNT(*) FILTER (WHERE pr.racetypekey  like '%DC%' ) > 0 then '1' 
							else '0' 
						end
					INTO  	VS_ADOP_MOTHER_RACE_AI_CD, 
							VS_ADOP_MOTHER_RACE_ASIAN_CD, 
							VS_ADOP_MOTHER_RACE_BLACK_CD, 	 
							VS_ADOP_MOTHER_RACE_WHITE_CD, 
							VS_ADOP_MOTHER_RACE_HAWAIIAN_CD,
							VS_ADOP_MOTHER_RACE_UN_CD
				FROM  	personracetypemap pr 
				WHERE 	pr.personid = VL_ADOP_PARENT1_ID::uuid 
					and pr.activeflag = 1 ;
				
				IF (VS_ADOP_MOTHER_RACE_AI_CD = '0' AND 
					VS_ADOP_MOTHER_RACE_ASIAN_CD = '0' AND 
					VS_ADOP_MOTHER_RACE_BLACK_CD = '0' AND 
					VS_ADOP_MOTHER_RACE_HAWAIIAN_CD = '0' AND 
					VS_ADOP_MOTHER_RACE_WHITE_CD = '0' AND
					(VS_ADOP_MOTHER_BIRTH_YEAR IS NOT NULL OR VS_ADOP_MOTHER_BIRTH_YEAR != '')) THEN
					
						select  
							case when prp.primary_race_cd = '1803' then '1' else '0' end as indian, 
							case when prp.primary_race_cd = '6310' then '1' else '0' end as asian, 
							case when prp.primary_race_cd = '1801' then '1' else '0' end as black, 
							case when prp.primary_race_cd = '6311' then '1' else '0' end as island, 
							case when prp.primary_race_cd = '1806' then '1' else '0' end as white,
							case when prp.hispanic_cd = 'H' then '1' 
								when prp.hispanic_cd = 'N' then '2' 
								when prp.hispanic_cd = 'U' then '3'
								else '3' 
								end as hisp
						INTO  	VS_ADOP_MOTHER_RACE_AI_CD, 
								VS_ADOP_MOTHER_RACE_ASIAN_CD, 
								VS_ADOP_MOTHER_RACE_BLACK_CD, 
								VS_ADOP_MOTHER_RACE_HAWAIIAN_CD, 								
								VS_ADOP_MOTHER_RACE_WHITE_CD, 
								VS_ADOP_MOTHER_HISPANIC_CD
						FROM  tb_prov_approval_person prp
						JOIN person p on p.cjamspid = prp.approval_person_id and p.activeflag = 1
						WHERE p.personid = VL_ADOP_PARENT1_ID::uuid 
						LIMIT 1;
				END IF;
						
			end if;
			
		--		raise notice ' VL_ADOP_PARENT1_ID %', VL_ADOP_PARENT1_ID;
		--		raise notice ' VS_ADOP_MOTHER_BIRTH_YEAR1 %', VS_ADOP_MOTHER_BIRTH_YEAR;--
			
			IF (VL_ADOP_PARENT1_ID IS NULL OR VS_ADOP_MOTHER_BIRTH_YEAR IS NULL)  then
			
				VL_approval_personid = NULL;
				VL_Adop_prov_id = NULL;
				
				select parent1providerid 
				into VL_Adop_prov_id
				from adoptioncaseagreement	
				where adoptioncaseid = VL_ADOP_CASE_ID::uuid ;--
				
			
				select approval_person_id
				into VL_approval_personid
				from tb_prov_approval_person  pap, tb_provider_approval pa
					where pap.provider_approval_id = pa.provider_approval_id
						and pa.provider_id = VL_Adop_prov_id
						and pap.person_type_cd in ('3610')
						and pap.gender_cd IN ('1281','1282')
						order by pap.gender_cd asc, pa.approval_dt desc  
				limit 1;
				
		--			raise notice 'VL_approval_personid%',VL_approval_personid;--
		
				if VL_approval_personid is not null then 
				
						select  
							DATE_PART('year', dob_dt::date)::VARCHAR as dob , 
							case when primary_race_cd = '1803' then '1' else '0' end as indian, 
							case when primary_race_cd = '6310' then '1' else '0' end as asian, 
							case when primary_race_cd = '1801' then '1' else '0' end as black, 
							case when primary_race_cd = '6311' then '1' else '0' end as island, 
							case when primary_race_cd = '1806' then '1' else '0' end as white,
							--case when primary_race_cd = '6312' then '1' else '0' end as uad,
							case when hispanic_cd = 'H' then '1' 
								when hispanic_cd = 'N' then '2' 
								when hispanic_cd = 'U' then '3'
								else '3' 
								end as hisp
						INTO  	VS_ADOP_MOTHER_BIRTH_YEAR, 
										VS_ADOP_MOTHER_RACE_AI_CD, 
										VS_ADOP_MOTHER_RACE_ASIAN_CD, 
										VS_ADOP_MOTHER_RACE_BLACK_CD, 
										VS_ADOP_MOTHER_RACE_HAWAIIAN_CD, 
										VS_ADOP_MOTHER_RACE_WHITE_CD, 
										VS_ADOP_MOTHER_HISPANIC_CD
						FROM  tb_prov_approval_person
						WHERE approval_person_id = VL_approval_personid;--
		
		--					raise notice 'before else block end of Q3 %', VS_ADOP_MOTHER_BIRTH_YEAR;--

				end if;--
				
			end if;
			
		--		raise notice ' VS_ADOP_MOTHER_BIRTH_YEAR2 %', VS_ADOP_MOTHER_BIRTH_YEAR;--
			
			IF (VS_ADOP_MOTHER_RACE_AI_CD = '0' and 
				VS_ADOP_MOTHER_RACE_ASIAN_CD = '0' and 
				VS_ADOP_MOTHER_RACE_BLACK_CD = '0' and 
				VS_ADOP_MOTHER_RACE_HAWAIIAN_CD = '0' and 
				VS_ADOP_MOTHER_RACE_WHITE_CD = '0') THEN
				VS_ADOP_MOTHER_RACE_UN_CD = '1';
			ELSE
				VS_ADOP_MOTHER_RACE_UN_CD = '0';
			END IF;
			

			/*	EXCEPTION WHEN OTHERS THEN 
					VL_EXCEP_FLAG:= 1 ;--
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
					VS_MESSAGE := 'Element 23 to 28  FAILED';--
					RETURN;--
			*/
		END;--

		BEGIN 
			
			VS_ADOP_FATHER_BIRTH_YEAR=NULL; 
			VS_ADOP_FATHER_RACE_AI_CD ='0'; 
			VS_ADOP_FATHER_RACE_ASIAN_CD ='0'; 
			VS_ADOP_FATHER_RACE_BLACK_CD ='0'; 
			VS_ADOP_FATHER_RACE_HAWAIIAN_CD ='0'; 
			VS_ADOP_FATHER_RACE_WHITE_CD ='0'; 
			VS_ADOP_FATHER_HISPANIC_CD ='0';
			VS_ADOP_FATHER_RACE_UN_CD = '0';
			VL_ADOP_PARENT2_ID = NULL;
						
			select	distinct acr.personid
			into 	VL_ADOP_PARENT2_ID
			from 	adoptioncase ac , adoptioncaseactor acr , person p 
			where 	ac.adoptioncaseid = acr.adoptioncaseid 
					and acr.personid = p.personid 
					and acr.actortypekey = 'ADOPTIVEPARENT'
					and ac.adoptioncasenumber::bigint = VL_ADOP_CASENUMBER
					and p.gendertypekey = 'M'
					and (VL_ADOP_PARENT1_ID IS NULL or acr.personid !=  VL_ADOP_PARENT1_ID::uuid )
			limit 1 offset 1 ;--
			
		--		RAISE NOTICE 'VL_ADOP_PARENT2_ID %', VL_ADOP_PARENT2_ID;--
			
			IF (VL_ADOP_PARENT2_ID IS NULL AND (VS_ADOP_FAMILY_STRUCTURE_CD = '1' OR VS_ADOP_FAMILY_STRUCTURE_CD = '4')) THEN
				select	distinct acr.personid
					into 	VL_ADOP_PARENT2_ID
					from 	adoptioncase ac , adoptioncaseactor acr , person p 
					where 	ac.adoptioncaseid = acr.adoptioncaseid 
						and acr.personid = p.personid 
						and acr.actortypekey = 'ADOPTIVEPARENT'
						and ac.adoptioncasenumber::bigint = VL_ADOP_CASENUMBER
						and (VL_ADOP_PARENT1_ID IS NULL or acr.personid !=  VL_ADOP_PARENT1_ID::uuid )
					limit 1 offset 1;
			END IF;

			If VL_ADOP_PARENT2_ID is not null then 

				SELECT 	DATE_PART('year', pp.dob::date)::VARCHAR as dob ,
						CASE 
							WHEN pp.ethnicgrouptypekey = 'H' THEN '1'
							WHEN pp.ethnicgrouptypekey = 'X' THEN '2'
							else '3'
						END 
			  
				INTO 	VS_ADOP_FATHER_BIRTH_YEAR, 
						VS_ADOP_FATHER_HISPANIC_CD 
				FROM 	person PP 
				WHERE 	pp.personid = VL_ADOP_PARENT2_ID::uuid 
					and pp.activeflag =1 ;-- 
				
				
				SELECT	case 	when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AI%'   ) > 0 then '1' 
								when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AN%' ) > 0 then '1' 
								else '0' 
						end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%AS%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%BA%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%WH%') > 0 then '1' else '0' end, 
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%PI%') > 0 then '1' else '0' end,
						case when COUNT(*) FILTER (WHERE pr.racetypekey  like '%UN%'   ) > 0 then '1' 
							when COUNT(*) FILTER (WHERE pr.racetypekey  like '%DC%' ) > 0 then '1' 
							else '0' 
						end
					INTO  	VS_ADOP_FATHER_RACE_AI_CD, 
							VS_ADOP_FATHER_RACE_ASIAN_CD, 
							VS_ADOP_FATHER_RACE_BLACK_CD, 	 
							VS_ADOP_FATHER_RACE_WHITE_CD, 
							VS_ADOP_FATHER_RACE_HAWAIIAN_CD, 
							VS_ADOP_FATHER_RACE_UN_CD
				FROM  	personracetypemap pr 
				WHERE 	pr.personid = VL_ADOP_PARENT2_ID::uuid 
					and pr.activeflag = 1 ;
				
				
				IF (VS_ADOP_FATHER_RACE_AI_CD = '0' AND 
					VS_ADOP_FATHER_RACE_ASIAN_CD = '0' AND 
					VS_ADOP_FATHER_RACE_BLACK_CD = '0' AND 
					VS_ADOP_FATHER_RACE_HAWAIIAN_CD = '0' AND 
					VS_ADOP_FATHER_RACE_WHITE_CD = '0' AND
					(VS_ADOP_FATHER_BIRTH_YEAR IS NOT NULL OR VS_ADOP_FATHER_BIRTH_YEAR != '')) THEN
						select  
							case when prp.primary_race_cd = '1803' then '1' else '0' end as indian, 
							case when prp.primary_race_cd = '6310' then '1' else '0' end as asian, 
							case when prp.primary_race_cd = '1801' then '1' else '0' end as black, 
							case when prp.primary_race_cd = '6311' then '1' else '0' end as island, 
							case when prp.primary_race_cd = '1806' then '1' else '0' end as white,
							case when prp.hispanic_cd = 'H' then '1' 
								when prp.hispanic_cd = 'N' then '2' 
								when prp.hispanic_cd = 'U' then '3'
								else '3' 
								end as hisp
						INTO  	VS_ADOP_FATHER_RACE_AI_CD, 
								VS_ADOP_FATHER_RACE_ASIAN_CD, 
								VS_ADOP_FATHER_RACE_BLACK_CD, 
								VS_ADOP_FATHER_RACE_HAWAIIAN_CD, 								
								VS_ADOP_FATHER_RACE_WHITE_CD, 
								VS_ADOP_FATHER_HISPANIC_CD
						FROM  tb_prov_approval_person prp
						JOIN person p on p.cjamspid = prp.approval_person_id and p.activeflag = 1
						WHERE p.personid  = VL_ADOP_PARENT2_ID::uuid 
						LIMIT 1;
				END IF;			
								
			End if;
			
		--		RAISE NOTICE 'VS_ADOP_FATHER_BIRTH_YEAR %', VS_ADOP_FATHER_BIRTH_YEAR;
			
			IF VL_ADOP_PARENT2_ID is null OR VS_ADOP_FATHER_BIRTH_YEAR IS NULL then 
			
				select parent1providerid 
				into VL_Adop_prov_id
				from adoptioncaseagreement	
				where adoptioncaseid = VL_ADOP_CASE_ID::uuid ;--
		
				select approval_person_id
				into VL_approval_personid
				from tb_prov_approval_person  pap, tb_provider_approval pa
				where pap.provider_approval_id = pa.provider_approval_id
				 and pa.provider_id = VL_Adop_prov_id
				 and pap.person_type_cd in ('3611')
				 and pap.gender_cd IN ('1281','1282')
				 order by pap.gender_cd desc, pa.approval_dt desc 
				 limit 1;
			 
				 if VL_approval_personid is not null then 
				 
						 select  
							DATE_PART('year', dob_dt::date)::varchar as dob , 
							case when primary_race_cd = '1803' then '1' else '0' end as indian, 
							case when primary_race_cd = '6310' then '1' else '0' end as asian, 
							case when primary_race_cd = '1801' then '1' else '0' end as black, 
							case when primary_race_cd = '6311' then '1' else '0' end as island, 
							case when primary_race_cd = '1806' then '1' else '0' end as white,
							--case when primary_race_cd = '6312' then '1' else '0' end as uad,
							case when hispanic_cd = 'H' then '1' 
								 when hispanic_cd = 'N' then '2' 
								 else '3' 
								 end as hisp
						INTO  	VS_ADOP_FATHER_BIRTH_YEAR, 
								VS_ADOP_FATHER_RACE_AI_CD, 
								VS_ADOP_FATHER_RACE_ASIAN_CD, 
								VS_ADOP_FATHER_RACE_BLACK_CD, 
								VS_ADOP_FATHER_RACE_HAWAIIAN_CD, 
								VS_ADOP_FATHER_RACE_WHITE_CD, 
								VS_ADOP_FATHER_HISPANIC_CD
						FROM  tb_prov_approval_person
						WHERE approval_person_id = VL_approval_personid;--
					
				end if;--
				-- NEW LOGIC END		

				
			END IF ;--

			IF (VS_ADOP_FATHER_RACE_AI_CD ='0' AND
				VS_ADOP_FATHER_RACE_ASIAN_CD ='0' AND
				VS_ADOP_FATHER_RACE_BLACK_CD ='0' AND 
				VS_ADOP_FATHER_RACE_HAWAIIAN_CD ='0' AND 
				VS_ADOP_FATHER_RACE_WHITE_CD ='0') THEN
				VS_ADOP_FATHER_RACE_UN_CD = '1';
			ELSE
				VS_ADOP_FATHER_RACE_UN_CD = '0';
		
			END IF;
			
		--		IF VS_ADOP_FAMILY_STRUCTURE_CD IS NULL THEN
				IF ((VS_ADOP_MOTHER_BIRTH_YEAR IS NOT NULL AND VS_ADOP_MOTHER_BIRTH_YEAR != '') AND (VS_ADOP_FATHER_BIRTH_YEAR IS NOT NULL AND VS_ADOP_MOTHER_BIRTH_YEAR != '')) THEN
					IF (VS_ADOP_FAMILY_STRUCTURE_CD != '1' AND VS_ADOP_FAMILY_STRUCTURE_CD != '2') THEN
						VS_ADOP_FAMILY_STRUCTURE_CD = '1';
					END IF;
				ELSE 
					IF (VS_ADOP_MOTHER_BIRTH_YEAR IS NOT NULL AND VS_ADOP_MOTHER_BIRTH_YEAR != '') THEN
						VS_ADOP_FAMILY_STRUCTURE_CD = '3';
					ELSE
						IF (VS_ADOP_FATHER_BIRTH_YEAR IS NOT NULL AND VS_ADOP_FATHER_BIRTH_YEAR != '') THEN
							VS_ADOP_FAMILY_STRUCTURE_CD = '4';
						END IF;
					END IF;
				END IF;
		--		END IF;
			
			IF (VS_ADOP_FAMILY_STRUCTURE_CD = '3') THEN
				VS_ADOP_FATHER_BIRTH_YEAR=''; 
				VS_ADOP_FATHER_RACE_AI_CD =''; 
				VS_ADOP_FATHER_RACE_ASIAN_CD =''; 
				VS_ADOP_FATHER_RACE_BLACK_CD =''; 
				VS_ADOP_FATHER_RACE_HAWAIIAN_CD =''; 
				VS_ADOP_FATHER_RACE_WHITE_CD =''; 
				VS_ADOP_FATHER_RACE_UN_CD = '';
				VS_ADOP_FATHER_HISPANIC_CD ='';
			END IF;
			
			
			IF (VS_ADOP_FAMILY_STRUCTURE_CD = '4') THEN
				VS_ADOP_MOTHER_BIRTH_YEAR = ''; 
				VS_ADOP_MOTHER_RACE_AI_CD = '';  
				VS_ADOP_MOTHER_RACE_ASIAN_CD = '';  
				VS_ADOP_MOTHER_RACE_BLACK_CD = '';  
				VS_ADOP_MOTHER_RACE_HAWAIIAN_CD = '';  
				VS_ADOP_MOTHER_RACE_WHITE_CD = '';  
				VS_ADOP_MOTHER_RACE_UN_CD = '';
				VS_ADOP_MOTHER_HISPANIC_CD = '';
			END IF;
			
			
			/*		EXCEPTION WHEN OTHERS THEN 
					VL_EXCEP_FLAG:= 1 ;--
					VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
					VS_MESSAGE := 'Element 23 to 28  FAILED';--
					RETURN;--
			*/
		END;--
		--		
				
		--     	raise notice ' VS_ADOP_MOTHER_BIRTH_YEAR %', VS_ADOP_MOTHER_BIRTH_YEAR;--
		--		raise notice ' VS_ADOP_FATHER_BIRTH_YEAR %', VS_ADOP_FATHER_BIRTH_YEAR;--
		--		raise notice ' VS_ADOP_MOTHER_HISPANIC_CD %', VS_ADOP_MOTHER_HISPANIC_CD;--
		--		raise notice ' VS_ADOP_FATHER_HISPANIC_CD %', VS_ADOP_FATHER_HISPANIC_CD;--

			 
	----------------------------------Element #29,30, 31---------------------------------------------------------------------------

		BEGIN 

				SELECT 	CASE WHEN LOWER(acar.childrelationship) like '%step%' THEN 1 ELSE 0 END as step,
						CASE WHEN LOWER(acar.childrelationship) like 'relative%' THEN 1 ELSE 0 END as relative,
						CASE WHEN LOWER(acar.childrelationship) like '%foster%' THEN 1 ELSE 0 END as foster
					  INTO  VS_ADOP_PAR_REL_STEPPARENT_CD,
							VS_ADOP_PAR_REL_OTHERREL_CD,
							VS_ADOP_PAR_REL_FOSPAR_CD
					FROM adoptioncaseagreementrate acar
					JOIN adoptioncaseagreement aca ON aca.adoptionagreementid = acar.adoptionagreementid
				WHERE aca.adoptioncaseid = VL_ADOP_CASE_ID::uuid
						AND acar.startdate::date <= vdt_to::date 
						ORDER BY acar.startdate DESC LIMIT 1;
						
										
		--				raise notice ' VS_ADOP_PAR_REL_STEPPARENT_CD %', VS_ADOP_FATHER_RACE_UN_CD;
		--				raise notice ' VS_ADOP_PAR_REL_OTHERREL_CD %', VS_ADOP_PAR_REL_OTHERREL_CD;
		--				raise notice ' VS_ADOP_PAR_REL_FOSPAR_CD %', VS_ADOP_PAR_REL_FOSPAR_CD;

				EXCEPTION WHEN OTHERS THEN 
						VL_EXCEP_FLAG:= 1 ;--
						VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
						VS_MESSAGE := 'Element 30 FAILED';--
						RETURN;--
				
		END;--
					
	-----------------------------------Element #32---------------------------------------------------------------------------------

		SELECT 	CASE WHEN LOWER(acar.childrelationship) like '%non-relative%' THEN 1 ELSE 0 END as nonrelative
					  INTO  VS_ADOP_PAR_REL_NONREL_CD
			FROM adoptioncaseagreementrate acar
			JOIN adoptioncaseagreement aca ON aca.adoptionagreementid = acar.adoptionagreementid
		WHERE aca.adoptioncaseid = VL_ADOP_CASE_ID::uuid
				AND acar.startdate::date <= vdt_to::date 
				ORDER BY acar.startdate DESC LIMIT 1;
				
		--		Select Case when VS_ADOP_PAR_REL_FOSPAR_CD = '0' and VS_ADOP_PAR_REL_OTHERREL_CD = '0' and VS_ADOP_PAR_REL_STEPPARENT_CD = '0' then '1'
		--					else '0'
		--				end 
		--		into VS_ADOP_PAR_REL_NONREL_CD;--
				
		--		raise notice ' VS_ADOP_PAR_REL_NONREL_CD %', VS_ADOP_PAR_REL_NONREL_CD;--



	-- -----------------Element 33 34---------------------------------

		BEGIN 
			 select case	
					when lower(aa.childplacedfrom) = 'wtinst' then '1' 
					when lower(aa.childplacedfrom) = 'anst' then '2' 
					when lower(aa.childplacedfrom) = 'ancn' then '3' 
					end ,
					case 
					when lower(aa.childplacedby) in ( 'pubagy', 'iveag' ) then  '1' -- To add Title IV-E Agency
					when lower(aa.childplacedby) in ( 'priagy', 'indtsr', 'legargrd', 'bipar' ) then '2' 
					when lower(aa.childplacedby) = 'triagy' then '3' 
					-- CIDM-8193
					-- when lower(aa.childplacedby) in ('indtsr', 'legargrd') then '4' 
					-- when lower(aa.childplacedby) = 'bipar' then '5' 
					end 
			INTO  	VS_CHILD_PLACED_FROM_CD , VS_CHILD_PLACED_BY_CD
			from 	adoptioncaseagreement aa 
			where 	aa.adoptioncaseid = VL_ADOP_CASE_ID::uuid 
			limit 1 ;--
			
		--		raise notice ' VS_CHILD_PLACED_FROM_CD %', VS_CHILD_PLACED_FROM_CD;--
		--		raise notice ' VS_CHILD_PLACED_BY_CD %', VS_CHILD_PLACED_BY_CD;--

			
			If VS_CHILD_PLACED_FROM_CD  is null and VS_CHILD_PLACED_BY_CD is null then 
			
		
				select case when lower(aa.childplacedfrom) = 'wtinst' then  '1' 
					when lower(aa.childplacedfrom) = 'anst' then '2' 
					when lower(aa.childplacedfrom) = 'ancn' then '3' 
					end ,
					case when lower(aa.childplacedby) in ( 'pubagy', 'iveag' ) then  '1' -- To add Title IV-E Agency
					when lower(aa.childplacedby) in ('indtsr', 'bipar', 'priagy') then '2' -- Private agency
					when lower(aa.childplacedby) = 'Ttriagy' then '3' -- Tribe
					-- CIDM-8193
					-- when lower(aa.childplacedby) = 'indtsr' then '4' -- Independent person - Not valid value in 2.0
					-- when lower(aa.childplacedby) = 'bipar' then '5' -- Birth parent - Not valid value in 2.0
					end 
				INTO  	VS_CHILD_PLACED_FROM_CD , VS_CHILD_PLACED_BY_CD
				from 	adoptionagreement AA,  adoptionplanning AP
				where 	AA.adoptionplanningid = AP.adoptionplanningid 
						and aa.adoptionplanningid = VL_ADOP_PLAN_ID::uuid 
				limit 1 ;--
						
		--			raise notice ' VS_CHILD_PLACED_FROM_CD %', VS_CHILD_PLACED_FROM_CD;--
		--			raise notice ' VS_CHILD_PLACED_BY_CD %', VS_CHILD_PLACED_BY_CD;--

			
			End if ;--
			
				EXCEPTION WHEN OTHERS THEN 
									VL_EXCEP_FLAG:= 1 ;--
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
									VS_MESSAGE := 'Element 33 and 34 FAILED';--
									RETURN;--
						
			END;--

			 
	------- Element 35, 36------------------------------------------------------

		BEGIN 
			VS_ADOPTION_SUBSIDY_CD = '2';
			VS_SUBSIDY_PAYMENT_AMT = '0000';
					
		--		select 	case when ac.issubsidypaid = 1 then 1 
		--					else 2
		--				end,
		--		substring((acra.paymentamout::int)::varchar,1,5)    --Decimal amount to integer
			SELECT CASE WHEN (acra.paymentamout IS NOT NULL AND acra.paymentamout > 0) THEN '1' ELSE '2' END,
				   CASE WHEN (acra.paymentamout IS NOT NULL AND acra.paymentamout > 0) THEN substring((acra.paymentamout::int)::varchar,1,5) ELSE '0000' END
			into 	VS_ADOPTION_SUBSIDY_CD,
					VS_SUBSIDY_PAYMENT_AMT
			from 	adoptioncaseagreement ac , adoptioncaseagreementrate acra
			where 	ac.adoptionagreementid = acra.adoptionagreementid
					and lower(acra.status) = 'approved'
					-- CIDM-5893
					and ac.adoptioncaseid = VL_ADOP_CASE_ID::uuid 
					-- and ac.finalizationdate::date  between vdt_from::date and vdt_to::date 
					;
					
			
			IF (VS_ADOPTION_SUBSIDY_CD IS NULL OR VS_ADOPTION_SUBSIDY_CD != '1') THEN
				VS_ADOPTION_SUBSIDY_CD = '2';
				VS_SUBSIDY_PAYMENT_AMT = '0000';
			END IF;
			
		--		raise notice ' VS_ADOPTION_SUBSIDY_CD %', VS_ADOPTION_SUBSIDY_CD;--
		--		raise notice ' VS_SUBSIDY_PAYMENT_AMT %', VS_SUBSIDY_PAYMENT_AMT;--
				
			EXCEPTION WHEN OTHERS THEN 
									VL_EXCEP_FLAG:= 1 ;--
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
									VS_MESSAGE := 'Element 35 and 36 FAILED';--
									RETURN;--
					
		END;--


	--------------------------Element #37 ---------------------------------------------------------------------------

		BEGIN 

			select	btrim(eligibility_status_cd)
				into VL_Eligibility_status
			from tb_client_eligibility 
			where btrim(eligibility_type_cd) = '2934'
				and case_id = VL_ADOP_CASENUMBER
				and (end_dt is null or end_dt <= vdt_to::date)
			order by start_dt desc nulls last limit 1;
					
			
			Select	case when VL_Eligibility_status in ('2909', '2910', '2911', '2914', '2912') then '2'
						 when VL_Eligibility_status = '2913'  then '1'
						 else '2'
					end 
			into VS_IV_E_ADOPTION_SW;--
			
			IF (VS_ADOPTION_SUBSIDY_CD = '2') THEN
				VS_IV_E_ADOPTION_SW = '2';
			END IF;
			
		--		RAISE NOTICE 'VL_Eligibility_status >> %', VL_Eligibility_status;	
		--		raise notice ' VS_IV_E_ADOPTION_SW %', VS_IV_E_ADOPTION_SW;--

			
			EXCEPTION WHEN OTHERS THEN 
									VL_EXCEP_FLAG:= 1 ;--
									VL_OUTPUT_SQLCODE  :=  SQLSTATE;--
									VS_MESSAGE := 'Element 37 FAILED';--
									RETURN;--
		END;--
		
	-------------------------- New AFCARS 2.0 Elements --------------------------
		Begin 

			-- Child Race: Abandoned
			vs_A12_child_race_abandoned := NULL;

			select (case when count(*) > 0 then '1' else '0' end) 
				into vs_A12_child_race_abandoned
			from personracetypemap prt,
				referencevalues race 
			where race.ref_key = prt.racetypekey
				and prt.personid = ( select p.personid from person p where p.cjamspid=VL_Post_Adopt_ID)
				and prt.activeflag = 1
				and race.referencetypeid = 171
				and race.ref_key = 'AB' ;
			
			-- Childs Race: Declined 	
			vs_A13_child_race_declined := NULL;
			
			select (case when count(*) > 0 then '1' else '0' end) 
				into vs_A13_child_race_declined
			from personracetypemap prt,
				referencevalues race 
			where race.ref_key = prt.racetypekey
				and prt.personid = ( select p.personid from person p where p.cjamspid=VL_Post_Adopt_ID)
				and prt.activeflag = 1
				and race.referencetypeid = 171
				and race.ref_key = 'DC' ;

			-- 04/22/2025
			IF vs_A13_child_race_declined = '1' or vs_A12_child_race_abandoned = '1' THEN
				VS_RACE_UN_CD := '0';  
			END IF;

			-- Assistance Agreement Type
			-- 1 = Adoption 
			-- 2 = Guardianship 
			vs_A15_assistance_agreement_type := '1' ;
		
			vs_Agreement_Start_date := NULL;
			vs_A18_agreement_termination_date := NULL;
			
			select startdate, 
				(case when enddate::date <= vdt_to::DATE then
					enddate
				 else
					null
				end ) 	
			into vs_Agreement_Start_date,
				vs_A18_agreement_termination_date
			from adoptioncaseagreement
			where adoptioncaseid = VL_ADOP_CASE_ID::uuid
				and activeflag = 1 ;
		end;
	-------------------------- New AFCARS 2.0 Elements --------------------------
		
		BEGIN 

			INSERT INTO afcarsadoptiondetail (
			  --detailid,
			  summaryid, 
			  submittedperiod, 
			  actualperiod, 
			  statetypekey, 
			  reportpdenddate, 
			  recordno, 
			  agencyinvolvementtypekey, 
			  childdob, 
			  gendertypekey, 
			  raceaitypekey, 
			  raceasiantypekey, 
			  raceblacktypekey, 
			  racehawaiiantypekey, 
			  racewhitetypekey, 
			  raceuntypekey, 
			  hispanictypekey, 
			  specialneedstypekey, 
			  primarybasistypekey, 
			  mentalretardationtypekey, 
			  visualhearingtypekey, 
			  physicaldisabledtypekey, 
			  emotionaldisturbedtypekey, 
			  otherdiagnosedconditiontypekey, 
			  bmotherbirthyear, 
			  bfatherbirthyear, 
			  mothermarriedatbirthtypekey, 
			  mothertprdt, 
			  fathertprdt, 
			  adoptionfinalizeddt, 
			  adopfamilystructuretypekey, 
			  adopmotherbirthyear, 
			  adopfatherbirthyear, 
			  adopmotherraceaitypekey, 
			  adopmotherraceasiantypekey, 
			  adopmotherraceblacktypekey, 
			  adopmotherracehawaiiantypekey, 
			  adopmotherracewhitetypekey, 
			  adopmotherraceuntypekey, 
			  adopmotherhispanictypekey, 
			  adopfatherraceaitypekey, 
			  adopfatherraceasiantypekey, 
			  adopfatherraceblacktypekey, 
			  adopfatherracehawaiiantypekey, 
			  adopfatherracewhitetypekey, 
			  adopfatherraceuntypekey, 
			  adopfatherhispanictypekey, 
			  adopparrelstepparenttypekey, 
			  adopparrelotherreltypekey, 
			  adopparrelnonreltypekey, 
			  childplacedfromtypekey, 
			  childplacedbytypekey, 
			  adoptionsubsidytypekey, 
			  subsidypaymentamount, 
			  iveadoptionflag, 
			  insertedon, 
			  insertedby, 
			  updatedon, 
			  updatedby, 
			  activeflag, 
			  adopparrelfospartypekey, 
			  clientid,
			  ------ New AFCARS 2.0 Elements ---------
			  a12_child_race_abandoned,
			  a13_child_race_declined,
			  a15_assistance_agreement_type,
			  agreement_start_date,
			  a18_agreement_termination_date,
			  a4_child_date_of_birth,
			  adoption_gap_casetype
				) 
			VALUES 
			  (
				--VL_AFCARS_ADOPTION_ID,
				VI_SUMMARY_ID, 
				VS_REPORT_PD_END_DT, 
				VS_ACTUAL_PERIOD, 
				VS_STATE_CD, 
				RTRIM(LTRIM(VS_REPORT_PD_END_DT) ), 
				VS_RECORD_NO, 
				VS_AGENCY_INVOLVEMENT_CD, 
				VS_CHILD_DOB, 
				VS_GENDER_CD, 
				VS_RACE_AI_CD, 
				VS_RACE_ASIAN_CD, 
				VS_RACE_BLACK_CD, 
				VS_RACE_HAWAIIAN_CD, 
				VS_RACE_WHITE_CD, 
				VS_RACE_UN_CD, 
				VS_HISPANIC_CD, 
				VS_SPECIAL_NEEDS_CD, 
				VS_PRIMARY_BASIS_CD, 
				COALESCE(VS_MENTAL_RETARDATION_CD,'0'), 
				COALESCE(VS_VISUAL_HEARING_CD,'0'), 
				COALESCE(VS_PHYSICAL_DISABLED_CD,'0'), 
				COALESCE(VS_EMOTIONAL_DISTURBED_CD,'0'), 
				COALESCE(VS_OTHER_DIAGNOSED_CONDITION_CD,'0'), 
				VS_BMOTHER_BIRTH_YEAR, 
				VS_BFATHER_BIRTH_YEAR, 
				VS_MOTHER_MARRIED_AT_BIRTH_CD, 
				VS_MOTHER_TPR_DT, 
				VS_FATHER_TPR_DT, 
				VS_ADOPTION_FINALIZED_DT, 
				VS_ADOP_FAMILY_STRUCTURE_CD, 
				VS_ADOP_MOTHER_BIRTH_YEAR, 
				VS_ADOP_FATHER_BIRTH_YEAR,
				VS_ADOP_MOTHER_RACE_AI_CD, 
				VS_ADOP_MOTHER_RACE_ASIAN_CD, 
				VS_ADOP_MOTHER_RACE_BLACK_CD, 
				VS_ADOP_MOTHER_RACE_HAWAIIAN_CD, 
				VS_ADOP_MOTHER_RACE_WHITE_CD, 
				VS_ADOP_MOTHER_RACE_UN_CD, 
				VS_ADOP_MOTHER_HISPANIC_CD, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_AI_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_ASIAN_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_BLACK_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_HAWAIIAN_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_WHITE_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then null 
						else VS_ADOP_FATHER_RACE_UN_CD
				end, 
				case	when VS_ADOP_FAMILY_STRUCTURE_CD in ( '3','4') then '0' 
						else VS_ADOP_FATHER_HISPANIC_CD
				end, 
				VS_ADOP_PAR_REL_STEPPARENT_CD, 
				VS_ADOP_PAR_REL_OTHERREL_CD, 
				VS_ADOP_PAR_REL_NONREL_CD, 
				VS_CHILD_PLACED_FROM_CD, 
				VS_CHILD_PLACED_BY_CD, 
				VS_ADOPTION_SUBSIDY_CD, 
				VS_SUBSIDY_PAYMENT_AMT, 
				VS_IV_E_ADOPTION_SW, 
				CURRENT_TIMESTAMP, 
				VS_USER_ID, 
				CURRENT_TIMESTAMP, 
				VS_USER_ID, 
				1, 
				case when VS_ADOP_PAR_REL_OTHERREL_CD  in ('1') then '0' 
					else VS_ADOP_PAR_REL_FOSPAR_CD
				end , 
				VL_CLIENT_ID,
				------ New AFCARS 2.0 Elements ---------
				vs_A12_child_race_abandoned,
				vs_A13_child_race_declined,
				vs_A15_assistance_agreement_type,
				vs_Agreement_Start_date,
				vs_A18_agreement_termination_date,
				vs_A4_child_date_of_birth,
				'Adoption'
			  );
			  
			  EXCEPTION WHEN others then                                      
			  
				VL_EXCEP_FLAG:= 1 ;--
				VS_OUTPUT_STATE := sqlstate;
			--	VL_OUTPUT_SQLCODE:=sqlerrm;
				VS_MESSAGE:='SQLSTATE:'||VS_OUTPUT_STATE||'INSERT INTO afcarsadoptiondetail FAILED '||(VL_CLIENT_ID::VARCHAR);
				
			end;--
			
			  IF VL_EXCEP_FLAG = 1 THEN 
				
				INSERT INTO	interfaceserrorlog( interfaceid, 
												currentruntimestamp, 
												errorlineno,
												errorcode,
												errordescription, 
												insertedon) 
				VALUES 						(  'AFCARS ADOPTION', 
												CURRENT_TIMESTAMP, 
												000, 
												VS_MESSAGE, 
												VS_OUTPUT_STATE, 
												CURRENT_DATE );
				
												
			RETURN;--
			END IF;
		--    
    END LOOP;
	--     
	-- RAISE NOTICE 'CAME OUT OF LOOP';
	CLOSE CASE_CLIENS_CUR;
	
	RAISE NOTICE 'ADOPTION PROCESS END';
	
	-- Capture GAP Data 
	BEGIN 
		RAISE NOTICE 'GAP PROCESS START';
	
		select a.vl_output_sqlcode, a.vs_message
		from cjams.f_afcars_generate_gap(	vi_summary_id,
											vdt_from::character varying, 
											vdt_to::character varying
										) a 
		into vl_gap_output_sqlcode,
			vs_gap_message;
		
		RAISE NOTICE 'vl_gap_output_sqlcode %', vl_gap_output_sqlcode;
		RAISE NOTICE 'vl_gap_output_sqlcode %', vs_gap_message;
		
		RAISE NOTICE 'GAP PROCESS END';
	END;
	

	BEGIN 

		UPDATE afcarsadoptiondetail SET childdob = '0' || childdob, updatedon = now(), updatedby = VS_USER_ID WHERE length(childdob) = 5;		
		
		insert into afcarsadoptioncount (	countid ,
											totalnorecords ,
											periodendingdate ,
											chunderoneyear ,
											choneyear ,
											chtwoyear ,
											chthreeyear ,
											chfouryear ,
											chfiveyear ,
											chsixyear ,
											chsevenyear ,
											cheightyear ,
											chnineyear ,
											chtenyear ,
											chelevenyear ,
											chtwelveyear ,
											chthirteenyear ,
											chfourteenyear ,
											chfifteenyear ,
											chsixteenyear ,
											chseventeenyear ,
											cheighteenyear ,
											chovereighteenyear ,
											insertedon ,
											insertedby ,
											updatedon ,
											updatedby ,
											activeflag )
		select 	afcarsadoptiondetail.summaryid,
				count( afcarsadoptiondetail.clientid),
				VS_REPORT_PD_END_DT,
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=0),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=1),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=2),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=3),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=4),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=5),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=6),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=7),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=8),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=9),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=10),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=11),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=12),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=13),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=14),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=15),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=16),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=17),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage=18),
				count( afcarsadoptiondetail.clientid) filter (where af_age.fage::integer >18),
				CURRENT_TIMESTAMP,
				'interface',
				CURRENT_TIMESTAMP,
				'interface',
				1
		from    
				afcarsadoptiondetail ,
				(	select 	distinct clientid,
							lpad((case when substring(childdob,1,2)::integer > VS_MONTH::integer then ((VS_YEAR::integer-substring(childdob,3,4)::integer)-1)::integer
							else (VS_YEAR::integer-substring(childdob,3,4)::integer)::integer
							end)::varchar,2,'0')::integer fage
					from 	afcarsadoptiondetail) af_age
		where af_age.clientid=afcarsadoptiondetail.clientid
		group by afcarsadoptiondetail.summaryid;

		EXCEPTION WHEN others then 
			VL_EXCEP_FLAG:= 1 ;--
			VS_OUTPUT_STATE := sqlstate;
			VS_MESSAGE:='SQLSTATE:'||VS_OUTPUT_STATE||'INSERT INTO afcarsadoptioncount FAILED ';

	END;--


    IF VL_EXCEP_FLAG = 1 THEN 
            
		INSERT INTO	interfaceserrorlog( interfaceid, 
										currentruntimestamp, 
										errorlineno,
										errorcode,
										errordescription, 
										insertedon) 
		VALUES 						(  'AFCARS ADOPTION', 
										CURRENT_TIMESTAMP, 
										000, 
										VL_EXCEP_MESSAGE, 
										VS_OUTPUT_STATE, 
										CURRENT_DATE );
										
	
											
		RETURN;--
	END IF;
	
	VL_OUTPUT_SQLCODE := 0;
	VS_MESSAGE:= 'SP RAN SUCCESSFULLY';--

END;
$function$
;

