DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_removal_info(al_client_id bigint);

CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_removal_info(al_client_id bigint)
 RETURNS TABLE(client_id bigint, typeofremoval character varying, courtordered character varying, typeofvpa character varying, issafehavenbaby character varying, childphysicalremovaldate date, childphysicaladdressafterremoval character varying, clientidofpersonfromwhomchildwasphysicallyremoved integer, clientnameofpersonfromwhomchildwasphysicallyremoved character varying, relationshipidofpersonfromwhomchildwasphysicallyremoved integer, relationshipofpersonfromwhomchildwasphysicallyremoved character varying, dateof1stparentsignatureonvpa date, dateof2ndparentsignatureonvpa date, mandatorynoteonmissing2ndparentsignatureonvpa character varying, dateofyouthsignatureonvpa date, previousfostercareepisodeexist character varying, reasonforexit character varying, exitcaredatefrompreviousfostercareepisode date, dateofguardiansignatureonvpa date, clientidwhosignedvpa integer, parent2id integer, guardianid integer, clientnamewhosignedvpa character varying, dateofldsssignatureonvpa date, dateofreasonableeffortscourthearing timestamp without time zone, isreasonableeffortsfindingtimely character varying)
 LANGUAGE plpgsql
AS $function$

DECLARE 
		vs_Procedure_nm 														VARCHAR(100) DEFAULT 'sp_fc_worksheet_removal_info';		
		vs_typeofremoval														VARCHAR(50);
		vs_crt_ord																VARCHAR(50);
		vs_typeofvpa															VARCHAR(50);
		vs_safehavenbaby														VARCHAR(50);
		vd_child_physical_rmvl_dt												DATE;
		vs_child_physical_add_after_rmvl										VARCHAR(500);
		vn_client_id_of_person_from_whom_child_physically_removed				INTEGER;
		vs_clientname_of_person_from_whom_child_physically_removed				VARCHAR(250);
		vn_relationship_id_of_person_from_whom_child_physically_removed			INTEGER;
		vs_relationship_of_person_from_whom_child_physically_removed			VARCHAR(100);
		vd_first_prnt_sign_dt													DATE;
		vd_second_prnt_sign_dt													DATE;
		vs_missing_scnd_prnt_note												VARCHAR(50);
		vd_youth_sign_dt														DATE;
		vs_prvs_fc_epsde_exist													VARCHAR(50);
		vs_rsn_for_exit															VARCHAR(100);
		vd_prvs_fc_exit_dt														DATE;
		vd_grdn_sign_dt															DATE;
		vn_vpa_sign_client_id													INTEGER;
		vd_second_prnt_id 														INTEGER;
		vd_grdn_sign_id 														INTEGER;
		vs_vpa_sign_client														VARCHAR(250);
		vd_ldss_sign_dt															DATE;
		vd_rsnbl_efrts_crt_hrng_dt												TIMESTAMP;
		vs_rsnbl_effrts_fndng_tmly												VARCHAR(50);
	
 BEGIN	
CREATE TEMP TABLE IF NOT EXISTS
Temp_worksheet_removal_info ( 
		client_id 													BIGINT,		
		typeofremoval												VARCHAR(50),
		courtordered												VARCHAR(50),
		typeofvpa													VARCHAR(50),
		issafehavenbaby												VARCHAR(50),
		childphysicalremovaldate									DATE,
		childphysicaladdressafterremoval							VARCHAR(500),
		clientidofpersonfromwhomchildwasphysicallyremoved			INTEGER,
		clientnameofpersonfromwhomchildwasphysicallyremoved			VARCHAR(250),
		relationshipidofpersonfromwhomchildwasphysicallyremoved		INTEGER,
		relationshipofpersonfromwhomchildwasphysicallyremoved		VARCHAR(100),
		dateof1stparentsignatureonvpa								DATE,
		dateof2ndparentsignatureonvpa								DATE,
		mandatorynoteonmissing2ndparentsignatureonvpa				VARCHAR(50),
		dateofyouthsignatureonvpa									DATE,
		previousfostercareepisodeexist								VARCHAR(50),
		reasonforexit												VARCHAR(100),
		exitcaredatefrompreviousfostercareepisode					DATE,
		dateofguardiansignatureonvpa								DATE,
		clientidwhosignedvpa										INTEGER,
		parent2id													INTEGER,
		guardianid													INTEGER,
		clientnamewhosignedvpa										VARCHAR(250),
		dateofldsssignatureonvpa									DATE,
		dateofreasonableeffortscourthearing							TIMESTAMP,
		isreasonableeffortsfindingtimely							VARCHAR(50)
	);

