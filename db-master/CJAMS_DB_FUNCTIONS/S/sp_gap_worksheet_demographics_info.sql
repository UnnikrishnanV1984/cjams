DROP FUNCTION IF EXISTS cjams.sp_gap_worksheet_demographics_info(al_client_id bigint , al_removal_id bigint);
DROP FUNCTION IF EXISTS cjams.sp_gap_worksheet_demographics_info(al_client_id bigint);
CREATE OR REPLACE FUNCTION cjams.sp_gap_worksheet_demographics_info(al_client_id bigint , al_gap_subsidy_id bigint)
 RETURNS TABLE(client_id bigint, al_removal_id bigint, gap_subsidy_id bigint, childname character varying, dateofbirth timestamp without time zone, gender character varying, personid uuid ,childguardianid integer, childguardianname character varying, childsecguardianid integer, childsecguardianname character varying, guardianshipagreementsigneddate timestamp without time zone, secondaryguardianshipagreementsigneddate timestamp without time zone, dateofcourtorderguardianshipfinalization timestamp without time zone, siblinginfo json, casenumber character varying, childjurisdiction character varying,  createdate timestamp without time zone,  
 				servicecaseid uuid, guardianshipapplicationdate timestamp without time zone, primaryguardianisrelative character varying, primaryguardianrelationshipid integer, primaryguardianrelationship character varying, secondaryguardianisrelative character varying, secondguardianrelationshipid integer, secondguardianrelationship character varying, haapprovaldtjson json, latestfcplacementstartdatewithperpectiveguardian timestamp without time zone, fosterhomeapprover character varying, secondguardianexists boolean,
 				successorguardianexists boolean, successorguardianname character varying, successorguardianid integer, dateofsuccessionaddendum timestamp without time zone, yesindicatetypeofremoval boolean, nochildisnoteligibleforgap boolean, removalcourtorderdate timestamp without time zone, removalvpadate timestamp without time zone, childremovedbyvpa boolean, childremovedbycrt boolean, isconsultationchildage character varying, isguardianattach character varying, ischildsecondguardianattach character varying, isreunificationremoved character varying, isadoptionremoved character varying, iscgprovidesafe character varying, 
				secguardlivingwithpriguard character varying, last6monthfiscalpaymentstatus character varying, providerapprovalid INTEGER, isasiblingofachildgappayments  BOOLEAN, isnotasiblingofachildgappayments BOOLEAN, siblinginformationgrid  JSON)
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------------------------------------------
-- Revision(s) 

--02/23/2024 Smitha Somasekharan-CIDM-8351-b-185141-gapdetermination userstory changes
-- CIDM - 10166 Veera Nadimpalli - Gap Subsidy ID changes 
-- B-21081 - GAP home approval date changes - 02/27/25
-- CDM-44259/CDM-44260 - Veera Nadimpalli - To load GAP home approval dates 
-- CDM-43245 / CDM-44282/CJAMS-58118/CJAMS-58043/CJAMS-58044 - Veera Nadimpalli - To include closed Providers to run GAP Eligibility
-- CDM-44310/CDM-44311 - Veera Nadimpalli - To get records based on person id
------------------------------------------------------------------------------------------------------------	

