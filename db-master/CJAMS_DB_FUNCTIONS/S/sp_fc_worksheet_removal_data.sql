DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_removal_info(al_client_id bigint, al_removal_id bigint);

CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_removal_info(al_client_id bigint, al_removal_id bigint)
 RETURNS TABLE(client_id bigint, typeofremoval character varying, courtordered character varying, typeofvpa character varying, issafehavenbaby character varying, childphysicalremovaldate date, childphysicaladdressafterremoval character varying, clientidofpersonfromwhomchildwasphysicallyremoved integer, clientnameofpersonfromwhomchildwasphysicallyremoved character varying, relationshipidofpersonfromwhomchildwasphysicallyremoved integer, relationshipofpersonfromwhomchildwasphysicallyremoved character varying, dateof1stparentsignatureonvpa date, dateof2ndparentsignatureonvpa date, mandatorynoteonmissing2ndparentsignatureonvpa character varying, dateofyouthsignatureonvpa date, previousfostercareepisodeexist character varying, reasonforexit character varying , reasonforexitcode character varying, exitcaredatefrompreviousfostercareepisode date, dateofguardiansignatureonvpa date, clientidwhosignedvpa integer, parent2id integer, guardianid integer, clientnamewhosignedvpa character varying, dateofldsssignatureonvpa date, dateofreasonableeffortscourthearing timestamp without time zone, isreasonableeffortsfindingtimely character varying)
 LANGUAGE plpgsql
AS $function$

-----------------------------------------------------------------
-- CDM-23211 06-29 - Veera TO get LIVING arrangment when Removal date is between the start and end dates
-- CDM-23090 - Veera Removal Address fixes
-- CDM-22606 - Veera - 05-26-22
-- CDM-21495 - 03-28-2022 Child Physical address removal issue fix Rollback changes to CDM-17386
-- CDM-22007 - Vijaya Laxmi - Child Physical Address After Removal - placmenttype PRPL when LA physical address is null
-- CDM-28089 - Removal Reason missing for chessie cases
-- CIDM-8716 - adding removal reasons for corticon
-- CJAMS-60243 - Living arrangement address fix 
----------------------------------------------------------------

DECLARE 
		vs_Procedure_nm 														VARCHAR(100) DEFAULT 'sp_fc_worksheet_removal_info';		
		vs_typeofremoval														VARCHAR(50);
		vs_crt_ord																VARCHAR(50);
		vs_typeofvpa															VARCHAR(50);
		vs_safehavenbaby														VARCHAR(50);
		vd_child_physical_rmvl_dt												DATE;
		vs_child_physical_add_after_rmvl										VARCHAR(500);
		la_child_physical_add                                                   VARCHAR(500);
		vn_client_id_of_person_from_whom_child_physically_removed				INTEGER;
		vs_clientname_of_person_from_whom_child_physically_removed				VARCHAR(250);
		vn_relationship_id_of_person_from_whom_child_physically_removed			INTEGER;
		vs_relationship_of_person_from_whom_child_physically_removed			VARCHAR(100);
		vd_first_prnt_sign_dt													DATE;
		vd_second_prnt_sign_dt													DATE;
		vs_missing_scnd_prnt_note												VARCHAR;
		vd_youth_sign_dt														DATE;
		vs_prvs_fc_epsde_exist													VARCHAR(50);
		vs_rsn_for_exit															VARCHAR(100);
		vs_rsn_for_exit_cd														VARCHAR(100);
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
-- CREATE TEMP TABLE IF NOT EXISTS
-- Temp_worksheet_removal_info ( 
-- 		client_id 													BIGINT,		
-- 		typeofremoval												VARCHAR(50),
-- 		courtordered												VARCHAR(50),
-- 		typeofvpa													VARCHAR(50),
-- 		issafehavenbaby												VARCHAR(50),
-- 		childphysicalremovaldate									DATE,
-- 		childphysicaladdressafterremoval							VARCHAR(500),
-- 		clientidofpersonfromwhomchildwasphysicallyremoved			INTEGER,
-- 		clientnameofpersonfromwhomchildwasphysicallyremoved			VARCHAR(250),
-- 		relationshipidofpersonfromwhomchildwasphysicallyremoved		INTEGER,
-- 		relationshipofpersonfromwhomchildwasphysicallyremoved		VARCHAR(100),
-- 		dateof1stparentsignatureonvpa								DATE,
-- 		dateof2ndparentsignatureonvpa								DATE,
-- 		mandatorynoteonmissing2ndparentsignatureonvpa				VARCHAR(5000),
-- 		dateofyouthsignatureonvpa									DATE,
-- 		previousfostercareepisodeexist								VARCHAR(50),
-- 		reasonforexit												VARCHAR(100),
-- 		exitcaredatefrompreviousfostercareepisode					DATE,
-- 		dateofguardiansignatureonvpa								DATE,
-- 		clientidwhosignedvpa										INTEGER,
-- 		parent2id													INTEGER,
-- 		guardianid													INTEGER,
-- 		clientnamewhosignedvpa										VARCHAR(250),
-- 		dateofldsssignatureonvpa									DATE,
-- 		dateofreasonableeffortscourthearing							TIMESTAMP,
-- 		isreasonableeffortsfindingtimely							VARCHAR(50)
-- 	);

