CREATE OR REPLACE FUNCTION cjams.getpermanencyplacement(v_permanencyplanid character varying, v_transkey character varying, v_transid character varying)
 RETURNS TABLE(permanencyplanid character varying, adoptionplanningid character varying, tprrecommendationid character varying, adoptionagreementid character varying, placements json)
 LANGUAGE plpgsql
AS $function$

BEGIN
	
IF (v_transkey='breakthelink') THEN
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			adb.adoptionplanningid:: character varying,
			'' :: character varying,
			'':: character varying,
			null:: json  
		FROM adoptionbreakthelink  adb 
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = adb.adoptionplanningid AND ap.activeflag = 1
		WHERE adb.adoptionbreakthelinkid:: character varying =v_transid;
ELSIF (v_transkey='planning') THEN	 
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			ap.adoptionplanningid:: character varying,
			'':: character varying,
			'' :: character varying,
			null:: json
		FROM adoptionplanning ap 
		WHERE ap.adoptionplanningid:: character varying =v_transid AND ap.activeflag = 1;
ELSIF (v_transkey='subsidy') THEN	 
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			ap.adoptionplanningid:: character varying,
			'':: character varying,
			'':: character varying,
			null:: json 
		FROM adoptionagreementrevision ag  
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = ag.adoptionplanningid AND ap.activeflag = 1
		WHERE ag.adoptionagreementid:: character varying =v_transid AND ag.activeflag = 1;
ELSIF (v_transkey='agreementrate') THEN
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			ap.adoptionplanningid:: character varying,
			'':: character varying,
			ag.adoptionagreementid:: character varying,
			null:: json  
		FROM adoptionagreementraterevision  agr
		INNER JOIN adoptionagreement ag ON ag.adoptionagreementid = agr.adoptionagreementid AND ag.activeflag = 1
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = ag.adoptionplanningid AND ap.activeflag = 1
		WHERE agr.adoptionagreementrateid:: character varying =v_transid;
ELSIF (v_transkey='adoptionsubsidy') THEN	 
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			ap.adoptionplanningid:: character varying,
			'':: character varying,
			'':: character varying,
			null:: json 
		FROM adoptioncaseagreementrevision ag  
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = ag.adoptionplanningid AND ap.activeflag = 1
		WHERE ag.adoptionagreementid:: character varying =v_transid AND ag.activeflag = 1;
ELSIF (v_transkey='adoptionagreementrate') THEN
	RETURN QUERY
		SELECT
			ap.permanencyplanid:: character varying,
			ap.adoptionplanningid:: character varying,
			'':: character varying,
			ag.adoptionagreementid:: character varying,
			null:: json  
		FROM adoptioncaserevision  agr
		INNER JOIN adoptioncaseagreement ag ON ag.adoptionagreementid = agr.adoptionagreementid AND ag.activeflag = 1
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = ag.adoptionplanningid AND ap.activeflag = 1
		WHERE agr.adoptionagreementrateid:: character varying =v_transid;		
ELSIF (v_transkey='suspension') THEN	 
	RETURN QUERY
		SELECT
			ap.permanencyplanid :: character varying
			,asr.adoptionplanningid:: character varying
			,'' :: character varying
			,asr.adoptionagreementid :: character varying,null:: json
		FROM adoptionsuspension asr 
		INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = asr.adoptionplanningid AND ap.activeflag = 1
		WHERE asr.adoptionsuspensionid:: character varying =v_transid AND asr.activeflag = 1;
