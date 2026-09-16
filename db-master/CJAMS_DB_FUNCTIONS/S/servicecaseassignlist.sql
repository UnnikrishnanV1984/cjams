DROP  FUNCTION IF EXISTS cjams.servicecaseassignlist(v_usersid character varying, v_status character varying, v_page integer, v_limit integer, servicecaseno character varying);
CREATE OR REPLACE FUNCTION cjams.servicecaseassignlist(v_usersid character varying, v_status character varying, v_page integer, v_limit integer, servicecaseno character varying)
 RETURNS TABLE(totalcount bigint, servicecaseid uuid, servicecasenumber character varying, caseheadname character varying, startdate timestamp without time zone, statustypekey character varying, enddate timestamp without time zone, assignedusername text, insertedon timestamp without time zone, program json, subprogram json, intakedastagingdtls json, casetype character varying, servicerequesttypekey character varying, legalguardian json)
 LANGUAGE plpgsql
AS $function$
-----------------------------------------------------------------------
-- Revision(s):
-- 06/269/2023 Palani/Chandra - Performance fix -- CIDM-7371
-- 05/16/2025 Parshal Chitrakar - CIDM-10492 Case showing to assign in the to be assigned tab, but already assigned.
------------------------------------------------------------------------

DECLARE

v_offset    integer;
v_routingstatustypeid integer;
err_context text;

BEGIN
v_offset  :=  (v_page  -  1)  *  v_limit;

IF lower(v_status) = 'open' THEN
v_routingstatustypeid = 2;
ELSE
v_routingstatustypeid = 4;
END IF;


RETURN  query

        SELECT
count(1) over(),
sc.servicecaseid,
sc.servicecasenumber,
sc.caseheadname,
sc.startdate,
case when lower(v_status) ='open' then 'OPEN' else sc.statustypekey end,
sc.enddate,
            (SELECT up.firstname || ' ' || up.lastname assignedusername FROM userprofile up
                        WHERE up.securityusersid = sc.tosecurityusersid AND  up.activeflag =1 limit 1),
sc.insertedon,
(SELECT json_agg(t) FROM (
SELECT  apa.programname, apa.programkey
FROM agencyprogramarea apa
INNER JOIN servicecaserequest scr ON scr.servicecaseid=sc.servicecaseid AND scr.activeflag=1
WHERE apa.programkey = scr.programkey AND apa.activeflag =1  ORDER BY scr.insertedon desc LIMIT 1
) AS t
),
(SELECT json_agg(e) FROM (
SELECT  rv.description subprogramname, rv.ref_key subprogramkey
FROM referencevalues rv
INNER JOIN servicecaserequest scr ON scr.servicecaseid=sc.servicecaseid AND scr.activeflag=1
WHERE  rv.ref_key=scr.subprogramkey AND rv.activeflag=1 AND referencetypeid =12
ORDER BY scr.insertedon desc LIMIT 1 ) AS e
),
(SELECT json_agg(d) FROM (
SELECT  ids.jsondata intakedastagingdtls
FROM intakedastaging ids
INNER JOIN intakeservicerequest isr ON isr.servicecaseid=sc.servicecaseid
WHERE isr.intakenumber=ids.intakenumber AND ids.activeflag=1) AS d
),
'Servicecase' :: character varying,
(Select  classkey FROM servicecaserequest SR INNER JOIN servicerequestsubtype SRT ON SRT.servicerequestsubtypeid = SR.servicerequestsubtypeid
and SRT.intakeservreqtypeid = SRT.intakeservreqtypeid AND SR.servicecaseid = sc.servicecaseid
AND SRT.activeflag =1 AND SR.activeflag =1 limit 1) servicerequesttypekey ,
(select getcasepersonname from getcasepersonname ('servicecase',sc.servicecaseid:: CHARACTER VARYING)) AS legalguardian
        FROM ( SELECT r.tosecurityusersid ,sc.* FROM servicecase sc
--LEFT JOIN routing r ON r.objectid = sc.servicecaseid ::character varying AND r.activeflag =1  
INNER JOIN routing r ON (case when length(r.objectid)=36 then r.objectid else null end)::uuid= sc.servicecaseid AND r.activeflag =1  
AND r.routingstatustypeid in (v_routingstatustypeid ) AND  r.eventcode = 'SRVC'
AND (CASE v_routingstatustypeid WHEN  2 THEN r.tosecurityusersid = v_usersid  
ELSE r.fromsecurityusersid = v_usersid END)
WHERE LOWER(sc.statustypekey) = lower(v_status)
AND SC.servicecasenumber  LIKE  servicecaseno  ||'%'
AND sc.activeflag = 1
AND v_usersid IN (CASE v_routingstatustypeid WHEN 2 THEN coalesce(r.tosecurityusersid,'') ELSE  r.fromsecurityusersid END , CASE v_routingstatustypeid WHEN 2 THEN coalesce(sc.insertedby,'') ELSE '' END )
UNION  
SELECT r.tosecurityusersid ,sc.* FROM servicecase sc
--INNER JOIN routing r ON r.objectid = sc.servicecaseid ::character varying AND r.activeflag =1
INNER JOIN routing r ON (case when length(r.objectid)=36 then r.objectid else null end)::uuid= sc.servicecaseid AND r.activeflag =1  
AND r.routingstatustypeid in (9 ) AND  r.eventcode = 'SRVC'
AND (CASE v_routingstatustypeid WHEN  2 THEN r.tosecurityusersid = v_usersid  
ELSE r.fromsecurityusersid = v_usersid END)
WHERE (CASE v_routingstatustypeid WHEN v_routingstatustypeid THEN LOWER(sc.statustypekey) in ('open') ELSE LOWER(sc.statustypekey) in ('open','assgn') END)
AND SC.servicecasenumber  LIKE  servicecaseno  ||'%'
AND sc.activeflag = 1
AND v_usersid IN (CASE v_routingstatustypeid WHEN 2 THEN coalesce(r.tosecurityusersid,'') ELSE  r.fromsecurityusersid END , CASE v_routingstatustypeid WHEN 2 THEN coalesce(sc.insertedby,'') ELSE '' END )
) sc
  ORDER BY sc.startdate DESC
        LIMIT v_limit OFFSET v_offset;
 
END;
 
$function$
;