-- Type of Removal/ Court Order / Safehaven Baby / Child Physical Removal Date / VPA 1st Parent Signed ID and Date / VPA 2nd Parent Signed ID and Date / Mandatory Note On Missing 2nd Parent Signature On VPA 
--  VPA Youth Signed Date / Previous Foster Care Eepisode Exist / Previous FC Episode Exit Care Date / VPA Guardian Signed Date & VPA Signed Client ID / VPA LDSS Signed Date   
SELECT ( CASE WHEN (rtrim(isrcr.removaltypekey) = 'TLV' 
				OR rtrim(isrcr.removaltypekey) = 'CDVP' 
				OR rtrim(isrcr.removaltypekey) = 'EHA' ) 
				THEN 'Voluntary_Placement_Agreement'::VARCHAR 
			  WHEN (isrcr.removaltypekey = 'JD'  OR isrcr.removaltypekey = 'SHB') 
				THEN 'Court_Order'::VARCHAR ELSE 'None'::VARCHAR END ),
	( CASE WHEN (rtrim(isrcr.removaltypekey) = 'JD')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
	( CASE WHEN (rtrim(isrcr.removaltypekey) = 'SHB')
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
	isrcr.removaldate , isrcr.vpaparentssigneddate, isrcr.parent1id , isrcr.parent2signeddate, isrcr.parent2id , isrcr.parent2comments , isrcr.vpayouthsigneddate, 
	isrcr.vpaguardiansigneddate, isrcr.guardianid , isrcr.agencysigneddate
	INTO vs_typeofremoval , vs_crt_ord , vs_safehavenbaby , vd_child_physical_rmvl_dt , vd_first_prnt_sign_dt, vn_vpa_sign_client_id , vd_second_prnt_sign_dt, vd_second_prnt_id ,
	 vs_missing_scnd_prnt_note , vd_youth_sign_dt , vd_grdn_sign_dt, vd_grdn_sign_id , vd_ldss_sign_dt 
  	FROM intakeservreqchildremoval isrcr WHERE  isrcr.removalid::bigint = al_removal_id;
 
-- Type of VPA
SELECT ( CASE rv.value_text WHEN 'Time-limited Voluntary Placement'
 				THEN 'Time-Limited'::VARCHAR WHEN 'Children With Disabilities Voluntary Placement' THEN 'Child with Disabilities'::VARCHAR
 				WHEN 'Enhanced aftercare' THEN 'EA-VPA'::VARCHAR END )
	INTO vs_typeofvpa
  	FROM referencevalues rv, intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per
WHERE referencetypeid = 53 AND rv.activeflag = 1
    AND TRIM(rv.ref_key) = TRIM(isrcr.removaltypekey)
	AND pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1
	AND (isra.servicecaseid = pl.servicecaseid or isra.intakeserviceid = isrcr.intakeserviceid)
	AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 AND isrcr.removalid::bigint = al_removal_id order by isrcr.updatedon desc limit 1;
   


-- Living Arrangment Removal Address 
 select concat(TRIM(lva.streettext), ' ' , lva.streetname, ' ' , INITCAP(lva.streetsuffixtypekey), ',' , lva.cityname, ',' , lva.statetypekey, '-' ,lva.zip5no)::character varying 
 INTO la_child_physical_add
 from placement pl 
 join person per on per.personid = pl.personid and per.activeflag = 1
 join livingarrangement lva on lva.placementid = pl.placementid and lva.activeflag = 1
 where pl.activeflag = 1 AND per.personid = pl.personid and per.cjamspid::BIGINT = al_client_id 
 AND per.activeflag = 1 and pl.placementtypekey = 'LA'  and pl.startdatetime:: date <= vd_child_physical_rmvl_dt::date
 and (pl.enddatetime is null or pl.enddatetime::date >= vd_child_physical_rmvl_dt::date) order by pl.startdatetime asc limit 1;

-- RAISE NOTICE 'vd_child_physical_rmvl_dt : %', vd_child_physical_rmvl_dt ;                                                                                                                                                                          
-- RAISE NOTICE 'la_child_physical_add : %', la_child_physical_add ; 

-- CDM-23091 Issue Fix
if la_child_physical_add IS NOT NULL then
	select la_child_physical_add into vs_child_physical_add_after_rmvl;
else 
	-- Child Physical Address After Removal  
	SELECT 
		case when pl.placementtypekey = 'PRPL' then 
		(select 
		( CAST
		 (
		 TRIM(COALESCE(tpa.adr_street_tx::VARCHAR,''))||' '|| TRIM(COALESCE(tpa.adr_street_nm,'')) ||' '||TRIM(COALESCE(tpa.adr_city_nm,'')) ||' '||
		 TRIM(COALESCE(tpa.adr_state_cd,'')) ||' '||TRIM(COALESCE(tpa.adr_zip5_no::VARCHAR,'')) 
		 AS CHARACTER VARYING )) from tb_provider tp inner join tb_provider_addresses tpa on 
			tpa.delete_sw = 'N' AND tpa.adr_default_sw = 'Y'  AND tp.provider_id = tpa.parent_key_id::int4
			 where pl.altproviderid = tp.provider_id AND tp.delete_sw = 'N' and tpa.adr_type_cd = '3357' and pl.startdatetime::date >= vd_child_physical_rmvl_dt::date limit 1)
		else null
		End
	INTO vs_child_physical_add_after_rmvl
	FROM  placement pl, person per, intakeservreqchildremoval isrcr
	WHERE  pl.activeflag = 1 AND isrcr.intakeservreqchildremovalid = pl.intakeservreqchildremovalid
	AND per.personid = pl.personid AND per.cjamspid::BIGINT = al_client_id and isrcr.removalid::bigint = al_removal_id AND per.activeflag = 1 
	and pl.startdatetime::date >= vd_child_physical_rmvl_dt::date 
	and pl.placementtypekey = 'PRPL' -- when placementtype is PRPL
	order by pl.startdatetime asc limit 1;
end if;	



-- Client ID of Person From Whom Child Physically Removed and Client Name of Person From Whom Child Physically Removed
SELECT DISTINCT per.cjamspid , (COALESCE(per.firstname)||' '|| COALESCE(per.lastname))::VARCHAR
	INTO vn_client_id_of_person_from_whom_child_physically_removed , vs_clientname_of_person_from_whom_child_physically_removed
	FROM intakeservreqchildremoval isrcr 
	join person per on per.personid = isrcr.primarycaregiveractorid 
	where isrcr.removalid::bigint = al_removal_id AND isrcr.activeflag = 1; 

-- Relationship of Person From Whom Child Physically Removed 
SELECT rt.fourerelid, (case when rt.description is null then cr.rmvdfrmpersonname else rt.description end)
	INTO vn_relationship_id_of_person_from_whom_child_physically_removed, vs_relationship_of_person_from_whom_child_physically_removed
  	FROM relationshiptype rt, actorrelationship ar, person p, intakeservreqchildremoval cr
WHERE TRIM(rt.relationshiptypekey) = TRIM(ar.relationshiptypekey)  
	AND ar.person2id = p.personid AND ar.person1id = cr.primarycaregiveractorid
	and rt.activeflag = 1 and ar.activeflag = 1 and p.activeflag = 1
	AND p.cjamspid::BIGINT = al_client_id and cr.removalid = al_removal_id
	ORDER BY ar.updatedon desc LIMIT 1;
	

-- previous Foster care Exist and Reason For Exit
SELECT isrcr.exitdate, 'YES',
    (select rv.description from referencevalues rv where rv.ref_key = isrcr.removalexitreason and rv.referencetypeid = '343' order by rv.updatedon desc limit 1),
	isrcr.removalexitreason
	INTO vd_prvs_fc_exit_dt, vs_prvs_fc_epsde_exist, vs_rsn_for_exit, vs_rsn_for_exit_cd
  	FROM referencevalues rv, intakeservreqchildremoval isrcr, placement pl, intakeservicerequestactor isra, person per
WHERE pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1 AND pl.placementtypekey = 'PRPL'
	AND isra.servicecaseid = pl.servicecaseid 
	AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 and isrcr.exitdate IS NOT NULL order by isrcr.insertedon desc limit 1;
   
--  VPA Signed Client
SELECT DISTINCT ( CASE WHEN ( rtrim(isrcr.removaltypekey) = 'TLV' 
				OR rtrim(isrcr.removaltypekey) = 'CDVP' 
				OR rtrim(isrcr.removaltypekey) = 'EHA' ) 
				THEN ( SELECT (COALESCE(crgvr.firstname)||' '|| COALESCE(crgvr.lastname))::VARCHAR ) 
						ELSE NULL END )
	INTO vs_vpa_sign_client
	FROM intakeservreqchildremoval isrcr, person crgvr, intakeservicerequestactor crgvrisra, placement pl, intakeservicerequestactor isra, person per
WHERE crgvrisra.personid = crgvr.personid AND crgvrisra.intakeservicerequestpersontypekey = 'AM' 
	AND crgvrisra.servicecaseid = pl.servicecaseid AND crgvrisra.activeflag = 1 AND pl.activeflag = 1
	AND isra.servicecaseid = pl.servicecaseid 
	AND isra.intakeservicerequestactorid = pl.intakeservicerequestactorid 
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 AND isrcr.removalid::bigint = al_removal_id limit 1;

-- Reasonable efforts Court Hearing Date
SELECT MIN(isrch.hearingdatetime)
  	INTO vd_rsnbl_efrts_crt_hrng_dt
  	FROM intakeservicerequestcourtaction isrca, intakeservicerequestcourthearing isrch, intakeservreqchildremoval isrcr
WHERE isrca.intakeservicerequestcourthearingid = isrch.intakeservicerequestcourthearingid AND isrch.activeflag = 1
	AND isrca.reasonableeffortsflag = 1 AND isrca.intakeservicerequestid = isrcr.intakeserviceid AND isrca.activeflag = 1
	AND isrcr.activeflag = 1 AND isrcr.removalid::bigint = al_removal_id;  	
  
-- Reasonable Efforts Finding Timely 
SELECT ( CASE WHEN ( (vs_typeofremoval = 'Court_Order' AND extract(day from age(vd_rsnbl_efrts_crt_hrng_dt, isrcr.removaldate)) <= 60) 
				OR (vs_typeofremoval = 'Voluntary_Placement_Agreement' AND extract(day from age(vd_rsnbl_efrts_crt_hrng_dt, isrcr.removaldate)) <= 180) )
 				THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END  ) 
	INTO vs_rsnbl_effrts_fndng_tmly
  	FROM intakeservreqchildremoval isrcr
WHERE isrcr.activeflag = 1 AND isrcr.removalid::bigint = al_removal_id;	
 
-- INSERT INTO Temp_worksheet_removal_info
RETURN QUERY
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
		vs_rsn_for_exit_cd,
		vd_prvs_fc_exit_dt,
		vd_grdn_sign_dt,
		vn_vpa_sign_client_id,
		vd_second_prnt_id,
		vd_grdn_sign_id,
		vs_vpa_sign_client,
		vd_ldss_sign_dt,
		vd_rsnbl_efrts_crt_hrng_dt,
		vs_rsnbl_effrts_fndng_tmly;
   	
-- RETURN QUERY SELECT *
--                FROM Temp_worksheet_removal_info;
              
-- DROP TABLE Temp_worksheet_removal_info;

   END
    $function$
;