ELSE
	RETURN QUERY
		SELECT 
        	adp.permanencyplanid :: character varying,
			adp.adoptionplanningid :: character varying,
			tpr.tprrecommendationid :: character varying,
			adp.adoptionagreementid :: character varying,
			(
				SELECT json_agg(e) FROM 
				(
				SELECT 	PL.servicecaseid,PL.intakeservreqchildremovalid,PL.intakeservicerequestactorid,
						PL.providerid,PL.remarks,PL.service_id,PL.ratestructureid,PL.startdatetime as startdate,
						PL.starttime,PL.enddatetime as enddate,PL.endtime,PL.placementtypekey,PL.providersentdate,
						PL.providerdesc,PL.responseacceptedkey,PL.rejectreasonkey,PL.isssaapproval,PL.ifcapprovaldate,
						PL.placementid,LA.livingarrangementtypekey,rv.value_text livingarrangementtype,p.personid,LA.livingfirstname,LA.livingstartdate,
						LA.livingenddate,LA.homephone AS contactphone,LA.streetname AS address1 ,LA.streettext AS address2 ,
						LA.cityname,LA.countytypekey,LA.statetypekey,LA.zip5no as zipcode,PL.isvoided,PL.exittypekey,PL.voiddate,																	
						(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.exittypekey LIMIT 1) exitreasontypedescription,																	
						PL.exitreasontypekey,
					   (SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.exitreasontypekey LIMIT 1) exittypedescription,																
						PL.voidreasontypekey, 
						(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.voidreasontypekey LIMIT 1) voidreasontypedescription,																	
						PL.voidremarks, 																
						(SELECT countyname FROM county c WHERE c.activeflag =1 AND c.countyid::character varying = LA.countytypekey)
						county ,
						(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.rejectreasonkey LIMIT 1) rejectreason,
						(SELECT value_text FROM referencevalues r WHERE r.activeflag =1 AND r.ref_key::character varying = PL.responseacceptedkey LIMIT 1) responseaccepted,
						(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = PL.service_id AND tb_Services.delete_sw ='N' LIMIT 1) placementstructuredesc,
						(SELECT service_nm FROM tb_Services WHERE tb_Services.service_id = PL.ratestructureid AND tb_Services.delete_sw ='N' LIMIT 1) comarratedesc,
						(SELECT statename FROM state s WHERE s.activeflag =1 AND s.stateabbr::character varying = LA.statetypekey)
						statename ,
						(
							SELECT row_to_json(x) FROM 
							(
								SELECT 
									p.provider_id ,p.adr_work_phone_tx AS phonenumber,
									CASE COALESCE(provider_nm,'') WHEN '' THEN COALESCE(provider_first_nm ,'') ||' '|| COALESCE(provider_last_nm,'')
										 ELSE provider_nm  
									END providername, 
											(CAST(INITCAP(TRIM(TBPA1.adr_street_tx)||' '||TRIM(TBPA1.adr_street_nm)||' '||TRIM(TBPA1.adr_city_nm) ||' '||TRIM(TBPA1.adr_state_cd) ||' '||
											TRIM(TBPA1.adr_zip5_no::character varying)) AS character varying)) AS address 
								FROM tb_provider as p
									INNER JOIN tb_provider_addresses TBPA1  ON TBPA1.parent_key_id = p.provider_id::character varying  AND TBPA1.delete_sw = 'N' 
									WHERE p.provider_id = PL.altproviderid AND p.delete_sw = 'N' LIMIT 1
							) as x
						) providerdetails, 
						(SELECT rs.typedescription from routing r
						INNER JOIN routingstatustype  rs ON r.routingstatustypeid = rs.sequencenumber
						WHERE r.eventcode = 'PLTR' AND r.objectid  =  PL.placementid :: character varying 
						AND r.activeflag =1 limit 1 ) routingstatus
					FROM placement PL
					INNER JOIN person p ON PL.personid=p.personid AND p.activeflag=1
					INNER JOIN intakeservicerequestactor ira ON ira.personid = p.personid
					LEFT JOIN livingarrangement LA on LA.placementid = PL.placementid and LA.activeflag = 1 
					LEFT JOIN referencevalues rv ON rv.ref_key = LA.livingarrangementtypekey AND rv.referencetypeid=76 AND rv.activeflag=1
					WHERE ira.intakeservicerequestactorid = PP.intakeservicerequestactorid  AND  PL.activeflag = 1
				)  e
			) :: json AS  placements
		FROM
		permanencyplan pp 
		LEFT JOIN tprrecommendation tpr ON tpr.permanencyplanid=pp.permanencyplanid AND tpr.activeflag=1
		LEFT JOIN 
			(
				SELECT 
					ad.adoptionplanningid,ad.permanencyplanid,ag.adoptionagreementid
				FROM adoptionplanning ad
				LEFT JOIN adoptionagreement ag ON ag.adoptionplanningid=ad.adoptionplanningid AND ag.activeflag=1
				WHERE ad.activeflag=1 AND ad.permanencyplanid:: character varying=v_permanencyplanid
			) adp ON adp.permanencyplanid=pp.permanencyplanid 
		WHERE pp.permanencyplanid:: character varying = v_permanencyplanid;
	END IF;
END;

$function$
;
