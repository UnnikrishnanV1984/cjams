CREATE OR REPLACE FUNCTION cjams.f_afcars_client_details(adt_from character varying, adt_to character varying, al_client_id integer, al_removal_id bigint, ad_removal_dt date, al_case_id bigint)
 RETURNS TABLE(as_report_pd_end_dt character varying, as_local_agency_cd character varying, as_record_no character varying, as_child_dob character varying, as_gender_cd character varying, as_race_ai_cd character varying, as_race_asian_cd character varying, as_race_black_cd character varying, as_race_hawaiian_cd character varying, as_race_white_cd character varying, as_race_un_cd character varying, as_hispanic_cd character varying, as_child_adopted_cd character varying, as_age_adoption_legalized character varying, vl_excep_flag integer)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL STORED PROCEDURE
--AUTHOR : GAYATHRI RAJKUMAR
--DATE   :'2009-11-30'
--DESC   : CALCULATES VALUES FOR ELEMENT  2 TO 9 AND 16 TO 17
--UNIT TEST MODIFICATION
-- 1.MODIFIED ERROR LOG LOGIC
-- 2.ADDED COURT HEARING CONDN
-- 3.Added Input parameters
-- 4.CHANGED TB_AFCARS_REFERRENCE MAPPING VALUES FROM 8A - F TO 8a - 8f
-- 5.CHANGED THE LABEL NAME (LINE# INTO ELEMENT#)
-- 6.MODIFIED ELEMENT# 17 MAPPING
-- 7.MAPPING RACE ELEMENT
-- 8.Included Declined Race
-- 9.REMOVED SQLWARNING FROM EXCEPTION
---10.Combined Unknown and Declined logic and mapping
-- 11.RACE MODIFICATION - '2010-02-12
-- 12.REMOVED CASE PERIODIC REVIEW DT LOGIC

------------------------------------------------------------------------
<<outer_block>>
--DECLARATION PART
DECLARE SQLCODE INTEGER DEFAULT 0;--
 VL_CASE_ID          BIGINT;--
 VS_YEAR VARCHAR(10); --
 VS_MONTH VARCHAR(10);--
 VS_MESSAGE      VARCHAR(160);--
 VL_OUTPUT_SQLCODE INTEGER;--
 VL_STAFF_ID INTEGER;--
 AS_ERROR VARCHAR(100);--
 VS_PREV_ADOPTION_AGE INTEGER;--
 VS_PROGRAM_NM  VARCHAR(50) DEFAULT  'AFCARS_FOSTERCARE';--
 VS_BATCH_NO VARCHAR(5)  DEFAULT '000';--
 VS_IDENTITY_COLUMN INTEGER;--
 VS_IDENTITY_COLUMN1 VARCHAR(1) DEFAULT NULL;--
 VS_PRIMARY_RACE_CD VARCHAR(5);--
 VS_TABLE_NAME VARCHAR(50)   DEFAULT  'TB_AFCARS_REFERENCE';--
 VS_AFCARS_TYPE_CD VARCHAR(1) DEFAULT 'F';--
VL_EXCEP_MESSAGE VARCHAR;
VL_EXCEP_FLAG INTEGER;
VS_OUTPUT_STATE VARCHAR;

BEGIN --outer_block_begins

---LOGIC BEGINS HERE
      	--*******ELEMENT #2******* 	-- REPORT PERIOD ENDING DATE

	-- VS_YEAR := (SELECT (EXTRACT(YEAR FROM DATE 'ADT_TO::DATE')));--
	-- VS_MONTH :=(SELECT (EXTRACT(MONTH FROM DATE  'ADT_TO::DATE')));--
	-- AS_REPORT_PD_END_DT := ADT_TO ; --
	 --VS_YEAR || VS_MONTH;--
     VL_CASE_ID := AL_CASE_ID;--
	

        -- ******* ELEMENT # 3 ******-------                                    -- LOCAL AGENCY FIPS CODE
	-- GET THE STAFF ID TO FIND THE PRIMARY COUNTY CODE
 BEGIN
	SELECT f_rpt_caseworker_afcars(AL_CLIENT_ID,AL_CASE_ID,''::VARCHAR, ADT_FROM::DATE, ADT_TO::DATE) INTO VL_STAFF_ID;-- removed catalog table SYSIBM.SYSDUMMY1 
	VL_STAFF_ID := COALESCE(VL_STAFF_ID,0);--
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;
	-- GET COUNTY CODE
BEGIN
	SELECT county INTO AS_LOCAL_AGENCY_CD --issue with primary_county_cd not available in 
	FROM userprofileaddress WHERE securityusersid = VL_STAFF_ID::VARCHAR AND activeflag = 1;--
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;	
	AS_LOCAL_AGENCY_CD := COALESCE(AS_LOCAL_AGENCY_CD,''); --
	
	IF AS_LOCAL_AGENCY_CD = '' THEN
	BEGIN																						  
		SELECT F_PRIM_COUNTY(VL_CASE_ID,'NULL') INTO AS_LOCAL_AGENCY_CD ;--
	EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;																						  
	END IF;--
 
  -- *******ELEMENT # 4 *******-------                                       -- RECORD NO.
BEGIN
																							  
        SELECT F_AFCARS_ENCRYPT(CAST(AL_CLIENT_ID AS VARCHAR)) INTO AS_RECORD_NO;--
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;									 
BEGIN
SELECT PP.dob::date, afc.afcars_ref_cd as gendertype , 
case when racetypekey LIKE '%{"racetypekey":"AI"}%' then 1 else 0 end as indian,
case when racetypekey LIKE '%{"racetypekey":"AN"}%' then 1 else 0 end as asian,
case when racetypekey LIKE '%{"racetypekey":"BA"}%' then 1 else 0 end as black,
case when racetypekey LIKE '%{"racetypekey":"PI"}%' then 1 else 0 end as island,
case when racetypekey LIKE '%{"racetypekey":"WH"}%' then 1 else 0 end as white,
case when racetypekey LIKE '%{"racetypekey":"UN"}%' then 1 else 0 end as unknown
, arc.afcars_ref_cd as ethnictype, 
case when everbeenadoptedflag = 1 then '1'
     when everbeenadoptedflag = 0 then '2'
     else 3	 
end as adoptionflag
  INTO as_child_dob,
  as_gender_cd, 
  as_race_ai_cd, 
  as_race_asian_cd,
  as_race_black_cd,
  as_race_hawaiian_cd,
  as_race_white_cd,
  as_race_un_cd,
  AS_HISPANIC_CD,
  AS_CHILD_ADOPTED_CD
FROM person PP
LEFT JOIN afcars_ref_code afc on afc.afcars_ref_type = 'sex' and PP.gendertypekey = afc.cjams_cd
LEFT JOIN afcars_ref_code arc on arc.afcars_ref_type = 'ethnicity'	and PP.racetypekey = arc.cjams_cd
WHERE PP.cjamspid = AL_CLIENT_ID and PP.activeflag = 1 and AFC.activeflag = 1 and ARC.activeflag = 1; --
EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR DISABILITY #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;

BEGIN 

select (EXTRACT(YEAR FROM age))::int INTO VS_PREV_ADOPTION_AGE
FROM person, age(person.preadoptiondate, person.dob) where cjamspid = AL_CLIENT_ID and activeflag = 1; --

EXCEPTION WHEN OTHERS THEN
                VS_OUTPUT_STATE := SQLSTATE;
                VL_OUTPUT_SQLCODE :=SQLERRM;
                                VS_MESSAGE := 'SQLSTATE:' || VS_OUTPUT_STATE || '. SELECT  FAILED FOR PERSON ADOPTION LEGAL DATE #152 FOR -->'|| CAST(AL_CLIENT_ID AS VARCHAR) ;--
                                VL_EXCEP_FLAG := 1;--
                                VL_EXCEP_MESSAGE := CAST(VL_OUTPUT_SQLCODE AS VARCHAR)|| VS_OUTPUT_STATE ;--
								
	END;
	
	IF VS_PREV_ADOPTION_AGE = 0 THEN 
as_age_adoption_legalized:= 0; --
ELSIF VS_PREV_ADOPTION_AGE < 2 THEN 
as_age_adoption_legalized:= 1; --
ELSIF VS_PREV_ADOPTION_AGE BETWEEN 2 AND 5 THEN 
as_age_adoption_legalized:= 2; --
ELSIF VS_PREV_ADOPTION_AGE BETWEEN 2 AND 5 THEN
as_age_adoption_legalized:= 3; --
ELSIF VS_PREV_ADOPTION_AGE BETWEEN 6 AND 12 THEN
as_age_adoption_legalized:= 4; --
ELSIF AS_CHILD_ADOPTED_CD = '2' THEN 
as_age_adoption_legalized:= 5; --
END IF; --

 IF VL_EXCEP_FLAG = 1 THEN
   INSERT INTO interfaceserrorlog(
                                         interfaceid,
                                         currentruntimestamp,
                                         errorlineno,
                                         errorcode,
                                         errordescription,
                                         insertedon)VALUES ('AFACRS FOSTER CARE',
                                                CURRENT_TIMESTAMP,
                                                0,
                                                VL_EXCEP_MESSAGE,
                                                VS_OUTPUT_STATE,
                                                CURRENT_DATE);
END IF;--
end;
$function$