DECLARE 
		vs_Procedure_nm 										VARCHAR(100) DEFAULT 'sp_gap_worksheet_demographics_info';
		vs_chld_nm												VARCHAR(250);
		vd_birth_dt												TIMESTAMP;
		vs_gender												VARCHAR(20);
		vd_person_id						                    UUID;
		vn_grd_id												INTEGER;
		vs_grd_one_nm											VARCHAR(200);
		vn_grd_two_id											INTEGER;
		vs_grd_two_nm											VARCHAR(200);
		vd_grd_agmt_dt											TIMESTAMP;
		vd_sec_grd_agmt_dt										TIMESTAMP;
		vd_grd_fnl_crt_ord_dt									TIMESTAMP;		
        vn_ive_sibling_info                                     JSON;
		vd_crtd_dt                                              TIMESTAMP WITHOUT TIME ZONE;
		vs_jrsdctn                                              VARCHAR(50);
		vs_srv_req_no                                           VARCHAR(50);
		vn_srv_req_id                                           UUID; 
		vd_grd_appl_dt											TIMESTAMP;
		vs_pri_is_rltv											VARCHAR(20);							
		vn_pri_rltn_id											INTEGER;
		vs_pri_rltn												VARCHAR(200);
		vs_sec_is_rltv											VARCHAR(20);
		vn_sec_rltn_id											INTEGER;
		vs_sec_rltn												VARCHAR(200);
		vd_haapprovaldtjson										json;
		vd_ltst_fc_plcmt_st_dt_with_grd							TIMESTAMP;
		vs_fstr_hm_aprvr 										varchar(50);
		vd_pri_rel_key											varchar;
	 	vd_sec_rel_key											varchar;
		vs_scnd_grd_exts 										boolean;
		vs_suc_grd_exts											boolean;
		vs_succ_grdn_nm											VARCHAR(250);
		vn_succ_grdn_id											INTEGER;
		vd_succ_adndm_dt										TIMESTAMP;
		vs_chld_rmvd_vpa_crt									boolean;
		vd_child_rmvl_crt_ord_dt								TIMESTAMP;
		vd_child_rmvl_vpa_dt									TIMESTAMP;
		vs_age_appr_cnslt_pl 									VARCHAR(20);
	    vs_chd_grd_attch 										VARCHAR(20);
	   	vs_chd_sec_grd_attch									VARCHAR(20);
	    vs_reunfn_rmvd 											VARCHAR(20);
	    vs_adp_rmvd    											VARCHAR(20);
		vs_iscgprovidesafe 										VARCHAR(20);
		vs_sec_grd_lvng_with_pri_grd 							varchar(25);
		vs_lst_6_mnth_pymnt_stus								VARCHAR(20); 
		vs_gap_id												UUID;
		vd_child_crt_ord_flag									boolean;
		vd_child_vpa_flag										boolean;	
		al_removal_id											bigint;
		vd_gap_elinfo_count										int;
		vd_yesindicatetypeofremoval                             BOOLEAN;
		vd_nochildisnoteligibleforgap							BOOLEAN;
		vd_providerapprovalid                                   INTEGER;
		vd_isasiblingofachildgappayments                        BOOLEAN;
		vd_isnotasiblingofachildgappayments                     BOOLEAN;
		vd_siblinginformationgrid                               JSON DEFAULT '[]'::json;
		vn_guardian_id                                          INTEGER;
	
 BEGIN	
CREATE TEMP TABLE IF NOT EXISTS
Temp_worksheet_demographics_info ( 
		client_id 												BIGINT,
		al_removal_id 											BIGINT,
		gap_subsidy_id                                          BIGINT,
		childname												VARCHAR(250),
		dateofbirth												TIMESTAMP,
		gender													VARCHAR(20),
		personid									            UUID,
		childguardianid											INTEGER,
		childguardianname										VARCHAR(250),
		childsecguardianid										INTEGER,
		childsecguardianname									VARCHAR(250),
		guardianshipagreementsigneddate							TIMESTAMP,
		secondaryguardianshipagreementsigneddate				TIMESTAMP,
		dateofcourtorderguardianshipfinalization				TIMESTAMP,
        siblinginfo                                             JSON,
		casenumber                                              VARCHAR(50),
		childjurisdiction                                       VARCHAR(50),
		createdate                                              TIMESTAMP WITHOUT TIME ZONE,
		servicecaseid                                           UUID,		
		guardianshipapplicationdate								TIMESTAMP,
		primaryguardianisrelative								VARCHAR(20),
		primaryguardianrelationshipid							INTEGER,
		primaryguardianrelationship								VARCHAR(200),
		secondaryguardianisrelative								VARCHAR(20),
		secondguardianrelationshipid							INTEGER,
		secondguardianrelationship								VARCHAR(200),
		haapprovaldtjson										JSON,
		latestfcplacementstartdatewithperpectiveguardian		TIMESTAMP,
		fosterhomeapprover 						 				varchar(50),
		secondguardianexists 									boolean,
		successorguardianexists									boolean,
		successorguardianname									VARCHAR(250),
		successorguardianid										INTEGER,
		dateofsuccessionaddendum								TIMESTAMP,
		childremovedbyvpaorcrt									boolean,
		nochildisnoteligibleforgap								boolean,
		removalcourtorderdate									TIMESTAMP,
		removalvpadate											TIMESTAMP,
		childremovedbycrt										boolean,
		vd_child_vpa_flag										boolean,
		isconsultationchildage                   				VARCHAR(20),
		isguardianattach                         				VARCHAR(20),
		ischildsecondguardianattach			                    VARCHAR(20),
		isreunificationremoved                   				VARCHAR(20),
		isadoptionremoved                       				VARCHAR(20),
		iscgprovidesafe 						 				VARCHAR(20),
		secguardlivingwithpriguard 								varchar(25),
		last6monthfiscalpaymentstatus							VARCHAR(20),
		providerapprovalid                                   	INTEGER,
		isasiblingofachildgappayments                        	BOOLEAN,
		isnotasiblingofachildgappayments                     	BOOLEAN,
		siblinginformationgrid                               	JSON	
	);	

