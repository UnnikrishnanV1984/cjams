-- FUNCTION: cjams.getservicecase(character varying, integer, integer, character varying, character varying)

DROP FUNCTION if exists cjams.getservicecase(character varying, integer, integer, character varying, character varying);
DROP FUNCTION if exists cjams.getservicecase(character varying, integer, integer, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.getservicecase(userid character varying, page integer, pagelimit integer, casenumber character varying, l_status character varying, currentrole character varying DEFAULT NULL::character varying)
 RETURNS TABLE(totalcount bigint, caseid uuid, servicecasenumber character varying, legalguardian json, startdate timestamp without time zone, status character varying, open_closed character varying, enddate timestamp without time zone, programarea json, restrictstatus text, county character varying, responsibilitytypekey text, team character varying, programareabyservicecase json)
 LANGUAGE 'plpgsql'

AS $function$

------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 01/17/2023 Umasankar - Added team name -- CIDM-5888
-- 01/30/2023 - Vigneshwar Kumar - CDM-
--04/02/2024: Dashboard DUplicated are showing with end dated assignments -- CIDM-8591
--06/05/2024: Sai Kothapalli-CIDM-8742-Kinship Navigation Services
--06/05/2024 - Akhil Katukuri - Revert Sai Kothapalli code to unblock QA
--06/06/2024 - Akhil Katukuri - Added logic for kinship navigation
--08/05/2026 - Umasankar - Added casenumber check to end dated assignment filter so closed cases are returned in case number search-CIDM-11644
--08/05/2026 - Umasankar - Service cases duplicated on closed dashboard after reopen/close - added DISTINCT ON (c.objectid) - CIDM-10853
------------------------------------------------------------------------------------------------------------

DECLARE  
v_pageoffset int;
v_pagenumber int;
searchstring character varying(1000);
v_status character varying;

DECLARE totalcount integer;

BEGIN

v_pagenumber := (page-1) * 10;
v_status := coalesce(l_status,null);

-- This require code changes in UI once done we can remove this below check
IF v_status = 'All' THEN 
v_status := 'Open';
END IF;

RETURN QUERY

SELECT 	count(1) over(), * FROM 
(   
	SELECT  
		SC.servicecaseid,
		SC.servicecasenumber,
		(select getcasepersonname as legalguardian from getcasepersonname ('servicecase',SC.servicecaseid::character varying)),
		COALESCE(( select scd.statusdate FROM servicecasedisposition scd
		LEFT JOIN routing r ON r.objectid = scd.servicecasedispositionid::CHARACTER VARYING
		WHERE scd.servicecaseid = sc.servicecaseid AND scd.activeflag = 1
		AND (r.routingstatustypeid is NULL OR r.routingstatustypeid = 16) AND scd.intakeserreqstatustypekey = 'Open'
		ORDER BY scd.insertedon DESC LIMIT 1),SC.startdate )::timestamp,
		SC.statustypekey,
		coalesce((
		SELECT case when scd.intakeserreqstatustypekey = 'Closed' then 'Closed' else 'Open' end::varchar AS open_closed 
		FROM servicecasedisposition scd
		LEFT JOIN routing r ON r.objectid = scd.servicecasedispositionid::CHARACTER VARYING
		WHERE scd.servicecaseid = sc.servicecaseid AND scd.activeflag = 1
		AND (r.routingstatustypeid is NULL OR r.routingstatustypeid = 16)
		ORDER BY scd.insertedon DESC LIMIT 1)
		, 'Open') as open_closed,
		SC.enddate,
		case when (select count(*) from personprogramarea where objectid=SC.servicecaseid::character varying AND activeflag=1 AND sourcetype = 'CW') > 0 then 
			(SELECT json_agg(e) AS programarea 
			FROM
			(
				SELECT
					DISTINCT ppa.programkey,
					(SELECT ap.programname FROM agencyprogramarea ap 
					WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1 ) programname
				FROM personprogramarea ppa 
				WHERE ppa.objectid=SC.servicecaseid::character varying AND ppa.activeflag=1 AND ppa.sourcetype = 'CW'
			) AS e) 
		else 
		
			(SELECT json_agg(e) AS programarea 
			FROM
			(
				SELECT  apa.programkey, apa.programname 
				FROM agencyprogramarea apa
				INNER JOIN servicecaserequest scr ON scr.servicecaseid=SC.servicecaseid AND scr.activeflag=1
				WHERE apa.programkey = scr.programkey AND apa.activeflag =1  ORDER BY scr.insertedon desc LIMIT 1 
			) AS e) 
		end, 
		(SELECT * FROM getRestrictedCaseStatus(SC.servicecaseid::text,userid)) AS restrictStatus,
		(
			select distinct countyname from county where activeflag=1 and countyid = ca.toldssid limit 1 
		) as county,
		ca.responsibilitytypekey::text,
		ca.teamname as team,
		(SELECT json_agg(d) AS programarea 
			FROM
			(
				SELECT  ids.jsondata intakedastagingdtls
			FROM intakedastaging ids
			INNER JOIN intakeservicerequest isr ON isr.servicecaseid=sc.servicecaseid
			WHERE isr.intakenumber=ids.intakenumber AND ids.activeflag=1
			) AS d)
	FROM servicecase SC
	INNER JOIN (
		 SELECT DISTINCT ON (c.objectid)
        c.*, 
			(select teamname from team where  teamid = c.toteamid limit 1) as teamname
		from caseassignment c 
		where c.toworkeridno = userid  
		AND case when (casenumber is null or casenumber = '') and (v_status IS NULL OR v_status = 'Open') then (c.enddate IS NULL OR c.enddate > now()) else true end
	) ca on ca.objectid = SC.servicecaseid 			
	WHERE SC.activeflag = 1 and ca.activeflag = 1  
	AND (casenumber is null or casenumber = '' or SC.servicecasenumber like '%' ||   LOWER(casenumber)  ||  '%' )
	AND (CASE WHEN (currentrole IN ('Qualified Individual', 'FTDM/QI Supervisor', 'FTDM Facilitator')) THEN 
			lower(ca.teamname) = lower(currentrole) 
		ELSE 
			(ca.teamname) NOT IN ('Qualified Individual', 'FTDM/QI Supervisor', 'FTDM Facilitator')
		END)
	ORDER BY sc.insertedon DESC 
)AS datav 
WHERE datav.restrictStatus IN('INCL','INCLRES','EXCLUDE') AND ( v_status IS NULL OR datav.open_closed=v_status );

END;

$function$;