-- Type of Removal
SELECT ( CASE WHEN (rtrim(isrcr.removaltypekey) = 'TLV' 
				OR rtrim(isrcr.removaltypekey) = 'CDVP' 
				OR rtrim(isrcr.removaltypekey) = 'EHA' ) 
				THEN 'Voluntary_Placement_Agreement'::VARCHAR 
			  WHEN (isrcr.removaltypekey = 'JD') 
				THEN 'Court_Order'::VARCHAR ELSE 'None'::VARCHAR END )  
	INTO vs_typeofremoval
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
-- Court Order
SELECT ( CASE WHEN (rtrim(isrcr.removaltypekey) = 'JD')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ) 
	INTO vs_crt_ord
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
   
-- Type of VPA
SELECT ( CASE rv.value_text WHEN 'Time-limited Voluntary Placement'
 				THEN 'Time-Limited'::VARCHAR WHEN 'Children With Disabilities Voluntary Placement' THEN 'Child with Disabilities'::VARCHAR
 				WHEN 'Enhanced aftercare' THEN 'EA-VPA'::VARCHAR END )
	INTO vs_typeofvpa
  	FROM referencevalues rv, intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per
WHERE referencetypeid = 53 AND rv.activeflag = 1
    AND TRIM(rv.ref_key) = TRIM(isrcr.removaltypekey)
	AND pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
   
-- Safehaven Baby   
SELECT ( CASE WHEN (rtrim(isrcr.removaltypekey) = 'SHB')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END )  
	INTO vs_safehavenbaby
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
 
-- Child Physical Removal Date
SELECT isrcr.removaldate
	INTO vd_child_physical_rmvl_dt
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

-- Child Physical Address After Removal  
SELECT 
case when pl.placementtypekey = 'LA' then 
	(select concat(TRIM(lva.streettext), ' ' , lva.streetname, ' ' , INITCAP(lva.streetsuffixtypekey), ',' , lva.cityname, ',' , lva.statetypekey, '-' ,lva.zip5no)::character varying 
	from livingarrangement lva where lva.placementid = pl.placementid limit 1)
when pl.placementtypekey = 'PRPL' then 
	(select 
	( CAST
	 (
	 TRIM(COALESCE(tpa.adr_street_tx::VARCHAR,''))||' '|| TRIM(COALESCE(tpa.adr_street_nm,'')) ||' '||TRIM(COALESCE(tpa.adr_city_nm,'')) ||' '||
	 TRIM(COALESCE(tpa.adr_state_cd,'')) ||' '||TRIM(COALESCE(tpa.adr_zip5_no::VARCHAR,'')) 
	 AS CHARACTER VARYING )) from tb_provider tp inner join tb_provider_addresses tpa on 
		tpa.delete_sw = 'N' AND tpa.adr_default_sw = 'Y'  AND tp.provider_id = tpa.parent_key_id::int4
		 where pl.altproviderid = tp.provider_id AND tp.delete_sw = 'N' limit 1)
else null
End
INTO vs_child_physical_add_after_rmvl
FROM  placement pl, person per
WHERE  pl.activeflag = 1 AND  per.personid = pl.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 limit 1;

-- Client ID of Person From Whom Child Physically Removed
SELECT DISTINCT crgvr.cjamspid
	INTO vn_client_id_of_person_from_whom_child_physically_removed
	FROM person crgvr, intakeservicerequestactor crgvrisra, placement pl, intakeservicerequestactor isra, person per
WHERE crgvrisra.personid = crgvr.personid AND crgvrisra.intakeservicerequestpersontypekey = 'LG' 
	AND crgvrisra.servicecaseid = pl.servicecaseid AND crgvrisra.activeflag = 1 AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

