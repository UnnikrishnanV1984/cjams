DROP FUNCTION IF EXISTS cjams.getplacementbyperson(uuid);

DROP FUNCTION IF EXISTS cjams.getplacementbyperson(uuid, character varying);


CREATE OR REPLACE FUNCTION cjams.getplacementbyperson(v_personid uuid,  v_cjamspid  character varying DEFAULT NULL)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- CIDM- 4643 To Get service_id cfe user story
-- CIDM 5441 -to get placement structure ,
-- CIDM-5311 - to get cpahomedetails
-- CIDM-5778 - issue to fix the livingarrangementtype displaying as blank
-- 05/23/2023 Vineet Tirodkar - To fix the Provider Address display issue (CIDM-7004)
-- 12/11/2025 Umasankar Raavi - person search changes (CIDM-10748)
------------------------------------------------------------------------------------------------------------
DECLARE
jsondata json;
BEGIN
    IF v_personid IS NULL AND v_cjamspid IS NOT NULL THEN
        SELECT p.personid
          INTO v_personid
        FROM cjams.person p
        WHERE p.cjamspid =  v_cjamspid::bigint
        LIMIT 1;
    END IF;

    IF v_personid IS NULL THEN
        RETURN '[]'::json;
    END IF;
		
	SELECT JSON_AGG(pla) INTO jsondata FROM (
	SELECT PL.placementid, 
	PL.placementtypekey, PL.isvoided,PL.service_id, rv.value_text livingarrangementtype, LA.livingarrangementtypekey , 
	-- LA.streettext AS address1, 
	-- (LA.streetname || ' ' || LA.streetsuffixtypekey) AS address2 , 
	LA.streetname AS address1,
    LA.streettext AS address2,
	LA.cityname, 
	LA.countytypekey, 
	LA.statetypekey,
	(SELECT s.statename FROM cjams."state" s WHERE s.activeflag =1 AND s.stateabbr::character varying = LA.statetypekey) as statename,	
	LA.zip5no AS zipcode, 
	PL.startdatetime AS startdate, PL.starttime, PL.enddatetime AS enddate, PL.endtime, COALESCE(PL.primaryrelationship,LA.primaryrelationship) as primaryrelationship,
	(CASE
		WHEN PL.servicecaseid IS NOT NULL 
			THEN (SELECT servicecasenumber FROM cjams.servicecase WHERE servicecaseid = PL.servicecaseid)
		ELSE 
			NULL 
		END
	) AS servicecasenumber,
	CASE WHEN (SELECT prv.placementid FROM placementrevision prv
		
		WHERE prv.placementid=pl.placementid AND prv.approvalstatustypkey='3281' AND prv.activeflag=1  ) is not null
		then 'Approved' ELSE 
		(SELECT rs.typedescription FROM routing r
			INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
			INNER JOIN teammemberroletype tmr ON tmr.roletypekey = r.FROMroleid  AND tmr.activeflag =1 
			INNER JOIN teammemberroletype tmrt ON tmrt.roletypekey = r.toroleid  AND tmrt.activeflag =1 
				AND tmrt.teamtypekey=tmr.teamtypekey
		WHERE r.eventcode = 'PLTR' AND r.objectid  =  PL.placementid :: CHARACTER VARYING
		AND r.routingstatustypeid NOT IN (69, 70) 
		AND r.activeflag =1 ORDER BY r.insertedON DESC limit 1) 
		END AS  routingstatus,
	(
						SELECT row_to_json(x) FROM 
						(
							SELECT 
								p.provider_id ,
								CASE COALESCE(provider_nm,'') WHEN '' THEN COALESCE(provider_first_nm ,'') ||' '|| COALESCE(provider_last_nm,'')
									 ELSE provider_nm  
								END providername, 
										(CAST(INITCAP(TRIM(coalesce(TBPA1.adr_street_tx,''))||
									 ' '||TRIM(coalesce(TBPA1.adr_street_nm,''))||
									 ' '||TRIM(coalesce(TBPA1.adr_street_suffix_cd,''))||
									 ' '||TRIM(coalesce(TBPA1.adr_unit_type_cd,''))||
									 ' '||TRIM(coalesce(TBPA1.adr_unit_no_tx,''))||
									 ' '||TRIM(coalesce(TBPA1.adr_city_nm,'')) ||
									 ' '||TRIM(coalesce(TBPA1.adr_state_cd,'')) ||
									 ' '||TRIM((coalesce(TBPA1.adr_zip5_no,0::numeric))::character varying)) AS character varying)) AS address 
							FROM tb_provider AS p
								INNER JOIN tb_provider_addresses TBPA1  ON TBPA1.parent_key_id = p.provider_id::CHARACTER VARYING  
								AND TBPA1.delete_sw = 'N' 
								WHERE p.provider_id = PL.altproviderid AND p.delete_sw = 'N' 
								-- AND TBPA1.adr_end_dt IS NULL 
								AND TBPA1.adr_default_sw='Y' 
								AND TBPA1.adr_type_cd='3357'
							LIMIT 1
						) AS x
					) providerdetails,
					(SELECT row_to_json(x) FROM 
		(
				
		select pr.provider_id as caphome_id ,
			(case COALESCE(pr.provider_nm,'') when '' then
				COALESCE(pr.provider_first_nm ,'') ||' '|| COALESCE(pr.provider_last_nm,'')
			ELSE 
				pr.provider_nm  
			end) cpahomename, 
					(CAST(INITCAP(TRIM(coalesce(pa.adr_street_tx,''))||
				 ' '||TRIM(coalesce(pa.adr_street_nm,''))||
				 ' '||TRIM(coalesce(pa.adr_street_suffix_cd,''))||
				 ' '||TRIM(coalesce(pa.adr_unit_type_cd,''))||
				 ' '||TRIM(coalesce(pa.adr_unit_no_tx,''))||
				 ' '||TRIM(coalesce(pa.adr_city_nm,'')) ||
				 ' '||TRIM(coalesce(pa.adr_state_cd,'')) ||
				 ' '||TRIM((coalesce(pa.adr_zip5_no,0::numeric))::character varying)) AS character varying)
				) AS cpahomeaddress 
		from placementcpahomes as cpa
			join tb_provider as pr on pr.provider_id = cpa.altproviderid 
				and pr.delete_sw = 'N'
			join tb_provider_addresses pa on pa.parent_key_id = pr.provider_id::character varying 
				and pa.adr_default_sw = 'Y' 
				and pa.adr_type_cd = '3357'
		where cpa.placementid = PL.placementid
			and cpa.activeflag  = 1
		order by cpa.entrydt desc
		limit 1		
		) AS x
	) cpahomedetails,
	(select JSON_AGG(x) FROM (SELECT plr.entrydate, plr.exitdate, plr.isvoided
	,p.alternateid AS placement_id,tp.provider_id,
	CASE COALESCE(tp.provider_nm,'') WHEN '' THEN COALESCE(tp.provider_first_nm ,'') ||' '|| COALESCE(tp.provider_last_nm,'')
									 ELSE tp.provider_nm  
								END providername
							,up1.fullname AS requestedby , up2.fullname AS approvedby , plr.requesteddate ,plr.approveddate
	FROM placementrevisiON plr 
	JOIN placement p ON p.placementid = plr.placementid 
	left JOIN tb_provider tp ON  tp.provider_id = PL.altproviderid AND tp.delete_sw = 'N' 
	left JOIN userprofile up1 ON plr.requestedby:: CHARACTER VARYING = up1.securityusersid
	left JOIN userprofile up2 ON plr.approvedby:: CHARACTER VARYING  = up2.securityusersid
	left JOIN userprofile up ON up.securityusersid = plr.insertedby 
	WHERE plr.placementid = PL.placementid AND Plr.approvalstatustypkey = '3045' AND plr.activeflag = 0 ORDER BY plr.insertedON DESC) AS x) AS placementrevision,
	ts.service_nm,LA.primarycaregiver
	
	FROM 	placement PL
			LEFT JOIN livingarrangement LA ON PL.personid = LA.personid AND LA.activeflag=1 AND PL.placementid = LA.placementid
			LEFT JOIN referencevalues rv ON rv.ref_key = LA.livingarrangementtypekey AND rv.referencetypeid=76  --AND rv.activeflag=1
			LEFT JOIN prov.tb_services ts on ts.service_id  = PL.service_id 
			WHERE 	PL.personid = v_personid  AND PL.activeflag = 1
			order by PL.startdatetime desc) AS pla;
	RETURN jsondata;
END;
$function$
;

