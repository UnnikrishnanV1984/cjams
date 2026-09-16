DROP FUNCTION IF EXISTS cjams.gettprdetails(v_servicecaseid uuid);
DROP FUNCTION IF EXISTS cjams.gettprdetails(v_servicecaseid uuid, v_clientid character varying);
DROP FUNCTION IF EXISTS cjams.gettprdetails(v_servicecaseid uuid, v_clientid character varying, v_includeunknownparent varchar);
CREATE OR REPLACE FUNCTION cjams.gettprdetails(v_servicecaseid uuid, v_clientid character varying, v_includeunknownparent varchar default 'no')
 RETURNS TABLE(breaklinkstatus character varying,tprdetailsid uuid, tprrecommendationid uuid, intakeservicerequestactorid uuid, personid uuid, intakeservreqcourtorderid uuid, serveddate timestamp without time zone, servicetypekey character varying, servicetypedescription character varying, terminationtypekey character varying, isappealed integer, isdssappealed integer, appealdate timestamp without time zone, appealdecisiontypekey character varying, decisiondate timestamp without time zone, reason character varying, singleparent boolean, parentname character varying, actortype character varying, relationship character varying, isgranted boolean, isdenied boolean, tprdecisiondate timestamp without time zone, old_id character varying, relationshiptypekey character varying,tprpetitiondate timestamp without time zone,iscontested boolean,updatedon timestamp)
 LANGUAGE plpgsql
AS $function$     
----------------------------------------------------------------------------------------------------------
 --CDM-38256-Smitha Somasekharan - to get updatedon details
 --CIDM-11401 -Surya Arigela - Retrieving breaklinkstatus associated to particular service case
 ----------------------------------------------------------------------------------------------------------
