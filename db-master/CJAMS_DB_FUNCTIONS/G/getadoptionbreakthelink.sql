DROP FUNCTION IF EXISTS  cjams.getadoptionbreakthelink(v_adoptionplanningid uuid);
CREATE OR REPLACE FUNCTION cjams.getadoptionbreakthelink(v_adoptionplanningid uuid)
 RETURNS json
 LANGUAGE plpgsql
AS $function$


DECLARE 
l_adoptionbreakthelink json;
l_count bigint;
l_clientpersonid uuid;

BEGIN

SELECT COUNT(1) INTO l_count
FROM adoptionbreakthelink 
WHERE adoptionplanningid = v_adoptionplanningid LIMIT 1;

SELECT isa.personid INTO l_clientpersonid FROM adoptionplanning adp 
INNER JOIN intakeservicerequestactor isa ON isa.intakeservicerequestactorid = adp.intakeservicerequestactorid 
WHERE adp.adoptionplanningid = v_adoptionplanningid;

IF COALESCE(l_count,0) =0 THEN
	SELECT json_agg(adoptionbreakthelink) INTO l_adoptionbreakthelink 
	FROM 
	(
		SELECT
			ap.adoptionplanningid,ap.adoptiondate AS adoptionplanbegindate,tbp.startdatetime AS PlacementStartDate,tbp.enddatetime AS PlacementEndDate,
			(tbpr.provider_first_nm)||' '||TRIM(tbpr.provider_last_nm) AS ProviderName,tbs.service_nm AS PlacementStructure,
			(
				SELECT 
					rs.typedescription AS Narrativecheckliststatus 
				FROM routing r  
				INNER JOIN routingstatustype rs ON r.routingstatustypeid = rs.sequencenumber AND rs.activeflag =1
				WHERE r.objectid = v_adoptionplanningid::character varying AND r.eventcode = 'ADPR' AND r.activeflag =1 order by r.insertedon desc LIMIT 1
			),
			(
				SELECT
					icr.courtorderdate AS tprfatherdate
				FROM Intakeservicerequestpetition irsp
				INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
				INNER JOIN actorrelationship ar ON ispa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag =1 AND ar.relationshiptypekey IN ('father')       
				INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid AND icr.activeflag =1
				WHERE irsp.intakeservicerequestid = ap.intakeserviceid AND irsp.activeflag =1 AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid
				AND ispa.petitionactortype = 'CA' LIMIT 1
			),
			(
				SELECT
					icr.courtorderdate AS tprmotherdate
				FROM Intakeservicerequestpetition irsp
				INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
				INNER JOIN actorrelationship ar ON ispa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag =1 AND ar.relationshiptypekey IN ('mother')       
				INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid AND icr.activeflag =1
				WHERE irsp.intakeservicerequestid = ap.intakeserviceid AND irsp.activeflag =1 AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid
				AND ispa.petitionactortype = 'CA' LIMIT 1
			), 
			(
				SELECT
					tpr.decisiondate decisiondate  
				FROM tprdetails tpr 
				WHERE tpr.activeflag =1 AND tpr.intakeserviceid = ap.intakeserviceid AND tpr.intakeservicerequestactorid = ap.intakeservicerequestactorid AND tpr.isappealed  =1
				LIMIT 1
			),
			 ( SELECT json_agg(v) 
			   FROM (
				select startdatetime, enddatetime, (case when approvalstatustypekey = '3047' then 'Approved' else 'Pending' end) as approvalstatus,
					service_id as placementstructureid, (select case when length(provider_nm) > 0 then provider_nm else concat(provider_first_nm, ' ', provider_last_nm) end  from tb_provider where provider_id = altproviderid) as providername
					from placement where personid = tbp.personid and service_id = 500 and 
					(select count(1) > 0 from routing where objectid = placementid::varchar and eventcode = 'PLTR' and routingstatustypeid = 16 and activeflag = 1)
					order by insertedon desc limit 1
					) v	
			 ) as providerdetails,
		    (
			select json_agg(tp.tprdecisiondate)  from tprdetails tp  			
			INNER JOIN tprrecommendation tpr ON tpr.tprrecommendationid = tp.tprrecommendationid
				and 
				 case when coalesce(l_clientpersonid ::character varying , '') <> '' 
				 	then
					 	tpr.intakeservicerequestactorid in 
							(select i.intakeservicerequestactorid from intakeservicerequestactor i 
							where i.personid = l_clientpersonid)
				 	else 1 = 1 
				 end
			inner join adoptionplanning ap on 
			CASE WHEN ap.intakeserviceid IS NOT NULL THEN tp.intakeserviceid = ap.intakeserviceid ELSE TRUE END  
			AND CASE WHEN ap.servicecaseid IS NOT NULL THEN tp.servicecaseid = ap.servicecaseid ELSE TRUE END  
			and ap.adoptionplanningid = v_adoptionplanningid 
			)as tprdates,
			(select ac.adoptioncaseid from adoptioncase ac where ac.adoptionplanningid=v_adoptionplanningid and ac.activeflag=1 limit 1),
				(select ac.adoptioncasenumber from adoptioncase ac where ac.adoptionplanningid=v_adoptionplanningid and ac.activeflag=1 limit 1),
			(select isofferedsubsidy from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1),
		(select offeraccepteddate from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1),
		(
			-- SELECT
			-- 	isrch.hearingdatetime AS finalizationdate
			-- FROM Intakeservicerequestpetition irsp
			-- INNER JOIN intakeservicerequestcourthearing isrch on irsp.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid and isrch.hearingstatustypekey = 'CONCULD' and isrch.hearingtype ? 'ADP'
			-- INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
			-- INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid AND icr.activeflag =1
			-- INNER JOIN intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = icr.intakeservreqcourtorderid and isrho.hearingoutcometypekey = 'ADOGRA' and isrho.activeflag = 1
			-- WHERE irsp.activeflag =1 AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid AND 
			-- (irsp.intakeservicerequestid = ap.intakeserviceid or irsp.servicecaseid = ap.servicecaseid ) LIMIT 1

			select isrch.hearingdatetime AS finalizationdate
			FROM Intakeservicerequestpetition irsp
			JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid
				and irsp.activeflag =1
			join intakeservicerequestactor intk on intk.intakeservicerequestactorid = ispa.intakeservicerequestactorid
				and intk.activeflag =1
			JOIN intakeservicerequestcourthearing isrch on irsp.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid
				and isrch.hearingstatustypekey = 'CONCULD'
				and isrch.hearingtype ? 'ADP'
			JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid
				AND icr.activeflag =1
			JOIN intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = icr.intakeservreqcourtorderid
				and isrho.hearingoutcometypekey = 'ADOGRA'
				and isrho.activeflag = 1
			WHERE irsp.activeflag =1
			  	AND intk.personid = l_clientpersonid
				AND (irsp.intakeservicerequestid = null or irsp.servicecaseid = ap.servicecaseid )
			LIMIT 1
		),
		(select parent1signdate from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1)
		FROM adoptionplanning ap
		INNER JOIN permanencyplan pp ON pp.permanencyplanid=ap.permanencyplanid AND pp.activeflag=1
		LEFT JOIN placement tbp ON 
			CASE WHEN pp.placementid IS NULL THEN tbp.placementid in (
			SELECT tempp.placementid FROM adoptionplanning ap1
			INNER JOIN permanencyplan pp1 ON pp1.permanencyplanid=ap1.permanencyplanid AND pp1.activeflag=1
			INNER JOIN placement tempp ON tempp.intakeservicerequestactorid = pp1.intakeservicerequestactorid AND (
			tempp.intakeserviceid = pp1.intakeserviceid OR tempp.servicecaseid = pp1.servicecaseid) AND tempp.activeflag = 1
			where ap1.adoptionplanningid = v_adoptionplanningid order by tempp.insertedon desc limit 1)
			ELSE tbp.placementid = pp.placementid 
			END
			AND tbp.activeflag =1	
		LEFT JOIN tb_provider tbpr ON tbpr.provider_id = tbp.altproviderid AND tbpr.delete_sw ='N'
		LEFT JOIN tb_services tbs ON tbs.service_id = tbp.service_id AND tbs.delete_sw = 'N'
		WHERE ap.adoptionplanningid = v_adoptionplanningid) AS adoptionbreakthelink;