select count(*) into vd_gap_elinfo_count from gapeligibilityinfo gei where gei.client_id = al_client_id and gei.guardian_subsidy_id = al_gap_subsidy_id  and gei.activeflag = 1;

IF vd_gap_elinfo_count > 0 THEN

	SELECT gei.client_id, gei.al_removal_id, gei.guardian_subsidy_id, gei.childname, gei.dateofbirth, gei.gender, gei.personid, gei.childguardianid, gei.childguardianname, gei.childsecguardianid, gei.childsecguardianname, 
			gei.guardianshipagreementsigneddate, gei.secondaryguardianshipagreementsigneddate, gei.dateofcourtorderguardianshipfinalization, gei.casenumber, gei.childjurisdiction, gei.createdate, 
			gei.servicecaseid, gei.guardianshipapplicationdate, gei.primaryguardianisrelative, gei.primaryguardianrelationshipid, gei.primaryguardianrelationship, gei.secondaryguardianisrelative, gei.secondguardianrelationshipid, 
			gei.secondguardianrelationship, gei.haapprovaldtjson, gei.latestfcplacementstartdatewithperpectiveguardian, gei.fosterhomeapprover, gei.secondguardianexists, gei.successorguardianexists, 
			gei.successorguardianname, gei.successorguardianid, gei.dateofsuccessionaddendum, gei.yesindicatetypeofremoval, gei.nochildisnoteligibleforgap, gei.removalcourtorderdate, gei.removalvpadate, gei.childremovedbyvpa, 
			gei.childremovedbycrt, gei.isconsultationchildage, gei.isguardianattach, gei.ischildsecondguardianattach, gei.isreunificationremoved, gei.isadoptionremoved, gei.iscgprovidesafe, gei.secguardlivingwithpriguard, 
			gei.last6monthfiscalpaymentstatus, gei.providerapprovalid, gei.isasiblingofachildgappayments, gei.isnotasiblingofachildgappayments, gei.siblinginformationgrid
	INTO al_client_id, al_removal_id, al_gap_subsidy_id, vs_chld_nm, vd_birth_dt, vs_gender, vd_person_id, vn_grd_id, vs_grd_one_nm, vn_grd_two_id, vs_grd_two_nm, vd_grd_agmt_dt,	vd_sec_grd_agmt_dt,	vd_grd_fnl_crt_ord_dt,
          vs_srv_req_no, vs_jrsdctn, vd_crtd_dt, vn_srv_req_id, vd_grd_appl_dt, vs_pri_is_rltv, vn_pri_rltn_id, vs_pri_rltn, vs_sec_is_rltv, vn_sec_rltn_id, vs_sec_rltn, vd_haapprovaldtjson,
		  vd_ltst_fc_plcmt_st_dt_with_grd, vs_fstr_hm_aprvr, vs_scnd_grd_exts, vs_suc_grd_exts, vs_succ_grdn_nm,	vn_succ_grdn_id, vd_succ_adndm_dt, vd_yesindicatetypeofremoval, vd_nochildisnoteligibleforgap,
		  vd_child_rmvl_crt_ord_dt,	vd_child_rmvl_vpa_dt, vd_child_vpa_flag, vd_child_crt_ord_flag,	vs_age_appr_cnslt_pl, vs_chd_grd_attch, vs_chd_sec_grd_attch, vs_reunfn_rmvd, vs_adp_rmvd, vs_iscgprovidesafe, vs_sec_grd_lvng_with_pri_grd,
		  vs_lst_6_mnth_pymnt_stus, vd_providerapprovalid, vd_isasiblingofachildgappayments, vd_isnotasiblingofachildgappayments, vd_siblinginformationgrid

	FROM cjams.gapeligibilityinfo gei where gei.client_id = al_client_id and gei.guardian_subsidy_id = al_gap_subsidy_id and gei.activeflag = 1;


