DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_eighteen_criteria_info(bigint);


CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_eighteen_criteria_info(al_client_id bigint) RETURNS TABLE(client_id bigint, nameofsecondaryeducationorequivalentprogram CHARACTER varying, startdateofsecondaryeducationorequivalentprogram TIMESTAMP WITHOUT TIME ZONE, nameofpostsecondaryorvocationaleducation CHARACTER varying, startdateofpostsecondaryorvocationaleducation TIMESTAMP WITHOUT TIME ZONE, nameofpromotetoemploymentprogram CHARACTER varying, startdateofpromotetoemploymentprogram TIMESTAMP WITHOUT TIME ZONE, nameofemployer CHARACTER varying, startdateofemployment TIMESTAMP WITHOUT TIME ZONE, hourspermonthemployed integer, childdisabilitytype CHARACTER varying, childdisabilitystartdate TIMESTAMP WITHOUT TIME ZONE, childdisabilityevaluationdocumentiondate TIMESTAMP WITHOUT TIME ZONE, istherevalidsilaagreement CHARACTER varying, dateofvalidsilaagreement TIMESTAMP WITHOUT TIME ZONE) LANGUAGE PLPGSQL AS $function$

 DECLARE
                 vs_Procedure_nm                    VARCHAR(100) DEFAULT 'sp_fc_worksheet_eighteen_criteria_info';
                 vs_scndry_edu_eqlnt_prgm           VARCHAR(50);
                 vd_scndry_edu_eqlnt_prgm_strt_dt   TIMESTAMP;
                 vs_post_scndry_vctl_edu            VARCHAR(50);
                 vd_post_scndry_vctl_edu_strt_dt    TIMESTAMP;
                 vs_prmtd_empl_prgm_nm              VARCHAR(50);
                 vd_prmtd_empl_prgm_strt_dt         TIMESTAMP;
                 vs_empl_nm                         VARCHAR(50);
                 vd_empl_strt_dt                    TIMESTAMP;
                 vn_empl_hrs_mnth                   INTEGER;
                 vs_chd_disablty_tp                 VARCHAR(50);
                 vd_chd_disablty_strt_dt            TIMESTAMP;
                 vd_chd_disablty_evltn_docmntn_dt   TIMESTAMP;
                 vs_valid_sila_agrmnt               VARCHAR(50);
                 vd_sila_agrmnt_sgn_dt              TIMESTAMP;


  BEGIN
 CREATE TEMP TABLE IF NOT EXISTS
 Temp_worksheet_eighteen_criteria_info (
                 client_id                                          BIGINT,
                 nameofsecondaryeducationorequivalentprogram        VARCHAR(50),
                 startdateofsecondaryeducationorequivalentprogram   TIMESTAMP,
                 nameofpostsecondaryorvocationaleducation           VARCHAR(50),
                 startdateofpostsecondaryorvocationaleducation      TIMESTAMP,
                 nameofpromotetoemploymentprogram                   VARCHAR(50),
                 startdateofpromotetoemploymentprogram              TIMESTAMP,
                 nameofemployer                                     VARCHAR(50),
                 startdateofemployment                              TIMESTAMP,
                 hourspermonthemployed                              INTEGER,
                 childdisabilitytype                                VARCHAR(50),
                 childdisabilitystartdate                           TIMESTAMP,
                 childdisabilityevaluationdocumentiondate           TIMESTAMP,
                 istherevalidsilaagreement                          VARCHAR(50),
                 dateofvalidsilaagreement                           TIMESTAMP
         );

 -- Name Of Secondary Education/Equivalent Program
 SELECT ( CASE WHEN (rtrim(pedu.educationtypekey) = 'SECY' )
                                 THEN ( SELECT typedescription
                                                 FROM educationtype
                                                 WHERE TRIM(educationtypekey)=TRIM(pedu.educationtypekey) )
                                 ELSE NULL END )
         INTO vs_scndry_edu_eqlnt_prgm
         FROM personeducation pedu, person per
 WHERE per.personid = pedu.personid AND pedu.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Secondary Education/Equivalent Program Start Date
 SELECT ( CASE WHEN (rtrim(pedu.educationtypekey) = 'SECY' )
                                 THEN ( SELECT pedu.startdate )
                                 ELSE NULL END )
         INTO vd_scndry_edu_eqlnt_prgm_strt_dt
         FROM personeducation pedu, person per
 WHERE per.personid = pedu.personid AND pedu.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Name Of Post-Secondary/Vocational Education
 SELECT ( CASE WHEN (rtrim(pedu.educationtypekey) = 'PTSECY' )
                                 THEN ( SELECT typedescription
                                                 FROM educationtype
                                                 WHERE TRIM(educationtypekey)=TRIM(pedu.educationtypekey) )
                                 ELSE NULL END )
         INTO vs_post_scndry_vctl_edu
         FROM personeducation pedu, person per
 WHERE per.personid = pedu.personid AND pedu.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Post-Secondary/Vocational Education Start Date
 SELECT ( CASE WHEN (rtrim(pedu.educationtypekey) = 'PTSECY' )
                                 THEN ( SELECT pedu.startdate )
                                 ELSE NULL END )
         INTO vd_post_scndry_vctl_edu_strt_dt
         FROM personeducation pedu, person per
 WHERE per.personid = pedu.personid AND pedu.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Promoted Employment Program Name
 SELECT pemp.promotedemploymentprogramname
         INTO vs_prmtd_empl_prgm_nm
         FROM personemployment pemp, person per
 WHERE per.personid = pemp.personid AND pemp.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Promoted Employment Program Start Date
 SELECT pemp.promotedemploymentprogramstartdate
         INTO vd_prmtd_empl_prgm_strt_dt
         FROM personemployment pemp, person per
 WHERE per.personid = pemp.personid AND pemp.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Employer Name
 SELECT pemp.employername
         INTO vs_empl_nm
         FROM personemployment pemp, person per
 WHERE per.personid = pemp.personid AND pemp.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Employment Start Date
 SELECT pemp.startdate
         INTO vd_empl_strt_dt
         FROM personemployment pemp, person per
 WHERE per.personid = pemp.personid AND pemp.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Employed Hours/Month
 SELECT ped.noofhours 
         INTO vn_empl_hrs_mnth
         FROM personemployment pemp, person per, personemployerdetail ped 
 WHERE per.personid = pemp.personid and pemp.personemployerdetailsid = ped.personemployerdetailid  AND pemp.activeflag = 1 
       AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;


 -- Child Disability Type
 SELECT ( CASE WHEN (pdis.disabilityflag = 1)
                         THEN 'Permanent'::VARCHAR ELSE 'Temporary'::VARCHAR END )
         INTO vs_chd_disablty_tp
         FROM persondisability pdis, person per
 WHERE per.personid =  pdis.personid AND pdis.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Child Disability Start Date
 SELECT pdis.startdate
         INTO vd_chd_disablty_strt_dt
         FROM persondisability pdis, person per
 WHERE per.personid =  pdis.personid AND pdis.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

  -- Child Disability Evaluation Documentation Date
 SELECT pdis.evaluationdate
         INTO vd_chd_disablty_evltn_docmntn_dt
         FROM persondisability pdis, person per
 WHERE per.personid =  pdis.personid AND pdis.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Valid Sila Agreement
 SELECT ( CASE WHEN (la.silaagreementsigneddate IS NOT NULL)
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END )
         INTO vs_valid_sila_agrmnt
         FROM person per, livingarrangement la
 WHERE per.personid =  la.personid AND la.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 -- Sila Agreement Sign Date
 SELECT la.silaagreementsigneddate
         INTO vd_sila_agrmnt_sgn_dt
         FROM person per, livingarrangement la
 WHERE per.personid =  la.personid AND la.activeflag = 1
         AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

 INSERT INTO Temp_worksheet_eighteen_criteria_info
 SELECT
                 al_client_id,
                 vs_scndry_edu_eqlnt_prgm,
                 vd_scndry_edu_eqlnt_prgm_strt_dt,
                 vs_post_scndry_vctl_edu,
                 vd_post_scndry_vctl_edu_strt_dt,
                 vs_prmtd_empl_prgm_nm,
                 vd_prmtd_empl_prgm_strt_dt,
                 vs_empl_nm,
                 vd_empl_strt_dt,
                 vn_empl_hrs_mnth,
                 vs_chd_disablty_tp,
                 vd_chd_disablty_strt_dt,
                 vd_chd_disablty_evltn_docmntn_dt,
                 vs_valid_sila_agrmnt,
                 vd_sila_agrmnt_sgn_dt;

 RETURN QUERY SELECT *
                FROM Temp_worksheet_eighteen_criteria_info;

 DROP TABLE Temp_worksheet_eighteen_criteria_info;

    END
     $function$