-- Client Name of Person From Whom Child Physically Removed
SELECT (COALESCE(crgvr.firstname)||' '|| COALESCE(crgvr.lastname))::VARCHAR
	INTO vs_clientname_of_person_from_whom_child_physically_removed
	FROM person crgvr, intakeservicerequestactor crgvrisra, placement pl, intakeservicerequestactor isra, person per
WHERE crgvrisra.personid = crgvr.personid AND crgvrisra.intakeservicerequestpersontypekey = 'LG' 
	AND crgvrisra.servicecaseid = pl.servicecaseid AND crgvrisra.activeflag = 1 AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

-- Relationship of Person From Whom Child Physically Removed and related IV-E relationship Id
SELECT rt.fourerelid,  cr.rmvdfrmpersonname --rt.description
	INTO vn_relationship_id_of_person_from_whom_child_physically_removed, vs_relationship_of_person_from_whom_child_physically_removed
  	FROM relationshiptype rt, actorrelationship ar, person p, intakeservreqchildremoval cr
WHERE TRIM(rt.relationshiptypekey) = TRIM(ar.relationshiptypekey)  
	AND ar.person2id = p.personid AND ar.person1id = cr.primarycaregiveractorid 
	and rt.activeflag = 1 and ar.activeflag = 1 and p.activeflag = 1 
	AND cjamspid::BIGINT = al_client_id 
	ORDER BY ar.updatedon desc LIMIT 1;
  
-- VPA 1st Parent Signed ID and Date  
SELECT isrcr.vpaparentssigneddate, isrcr.parent1id
	INTO vd_first_prnt_sign_dt, vn_vpa_sign_client_id
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

-- VPA 2nd Parent Signed ID and Date  
SELECT isrcr.parent2signeddate, isrcr.parent2id
	INTO vd_second_prnt_sign_dt, vd_second_prnt_id
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
-- Mandatory Note On Missing 2nd Parent Signature On VPA   
SELECT isrcr.parent2comments  
	INTO vs_missing_scnd_prnt_note
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
-- VPA Youth Signed Date  
SELECT isrcr.vpayouthsigneddate
	INTO vd_youth_sign_dt
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
 
-- Previous Foster Care Eepisode Exist,   
SELECT ( CASE WHEN (isrcr.returndate IS NOT NULL)
 				THEN 'YES'::VARCHAR  END )  
	INTO vs_prvs_fc_epsde_exist
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;	

-- Reason For Exit
SELECT DISTINCT ( CASE rv.value_text WHEN 'Reunification' THEN 
								'Reunification'::VARCHAR 
							WHEN 'Adoption Finalization (when selected the Removal and Program Assignment will automatically end date)' THEN 
								'Adoption'::VARCHAR
							WHEN 'Adoption Disruption' THEN 
								'Adoption'::VARCHAR
							WHEN 'Adoption Disruption' THEN 
								'Adoption'::VARCHAR
							WHEN 'Permanency Step: Adoptive or pre-adoptive Placement' THEN 
								'Adoption'::VARCHAR
 							WHEN 'Guardianship Non-Relative' THEN 
 								'Guardianship'::VARCHAR
 							WHEN 'Custody/Guardianship – Relative' THEN 
 								'Guardianship'::VARCHAR
 							WHEN 'Custody/Guardianship – Non-Relative' THEN 
 								'Guardianship'::VARCHAR							
 							WHEN 'Marriage' THEN 
								'Marriage'::VARCHAR 
							WHEN 'Military' THEN 
								'Military'::VARCHAR ELSE 'Other'::VARCHAR END )  
	INTO vs_rsn_for_exit
  	FROM referencevalues rv, intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per
WHERE referencetypeid = 87 AND rv.activeflag = 1
  	AND TRIM(rv.ref_key) = TRIM(isrcr.removalreasontypekey)
	AND pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
   
-- Previous FC Episode Exit Care Date  
SELECT isrcr.returndate
	INTO vd_prvs_fc_exit_dt
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
-- VPA Guardian Signed Date & VPA Signed Client ID
SELECT isrcr.vpaguardiansigneddate, isrcr.guardianid
	INTO vd_grdn_sign_dt, vd_grdn_sign_id
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;
  