if ((vd_haapprovaldtjson is not null and vd_haapprovaldtjson -> 0 ->> 'parent_provider_name' is null) or vd_haapprovaldtjson is null ) then 

     raise notice 'test 157 %', vd_haapprovaldtjson  ->> 'text';
	 raise notice 'test 157 %', vd_haapprovaldtjson  ->> 'value';
	 raise notice 'test 157 %', vd_haapprovaldtjson  ->> 'parent_provider_name';

 select json_agg(x)  into vd_haapprovaldtjson from (
    SELECT tpa.ha_approval_dt as text, tpa.provider_approval_id as value , tpv.description_tx as approval_cd
		FROM tb_provider_approval tpa 
		join tb_picklist_values tpv on  tpv.picklist_value_cd =  tpa.approval_type_cd and picklist_type_id = '367' and tpv.delete_sw = 'N'
		WHERE tpa.provider_id = vn_grd_id and tpa.approval_status_cd in ('0','3579') ORDER BY tpa.ha_approval_dt DESC --and tpa.active_sw = 'Y';
  ) as x; 


end if;

-- Sibling information  
	SELECT 
	Json_agg(e) into vn_ive_sibling_info
	FROM 
	(
		select isi.* from ivesiblinginfo isi where isi.toclientid ::BIGINT = al_client_id AND isi.activeflag = 1		
	) AS e; 

ELSE 

vs_lst_6_mnth_pymnt_stus = 'YES';

vs_sec_grd_lvng_with_pri_grd = 'YES';

-- Child Name  , Date of Birth , Gender 
SELECT concat(per.firstname, ' ', per.middlename, ' ', per.lastname)  , per.dob , per.gendertypekey , per.personid
	INTO vs_chld_nm, vd_birth_dt, vs_gender , vd_person_id
  	FROM person as per     
WHERE per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1;

-- Guardian and gap application info
-- Guardian ID  / Guardian Name / Guardian Two ID / Guardian Two Name /  Guardian DOB / Child Jurisdiction 
-- Guardian Agreement  , Secondary Guardianship Agreement Signed Date 
-- guardianshipagreementsigneddate,secondaryguardianshipagreementsigneddate // valid for primarypermanencytype in ('Guardianship','GUARDR')

raise notice 'test 177 %',al_gap_subsidy_id;

select 
	gs.gapid, (case when (gs.guardiantwoname is not null) then true else false end ), gs.successorguardianname , gs.successorguardianid, gs.successionaddendumdate,
	( CASE WHEN (gs.successorguardianname IS NOT NULL) THEN true ELSE false END ), gs.guardianoneproviderid, gs.guardiantwoproviderid, gs.guardianonename, gs.guardiantwoname, 
    ( CASE WHEN (gapp.ldssdirectordate IS NOT NULL AND gapp.guardianonedate IS NOT NULL AND gapp.guardiantwodate IS NOT NULL) THEN GREATEST(gapp.ldssdirectordate, gapp.guardianonedate, gapp.guardiantwodate) ELSE GREATEST(gapp.ldssdirectordate, gapp.guardianonedate) end) as gapapplicationdate,
    gagg.guardianonedate as g1aggrementdate, gagg.guardiantwodate as g2aggrementdate,
	(select r.insertedon from routing r where r.objectid::varchar = gagg.gapagreementid::varchar and r.activeflag = 1 and r.routingstatustypeid = 16 limit 1),
	(select sc.servicecasenumber from servicecase sc where sc.servicecaseid = pp.servicecaseid and sc.activeflag = 1), pp.servicecaseid, gs.primaryrelationshipkey, gs.secondaryrelationshipkey,
	pl.startdatetime, isrcr.removalid, gs.alternateid
