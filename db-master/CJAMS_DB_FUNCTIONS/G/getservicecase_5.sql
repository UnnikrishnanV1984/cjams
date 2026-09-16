-- FUNCTION: cjams.getservicecase(character varying, integer, integer, character varying, character varying)

-- DROP FUNCTION cjams.getservicecase(character varying, integer, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION cjams.getservicecase(userid character varying,page integer,pagelimit integer,casenumber character varying,l_status character varying)
RETURNS TABLE(totalcount bigint, caseid uuid, servicecasenumber character varying, legalguardian json, startdate timestamp without time zone, status character varying, open_closed character varying, enddate timestamp without time zone, programarea json, restrictstatus text) 
    LANGUAGE 'plpgsql'
AS $function$

DECLARE  
v_pageoffset int;
v_pagenumber int;
searchstring character varying(1000);
v_status character varying;

DECLARE totalcount integer;

BEGIN

v_pagenumber := (page-1) * 10;
v_status := coalesce(l_status,'All');

RETURN QUERY
SELECT * FROM (   
SELECT 
	count(1) over(),	
    SC.servicecaseid,
    SC.servicecasenumber,
    (select getcasepersonname as legalguardian from getcasepersonname ('servicecase',SC.servicecaseid::character varying)),
	SC.startdate,
	SC.statustypekey,
	coalesce((
	SELECT case when scd.intakeserreqstatustypekey = 'Closed' then 'Closed' else 'Open' end::varchar as open_closed 
	FROM servicecasedisposition scd 
	where scd.servicecaseid = sc.servicecaseid and scd.activeflag = 1 
	and case 
	   when v_status = 'All' then v_status
  	   when coalesce(scd.intakeserreqstatustypekey,'Open') = 'Closed' then 'Closed' 
   	   else 'Open'
    end = v_status 
	order by effectivedate limit 1
	), 'Open') as open_closed,
	SC.enddate,
	(SELECT json_agg(e) AS programarea 
	FROM
	(
		SELECT
			DISTINCT ppa.programkey,
			ppa.subprogramkey,
			(SELECT rv.description FROM referencevalues rv 
			WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1 LIMIT 1) subprogramname,
			(SELECT ap.programname FROM agencyprogramarea ap 
			WHERE ap.programkey = ppa.programkey AND ap.activeflag =1 LIMIT 1 ) programname
		FROM personprogramarea ppa 
		WHERE ppa.objectid=SC.servicecaseid::character varying AND ppa.activeflag=1 AND ppa.sourcetype = 'CW'
	) AS e),
	(SELECT * FROM getRestrictedCaseStatus(SC.servicecaseid::text,userid)) AS restrictStatus
FROM servicecase SC 
INNER JOIN  (SELECT DISTINCT R.objectid FROM routing  R WHERE  R.tosecurityusersid  =  userid  AND eventcode ='SRVC'
             	AND  R.activeflag  =1 AND R.routingstatustypeid =4 )  R ON R.objectid =  SC.servicecaseid::  character  varying 
WHERE SC.activeflag=1   
AND (casenumber is null or casenumber = '' or SC.servicecasenumber like '%' ||   LOWER(casenumber)  ||  '%' )
AND SC.statustypekey = 'ASSGN' 

ORDER BY SC.insertedon DESC
LIMIT 10 OFFSET v_pagenumber
)AS datav WHERE datav.restrictStatus IN('INCL','INCLRES') ; 

END;

$function$
;
