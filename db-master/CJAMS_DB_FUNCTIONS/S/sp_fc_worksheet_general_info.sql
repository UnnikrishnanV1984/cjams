DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_general_info(bigint);
CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_general_info(al_client_id bigint)
 RETURNS TABLE(client_id bigint, isdjsordsschild character varying, dateofbirth timestamp without time zone, personid uuid, uscitizen character varying, qualifiedalien character varying, qualifiedalienstaus character varying, alienregistrationnumber character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE 
		vs_Procedure_nm 					VARCHAR(100) DEFAULT 'sp_fc_worksheet_general_info';
		vd_child_plct_dt					DATE;
		vd_lvng_strt_dt						TIMESTAMP;
		vs_lvng_arng_plct					VARCHAR(50);
		vs_plct_elig						VARCHAR(50);
		vs_djs_dss_child					VARCHAR(50);
		vd_birth_dt							TIMESTAMP;
		vn_person_id						UUID;
		vs_us_ctzn							VARCHAR(50);
		vs_qlfd_alien						VARCHAR(50);
		vs_qlfd_alien_sts					VARCHAR(50);
		vs_alien_rgstn_txt					VARCHAR(50);
	
 BEGIN	
CREATE TEMP TABLE IF NOT EXISTS
Temp_worksheet_general_info ( 
		client_id 									BIGINT,
		isdjsordsschild								VARCHAR(50),
		dateofbirth									TIMESTAMP,
		personid									UUID,
		uscitizen									VARCHAR(50),
		qualifiedalien								VARCHAR(50),
		qualifiedalienstaus							VARCHAR(50),
		alienregistrationnumber						VARCHAR(50)
	);	

-- DJS/DSS Child
SELECT (CASE WHEN teamtypekey = 'CW' THEN
				'DHS'::VARCHAR 
			WHEN teamtypekey = 'DJS' THEN
				'DJS'::VARCHAR
			ELSE NULL END)
	INTO vs_djs_dss_child		
	FROM intakeservicerequest isr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.servicecaseid = isr.servicecaseid AND pl.activeflag = 1
	AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid --AND isra.activeflag = 1
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
   
-- Date of Birth   
SELECT per.dob, per.personid  
	INTO vd_birth_dt, vn_person_id
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;  

-- US Citizen   
SELECT (CASE WHEN (TRIM(per.primarycitizenshiptypekey) = 'US' or  TRIM(per.primarycitizenshiptypekey) = 'USA')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END)   
	INTO vs_us_ctzn
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id
  	AND per.activeflag = 1;
   
-- Qualified Alien   
SELECT (CASE WHEN vs_us_ctzn = 'YES' THEN null else (CASE WHEN (per.alienstatustypekey is not null and  
					per.alienregistrationtext is not null and 
					TRIM(per.alienregistrationtext) != '' ) 
 				THEN 'YES'::VARCHAR ELSE 'NO' END) END )
	INTO vs_qlfd_alien
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
-- Qualified Alien Status
SELECT rv.value_text   
	INTO vs_qlfd_alien_sts
  	FROM referencevalues rv, person per
WHERE referencetypeid = 89 AND rv.activeflag = 1 
    AND TRIM(rv.ref_key) = TRIM(per.alienstatustypekey)
    AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
   
-- Alien Registration Number   
SELECT per.alienregistrationtext  
	INTO vs_alien_rgstn_txt
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id
  	AND per.activeflag = 1;  

IF vs_djs_dss_child is NULL THEN
		vs_djs_dss_child = 'DHS'::VARCHAR ;
END IF;

 
INSERT INTO Temp_worksheet_general_info
SELECT 
		al_client_id,
		vs_djs_dss_child,
		vd_birth_dt,
		vn_person_id,
		vs_us_ctzn,
		vs_qlfd_alien,
		vs_qlfd_alien_sts,
		vs_alien_rgstn_txt;
   	
RETURN QUERY SELECT *
               FROM Temp_worksheet_general_info;
              
DROP TABLE Temp_worksheet_general_info;

   END
    $function$