INTO vs_gap_id, vs_scnd_grd_exts, vs_succ_grdn_nm , vn_succ_grdn_id , vd_succ_adndm_dt, vs_suc_grd_exts, vn_grd_id, vn_grd_two_id, vs_grd_one_nm, vs_grd_two_nm, 
	 vd_grd_appl_dt, vd_grd_agmt_dt, vd_sec_grd_agmt_dt, vd_crtd_dt, vs_srv_req_no, vn_srv_req_id, vd_pri_rel_key, vd_sec_rel_key, vd_ltst_fc_plcmt_st_dt_with_grd, al_removal_id, al_gap_subsidy_id
FROM guardianship gs
	inner join gapapplication gapp on gapp.gapid = gs.gapid 
	inner join gapagreement gagg on gagg.gapid = gs.gapid and gagg.activeflag = 1
	join permanencyplan pp on pp.permanencyplanid = gs.permanencyplanid and pp.activeflag = 1
	JOIN servicecase sc ON sc.servicecaseid = gs.servicecaseid AND sc.activeflag = 1
	join intakeservicerequestactor isra on isra.intakeservicerequestactorid = pp.intakeservicerequestactorid and isra.activeflag = 1
	join person p on p.personid = isra.personid 
	join intakeservreqchildremoval isrcr on isrcr.personid = isra.personid and isrcr.activeflag = 1
	join placement pl on pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid AND pl.activeflag = 1
WHERE p.cjamspid::bigint = al_client_id and gs.alternateid = al_gap_subsidy_id order by pl.startdatetime desc limit 1;

raise notice 'test %',al_gap_subsidy_id;


select pl.altproviderid
INTO vn_guardian_id
FROM guardianship gs
inner join gapapplication gapp on gapp.gapid = gs.gapid
inner join gapagreement gagg on gagg.gapid = gs.gapid
join permanencyplan pp on pp.permanencyplanid = gs.permanencyplanid
join intakeservicerequestactor isra on isra.intakeservicerequestactorid = pp.intakeservicerequestactorid and isra.servicecaseid = pp.servicecaseid
join intakeservreqchildremoval isrcr on isrcr.servicecaseid = pp.servicecaseid and isrcr.intakeservicerequestactorid = isra.intakeservicerequestactorid
join placement pl on pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid
AND pl.activeflag = 1
and coalesce(pl.isvoided, 0) <> 1
and (select count(*)
from routing
where routing.routingstatustypeid = 16
and routing.eventcode::text = 'PLTR'::text
and routing.activeflag = 1
and routing.objectid = pl.placementid::character varying
) > 0
and pl.altproviderid is not null
and gagg.startdate > pl.startdatetime --and gs.guardianoneproviderid = pl.altproviderid
join person p on p.personid = isra.personid
WHERE p.cjamspid::bigint = al_client_id and gs.alternateid = al_gap_subsidy_id
order by pl.startdatetime desc
limit 1 ;


raise notice 'vn_guardian_id %',vn_guardian_id;

-- Primary Guardian Relationship ID /-- Primary Guardian Relationship 
SELECT rt.fourerelid , rt.description::VARCHAR , 
	(case 
		when rt.fourerelid = '1001' then 'YES'
		when rt.fourerelid = '1014' then 'YES'
		else 'NO'
	  end) 				
	INTO vn_pri_rltn_id , vs_pri_rltn , vs_pri_is_rltv
  	FROM relationshiptype rt
	WHERE lower(rt.relationshiptypekey) = lower(vd_pri_rel_key);	
		
-- Secondary Guardian Relationship ID /Secondary Guardian Relationship
SELECT rt.fourerelid , rt.description::VARCHAR , 
	(case 
		when rt.fourerelid = '1001' then 'YES'
		when rt.fourerelid = '1014' then 'YES'
		else 'NO'
	  end) 	
	INTO vn_sec_rltn_id , vs_sec_rltn , vs_sec_is_rltv
  	FROM relationshiptype rt
WHERE lower(rt.relationshiptypekey) = lower(vd_sec_rel_key);