--  VPA Signed Client
SELECT DISTINCT ( CASE WHEN ( rtrim(isrcr.removaltypekey) = 'TLV' 
				OR rtrim(isrcr.removaltypekey) = 'CDVP' 
				OR rtrim(isrcr.removaltypekey) = 'EHA' ) 
				THEN ( SELECT (COALESCE(crgvr.firstname)||' '|| COALESCE(crgvr.lastname))::VARCHAR ) 
						ELSE NULL END )
	INTO vs_vpa_sign_client
	FROM intakeservreqchildremoval isrcr, person crgvr, intakeservicerequestactor crgvrisra, placement pl, intakeservicerequestactor isra, person per
WHERE crgvrisra.personid = crgvr.personid AND crgvrisra.intakeservicerequestpersontypekey = 'AM' 
	AND crgvrisra.servicecaseid = pl.servicecaseid AND crgvrisra.activeflag = 1 AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 limit 1;

-- VPA LDSS Signed Date  
SELECT isrcr.agencysigneddate
	INTO vd_ldss_sign_dt
  	FROM intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per 
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;  
  
-- Reasonable efforts Court Hearing Date
SELECT MIN(isrch.hearingdatetime)
  	INTO vd_rsnbl_efrts_crt_hrng_dt
  	FROM intakeservicerequestcourtaction isrca, intakeservicerequestcourthearing isrch, intakeservreqchildremoval isrcr, person per, intakeservicerequestactor isra 
WHERE isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrch.activeflag = 1
	AND isrca.reasonableeffortsflag = 1 AND isrca.intakeservicerequestid = isrcr.intakeserviceid AND isrca.activeflag = 1
	AND isra.intakeserviceid = isrcr.intakeserviceid AND isrcr.activeflag = 1
	AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.activeflag = 1
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;  	
  
-- Reasonable Efforts Finding Timely 
SELECT ( CASE WHEN ( (vs_typeofremoval = 'Court_Order' AND extract(day from age(vd_rsnbl_efrts_crt_hrng_dt, isrcr.removaldate)) <= 60) 
				OR (vs_typeofremoval = 'Voluntary_Placement_Agreement' AND extract(day from age(vd_rsnbl_efrts_crt_hrng_dt, isrcr.removaldate)) <= 180) )
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END  ) 
	INTO vs_rsnbl_effrts_fndng_tmly
  	FROM intakeservreqchildremoval isrcr, person per, intakeservicerequestactor isra 
WHERE isra.intakeserviceid = isrcr.intakeserviceid AND isrcr.activeflag = 1
	AND isra.intakeservicerequestpersontypekey = 'CHILD' AND isra.activeflag = 1
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;	
 
INSERT INTO Temp_worksheet_removal_info
SELECT 
		al_client_id,
		vs_typeofremoval,
		vs_crt_ord,
		vs_typeofvpa,
		vs_safehavenbaby,
		vd_child_physical_rmvl_dt,
		vs_child_physical_add_after_rmvl,
		vn_client_id_of_person_from_whom_child_physically_removed,
		vs_clientname_of_person_from_whom_child_physically_removed,
		vn_relationship_id_of_person_from_whom_child_physically_removed,
		vs_relationship_of_person_from_whom_child_physically_removed,
		vd_first_prnt_sign_dt,
		vd_second_prnt_sign_dt,
		vs_missing_scnd_prnt_note,
		vd_youth_sign_dt,
		vs_prvs_fc_epsde_exist,
		vs_rsn_for_exit,
		vd_prvs_fc_exit_dt,
		vd_grdn_sign_dt,
		vn_vpa_sign_client_id,
		vd_second_prnt_id,
		vd_grdn_sign_id,
		vs_vpa_sign_client,
		vd_ldss_sign_dt,
		vd_rsnbl_efrts_crt_hrng_dt,
		vs_rsnbl_effrts_fndng_tmly;
   	
RETURN QUERY SELECT *
               FROM Temp_worksheet_removal_info;
              
DROP TABLE Temp_worksheet_removal_info;

   END
    $function$