ELSE

	SELECT json_agg(adoptionbreakthelink) INTO l_adoptionbreakthelink FROM
	(
		SELECT 
			abl.adoptionbreakthelinkid,abl.legallyfree,abl.adoptiveplacement,abl.placementagreement,
			abl.agreementsigneddate,abl.adoptionfinalization ,abl.associatedcourtorderdate,abl.finalizationdate,
			ap.adoptionplanningid,ap.adoptiondate AS adoptionplanbegindate,tbp.startdatetime AS PlacementStartDate,tbp.enddatetime AS PlacementEndDate,
			(tbpr.provider_first_nm)||' '||TRIM(tbpr.provider_last_nm) AS ProviderName,
			tbs.service_nm AS PlacementStructure,
			(
				SELECT 
					rs.typedescription AS Narrativecheckliststatus 
				FROM routing r  
				INNER JOIN routingstatustype rs ON r.routingstatustypeid = rs.sequencenumber AND rs.activeflag =1
				WHERE r.objectid = adcl.adoptionplanningid::character varying AND r.eventcode = 'ADPR' AND r.activeflag =1  order by r.insertedon desc LIMIT 1
			),
			(
				SELECT 
					rs.typedescription AS status 
				FROM routing r  
				INNER JOIN routingstatustype rs ON r.routingstatustypeid = rs.sequencenumber AND rs.activeflag =1
				WHERE r.objectid = abl.adoptionbreakthelinkid::character varying AND r.eventcode = 'ABLR' AND r.activeflag =1 order by r.insertedon desc LIMIT 1
			),
			(
				SELECT
					icr.courtorderdate AS tprfatherdate
				FROM Intakeservicerequestpetition irsp
				INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
				INNER JOIN actorrelationship ar ON  ispa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag =1 AND ar.relationshiptypekey IN ('father')       
				INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid 
					AND icr.activeflag =1
				WHERE irsp.intakeservicerequestid = ap.intakeserviceid AND irsp.activeflag=1 
					AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid AND ispa.petitionactortype = 'CA' LIMIT 1
			),
			(
				SELECT
					icr.courtorderdate AS tprmotherdate
				FROM Intakeservicerequestpetition irsp
				INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
				INNER JOIN actorrelationship ar ON ispa.intakeservicerequestactorid = ar.intakeservicerequestactorid AND ar.activeflag =1 AND ar.relationshiptypekey IN ('mother')       
				INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid AND icr.activeflag =1
				WHERE irsp.intakeservicerequestid = ap.intakeserviceid AND irsp.activeflag =1 
					AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid AND ispa.petitionactortype = 'CA'
				LIMIT 1
				
			), 
			(
				SELECT
					tpr.decisiondate decisiondate  
				FROM tprdetails tpr 
				WHERE tpr.activeflag =1 AND tpr.intakeserviceid = ap.intakeserviceid AND tpr.intakeservicerequestactorid = ap.intakeservicerequestactorid 
					AND tpr.isappealed =1
				LIMIT 1
			),
 		 (	SELECT 	json_agg(v.tprdecisiondate)  
		  	FROM (SELECT DISTINCT tpr.tprdecisiondate, tpr.intakeservicerequestactorid
				  FROM 	tprdetails tpr
				  		INNER JOIN tprrecommendation tr ON tpr.tprrecommendationid = tr.tprrecommendationid
						INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = tr.intakeservicerequestactorid 
						AND isra.personid = l_clientpersonid 
						INNER JOIN adoptionplanning app ON 
						(tpr.servicecaseid = app.servicecaseid AND app.adoptionplanningid = v_adoptionplanningid)
						OR 																								-- HANDLING MIGRATED CASES --
						tpr.servicecaseid = 																			-- HANDLING MIGRATED CASES --
						(SELECT biologicalcaseid																		-- HANDLING MIGRATED CASES --
						 FROM   biologicaladoptionlink bio WHERE preadoptivecaseid = v_adoptionplanningid)				-- HANDLING MIGRATED CASES --
				) v	
			) as  tprdates,
		 ( SELECT json_agg(v) 
		   FROM (
			select startdatetime, enddatetime, (case when approvalstatustypekey = '3047' then 'Approved' else 'Pending' end) as approvalstatus,
				service_id as placementstructureid, (select case when length(provider_nm) > 0 then provider_nm else concat(provider_first_nm, ' ', provider_last_nm) end  from tb_provider where provider_id = altproviderid) as providername
				from placement where personid = l_clientpersonid and service_id = 500 and 
				(select count(1) > 0 from routing where objectid = placementid::varchar and eventcode = 'PLTR' and routingstatustypeid = 16 and activeflag = 1)
				order by insertedon desc limit 1
				) v	
		 ) as providerdetails,
		(select ac.adoptioncaseid from adoptioncase ac where ac.adoptionplanningid=v_adoptionplanningid and ac.activeflag=1 limit 1),
		(select ac.adoptioncasenumber from adoptioncase ac where ac.adoptionplanningid=v_adoptionplanningid and ac.activeflag=1 limit 1),
		(select isofferedsubsidy from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1),
		COALESCE((select offeraccepteddate from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1), abl.agreementsigneddate) offeraccepteddate,	-- HANDLING MIGRATED CASES --
		( 
					-- SELECT isrch.hearingdatetime AS finalizationdate FROM Intakeservicerequestpetition irsp
					-- INNER JOIN intakeservicerequestcourthearing isrch on irsp.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid and isrch.hearingstatustypekey = 'CONCULD' and isrch.hearingtype ? 'ADP'
					-- INNER JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid and irsp.activeflag =1 AND ispa.activeflag =1
					-- INNER JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid AND icr.activeflag =1
					-- INNER JOIN intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = icr.intakeservreqcourtorderid and isrho.hearingoutcometypekey = 'ADOGRA' and isrho.activeflag = 1
					-- WHERE irsp.activeflag =1 AND ispa.intakeservicerequestactorid=ap.intakeservicerequestactorid 
					-- AND (irsp.intakeservicerequestid = ap.intakeserviceid or irsp.servicecaseid = ap.servicecaseid ) LIMIT 1

					select 
				    case when (exists(select ac.adoptioncasenumber from adoptioncase ac
				    where ac.adoptionplanningid=v_adoptionplanningid))
				    then abl.finalizationdate else 
				    (select isrch.hearingdatetime AS finalizationdate
			FROM Intakeservicerequestpetition irsp
			JOIN Intakeservicerequestpetitionactor ispa ON irsp.Intakeservicerequestpetitionid = ispa.Intakeservicerequestpetitionid
				and irsp.activeflag =1
			join intakeservicerequestactor intk on intk.intakeservicerequestactorid = ispa.intakeservicerequestactorid
				and intk.activeflag =1
			JOIN intakeservicerequestcourthearing isrch on irsp.intakeservicerequestpetitionid = isrch.intakeservicerequestpetitionid
				and isrch.hearingstatustypekey = 'CONCULD'
				and isrch.hearingtype ? 'ADP'
			JOIN Intakeservreqcourtorder icr ON icr.Intakeservicerequestpetitionid = irsp.Intakeservicerequestpetitionid
				AND icr.activeflag =1
			JOIN intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = icr.intakeservreqcourtorderid
				and isrho.hearingoutcometypekey = 'ADOGRA'
				and isrho.activeflag = 1
			WHERE irsp.activeflag =1
			  	AND intk.personid = l_clientpersonid
				AND (irsp.intakeservicerequestid = null or irsp.servicecaseid = ap.servicecaseid )
			LIMIT 1) end  as finalizationdate) , -- HANDLING MIGRATED CASES --
		COALESCE((select parent1signdate from adoptionagreement where adoptionplanningid = v_adoptionplanningid LIMIT 1), abl.agreementsigneddate) parent1signdate 		-- HANDLING MIGRATED CASES --
		FROM adoptionbreakthelink abl 
			INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = abl.adoptionplanningid AND ap.activeflag =1 AND abl.activeflag =1
			INNER JOIN adoptionchecklist adcl ON adcl.adoptionplanningid = ap.adoptionplanningid AND adcl.activeflag =1
			INNER JOIN permanencyplan pp ON pp.permanencyplanid=ap.permanencyplanid AND pp.activeflag=1
			LEFT JOIN placement tbp ON tbp.placementid=pp.placementid AND tbp.activeflag =1		
			LEFT JOIN tb_provider tbpr ON tbpr.provider_id = tbp.altproviderid AND tbpr.delete_sw ='N'
			LEFT JOIN tb_services tbs ON tbs.service_id = tbp.service_id AND tbs.delete_sw = 'N'
		WHERE abl.adoptionplanningid = v_adoptionplanningid
	) AS adoptionbreakthelink;
END IF;
RETURN l_adoptionbreakthelink; 
     
END;
$function$
;