-- Foster Parent Full Approval Date  
select json_agg(x)  into vd_haapprovaldtjson from 
	(
	SELECT tpa.ha_approval_dt as text, tpa.provider_approval_id as value , tpv.description_tx as approval_cd
		FROM tb_provider_approval tpa 
		join tb_picklist_values tpv on  tpv.picklist_value_cd =  tpa.approval_type_cd and picklist_type_id = '367' and tpv.delete_sw = 'N'
		WHERE tpa.provider_id = vn_grd_id and tpa.approval_status_cd in ('0','3579') ORDER BY tpa.ha_approval_dt DESC --and tpa.active_sw = 'Y';
	) as x;	

-- Foster Home Approver  
if vn_guardian_id is null then
   select (CASE when tp.picklist_value_cd = '1783' then 'LDSS' else 'CPA' end) 
	into vs_fstr_hm_aprvr 
    from tb_provider_picklist tp
where tp.provider_id = vn_grd_id and tp.picklist_type_id = 155 and tp.picklist_value_cd not in ('3304', '3305');
else
	select (CASE when tp.picklist_value_cd = '1783' then 'LDSS' else 'CPA' end) 
	into vs_fstr_hm_aprvr 
    from tb_provider_picklist tp
	where tp.provider_id = vn_guardian_id and tp.picklist_type_id = 155 and tp.picklist_value_cd not in ('3304', '3305');
end if;




-- Removal Court Order Date

SELECT true, dateoffindingctwdecision, vparemovaldate,
	case when typeofremoval = 'Court_Order' then true else false end, 
	case when typeofremoval = 'Voluntary_Placement_Agreement' then true else false end  INTO vs_chld_rmvd_vpa_crt, vd_child_rmvl_crt_ord_dt , vd_child_rmvl_vpa_dt, vd_child_crt_ord_flag, vd_child_vpa_flag
	FROM 	tb_ive_fostercare_audit tifa
WHERE 	tifa.cjamspid = al_client_id and tifa.sqnm_sw = 'I' and (dateoffindingctwdecision is not null or vparemovaldate  is not null) order by tifa.insertedon desc limit 1;

IF vs_chld_rmvd_vpa_crt is null THEN
	vd_yesindicatetypeofremoval = false;
	vd_nochildisnoteligibleforgap = true;
ELSE
	vd_yesindicatetypeofremoval = vs_chld_rmvd_vpa_crt;
	vd_nochildisnoteligibleforgap = false;
END IF;