BEGIN
	
	if(lower(v_includeunknownparent) = 'no') then
		RETURN QUERY 
		WITH childtpr AS(
			SELECT DISTINCT ira.personid
			FROM   permanencyplan pp
				   INNER JOIN intakeservicerequestactor ira ON ira.intakeservicerequestactorid = pp.intakeservicerequestactorid
			WHERE  pp.servicecaseid = v_servicecaseid 
		)
		SELECT  
				(
				    SELECT rs.typedescription
				    FROM cjams.adoptionplanning ap
				    INNER JOIN cjams.adoptionbreakthelink abl ON abl.adoptionplanningid = ap.adoptionplanningid AND abl.activeflag = 1
				    INNER JOIN cjams.routing r ON r.objectid = abl.adoptionbreakthelinkid::varchar AND r.eventcode = 'ABLR' AND r.activeflag = 1
				    INNER JOIN cjams.routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag = 1
				    WHERE ap.servicecaseid = v_servicecaseid
				      AND ap.activeflag = 1
				      AND ap.intakeservicerequestactorid = tpr.intakeservicerequestactorid
				    ORDER BY r.insertedon DESC
				    LIMIT 1
				)::character varying AS breaklinkstatus,
				td.tprdetailsid,td.tprrecommendationid,td.intakeservicerequestactorid, p.personid,td.intakeservreqcourtorderid,td.serveddate,td.servicetypekey,st.servicetypedescription,td.terminationtypekey,td.isappealed,
				td.isdssappealed,td.appealdate,td.appealdecisiontypekey,td.decisiondate,td.reason,
				td.singleparent,
				( p.firstname || ' '||p.lastname):: character varying parentname,at.actortype,at.typedescription,td.isgranted,td.isdenied,td.tprdecisiondate,td.old_id,td.relationshiptypekey,td.tprpetitiondate,td.iscontested,td.updatedon
		FROM 	tprdetails td
				INNER JOIN tprrecommendation tpr ON tpr.tprrecommendationid = td.tprrecommendationid
					and 
					 case when coalesce(v_clientid, '') <> '' 
					 	then
						 	tpr.intakeservicerequestactorid in 
								(select i.intakeservicerequestactorid from intakeservicerequestactor i 
								where i.personid = v_clientid::uuid)
					 	else 1 = 1 
					 end
				INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = td.intakeservicerequestactorid 
				INNER JOIN intakeservicerequestactor isra1 ON isra1.intakeservicerequestactorid = tpr.intakeservicerequestactorid 
				INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
				INNER JOIN childtpr cp ON cp.personid = isra1.personid
				LEFT JOIN servicetype st ON st.servicetypekey=td.servicetypekey AND st.activeflag=1
				LEFT JOIN actortype at on at.actortype = isra.intakeservicerequestpersontypekey
		WHERE (td.servicecaseid = v_servicecaseid 
			   OR td.servicecaseid = (SELECT 	biologicalcaseid
									FROM 	biologicaladoptionlink bio
											INNER JOIN adoptionplanning ap ON ap.adoptionplanningid = bio.preadoptivecaseid
									WHERE 	ap.servicecaseid = v_servicecaseid	
			   )) 
			   AND td.activeflag=1;
	else
		raise notice 'else part';
		return QUERY
			select 
				(
				    SELECT rs.typedescription
				    FROM cjams.adoptionplanning ap
				    INNER JOIN cjams.adoptionbreakthelink abl ON abl.adoptionplanningid = ap.adoptionplanningid AND abl.activeflag = 1
				    INNER JOIN cjams.routing r ON r.objectid = abl.adoptionbreakthelinkid::varchar AND r.eventcode = 'ABLR' AND r.activeflag = 1
				    INNER JOIN cjams.routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag = 1
				    WHERE ap.servicecaseid = v_servicecaseid
				      AND ap.activeflag = 1
				      AND ap.intakeservicerequestactorid = tpr.intakeservicerequestactorid
				    ORDER BY r.insertedon DESC
				    LIMIT 1
				)::character varying AS breaklinkstatus,
				td.tprdetailsid,td.tprrecommendationid,td.intakeservicerequestactorid, isa.personid, td.intakeservreqcourtorderid ,td.serveddate,td.servicetypekey,
				st.servicetypedescription,
				td.terminationtypekey,td.isappealed,td.isdssappealed,td.appealdate,td.appealdecisiontypekey,td.decisiondate,td.reason,td.singleparent,
				( p.firstname || ' '||p.lastname):: character varying parentname,at.actortype,at.typedescription,
				td.isgranted,td.isdenied,td.tprdecisiondate,td.old_id,td.relationshiptypekey,td.tprpetitiondate,td.iscontested,td.updatedon
			FROM 	tprdetails td
			left join tprrecommendation tpr on tpr.tprrecommendationid = td.tprrecommendationid and tpr.activeflag =1
			left join intakeservicerequestactor isa on isa.intakeservicerequestactorid = tpr.intakeservicerequestactorid 
			INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = td.intakeservicerequestactorid
			INNER JOIN person p ON p.personid=isra.personid AND p.activeflag=1
			LEFT JOIN servicetype st ON st.servicetypekey=td.servicetypekey AND st.activeflag=1
			LEFT JOIN actortype at on at.actortype = isra.intakeservicerequestpersontypekey
			WHERE td.servicecaseid = v_servicecaseid AND td.activeflag=1
			union
			select 
				(
				    SELECT rs.typedescription
				    FROM cjams.adoptionplanning ap
				    INNER JOIN cjams.adoptionbreakthelink abl ON abl.adoptionplanningid = ap.adoptionplanningid AND abl.activeflag = 1
				    INNER JOIN cjams.routing r ON r.objectid = abl.adoptionbreakthelinkid::varchar AND r.eventcode = 'ABLR' AND r.activeflag = 1
				    INNER JOIN cjams.routingstatustype rs ON rs.sequencenumber = r.routingstatustypeid AND rs.activeflag = 1
				    WHERE ap.servicecaseid = v_servicecaseid
				      AND ap.activeflag = 1
				      AND ap.intakeservicerequestactorid = tpr.intakeservicerequestactorid
				    ORDER BY r.insertedon DESC
				    LIMIT 1
				)::character varying AS breaklinkstatus,
				td.tprdetailsid,td.tprrecommendationid,td.intakeservicerequestactorid, isa.personid, td.intakeservreqcourtorderid,td.serveddate,td.servicetypekey,
				'' as servicetypedescription,
				td.terminationtypekey,td.isappealed,td.isdssappealed,td.appealdate,td.appealdecisiontypekey,td.decisiondate,td.reason,td.singleparent,
				( op.firstname || ' '||op.lastname):: character varying parentname,'UKN' as actortype, 'unknown' as typedescription,
				td.isgranted,td.isdenied,td.tprdecisiondate,td.old_id,td.relationshiptypekey,td.tprpetitiondate,td.iscontested,td.updatedon
			FROM 	tprdetails td
			left join tprrecommendation tpr on tpr.tprrecommendationid = td.tprrecommendationid and tpr.activeflag =1
			left join intakeservicerequestactor isa on isa.intakeservicerequestactorid = tpr.intakeservicerequestactorid 
			inner join otherperson op on op.personid = td.intakeservicerequestactorid and op.objecttype = 'PERMANENCYTPR'
			WHERE td.servicecaseid = v_servicecaseid AND td.activeflag=1;
	end if;
END;

 $function$
;