-- Age Appropriate Consult Place
-- Child Guardian Attachment
 -- Child Second Guardian Attachment  
 -- Appropriate Permanency For Child For Not Being Returned Home      
  -- Appropriate Permanency For Child For Being Adopted
 SELECT ( CASE WHEN (gdis.isconsultationchildage = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
( CASE WHEN (gdis.isguardianattach = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
( CASE WHEN (gdis.isguardiantwoattach = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
( CASE WHEN (gdis.isreunificationremoved = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
( CASE WHEN (gdis.isadoptionremoved = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END ),
( CASE WHEN (gdis.iscgprovidesafe = 'true')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                                 THEN 'YES'::VARCHAR ELSE 'NO'::VARCHAR END )																 
into vs_age_appr_cnslt_pl , vs_chd_grd_attch, vs_chd_sec_grd_attch, vs_reunfn_rmvd, vs_adp_rmvd, vs_iscgprovidesafe
         FROM gapdisclosure gdis                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
 WHERE gdis.gapid = vs_gap_id AND gdis.activeflag = 1 LIMIT 1;       

 
 select (case when count(*) = 6 then 'YES' else 'NO' end) into vs_lst_6_mnth_pymnt_stus  from tb_payment_detail tpd join placement p on  p.alternateid = tpd.placement_id and p.activeflag = 1
 where tpd.placement_id is not null and left(tpd.final_fiscal_category_cd, 2) = '21' and p.altproviderid = vn_grd_id and tpd.final_service_start_dt <= vd_grd_appl_dt::Date and tpd.final_service_start_dt > (vd_grd_appl_dt::date- interval '6 months')  and tpd.client_id = al_client_id;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
-- Sibling information  
     SELECT json_agg(json_build_object(                                                                                                                     
         'toclientid', isi.toclientid ,                                                                                                       
         'siblinggapeligibility', isi.siblinggapeligibility,                                                                                                    
         'siblingguardianid', isi.siblingguardianid,                                                                                            
         'ivesiblinginfoid', isi.ivesiblinginfoid, 
         'siblingclientname', isi.siblingclientname,
         'siblingclientid', isi.siblingclientid,
         'siblingguardianname', isi.siblingguardianname
 ))                                                                                                                                                     
     INTO  vn_ive_sibling_info    
	FROM 
		ivesiblinginfo isi
	WHERE isi.toclientid ::BIGINT = al_client_id AND isi.activeflag = 1;

-- Guardian Finalization Date  
-- guardianshipagreementsigneddate // valid for childpermanencyplankey in ('GBN','PRC')
SELECT ( CASE WHEN (isrco.childpermanencyplankey IN ('GBN','PRC')) 
				THEN isrco.courtorderdate ELSE NULL END )
	INTO vd_grd_fnl_crt_ord_dt
  	FROM intakeservreqcourtorder isrco 
  	join intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid and isrho.activeflag = 1 and isrho.hearingoutcometypekey = 'CUSGUA'
	join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person p on p.personid = isra.personid 
WHERE isrco.activeflag = 1 and p.cjamspid = al_client_id
ORDER BY isrco.insertedon DESC LIMIT 1;

select c.countyname INTO vs_jrsdctn 
       from caseassignment ca 
	   join servicecase sc on ca.objectid = sc.servicecaseid 
	   join intakeservreqchildremoval isrcr on isrcr.servicecaseid = sc.servicecaseid  
	   join intakeservicerequestactor isra on isra.intakeservicerequestactorid = isrcr.intakeservicerequestactorid
	   join person p on p.personid = isra.personid 
	   join county c on c.countyid = ca.toldssid and c.activeflag =1
	   where p.cjamspid::bigint = al_client_id and lower(ca.responsibilitytypekey) = 'family' order by ca.insertedon desc
	   limit 1;
	
END IF;

INSERT INTO Temp_worksheet_demographics_info
SELECT 
		al_client_id,
		al_removal_id,
		al_gap_subsidy_id,
		vs_chld_nm,
		vd_birth_dt,
		vs_gender,
		vd_person_id,
		vn_grd_id,
		vs_grd_one_nm,
		vn_grd_two_id,
		vs_grd_two_nm,
		vd_grd_agmt_dt,
		vd_sec_grd_agmt_dt,
		vd_grd_fnl_crt_ord_dt,
        vn_ive_sibling_info,
		vs_srv_req_no,
		vs_jrsdctn,
		vd_crtd_dt,
		vn_srv_req_id,
		vd_grd_appl_dt,
		vs_pri_is_rltv,
		vn_pri_rltn_id,
		vs_pri_rltn,
		vs_sec_is_rltv,
		vn_sec_rltn_id,
		vs_sec_rltn,
		vd_haapprovaldtjson,
		vd_ltst_fc_plcmt_st_dt_with_grd,
		vs_fstr_hm_aprvr,
		vs_scnd_grd_exts,
		vs_suc_grd_exts,
		vs_succ_grdn_nm,
		vn_succ_grdn_id,
		vd_succ_adndm_dt,
		vd_yesindicatetypeofremoval,
		vd_nochildisnoteligibleforgap,
		vd_child_rmvl_crt_ord_dt,
		vd_child_rmvl_vpa_dt,
		vd_child_vpa_flag,
		vd_child_crt_ord_flag,
		vs_age_appr_cnslt_pl,
		vs_chd_grd_attch,
		vs_chd_sec_grd_attch,
		vs_reunfn_rmvd,
		vs_adp_rmvd,
		vs_iscgprovidesafe,
		vs_sec_grd_lvng_with_pri_grd,
		(case when vs_lst_6_mnth_pymnt_stus is null then 'NO' else vs_lst_6_mnth_pymnt_stus end),
		vd_providerapprovalid,
		vd_isasiblingofachildgappayments,
		vd_isnotasiblingofachildgappayments,
		vd_siblinginformationgrid;		
   	
RETURN QUERY SELECT *
               FROM Temp_worksheet_demographics_info;
              
DROP TABLE Temp_worksheet_demographics_info;

   END
    $function$;
	