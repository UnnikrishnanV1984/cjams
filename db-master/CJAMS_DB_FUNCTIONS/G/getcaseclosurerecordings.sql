DROP FUNCTION if exists cjams.getcaseclosurerecordings(v_entitytypeid character varying);
CREATE OR REPLACE FUNCTION cjams.getcaseclosurerecordings(v_entitytypeid character varying)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 05/23/2014 Amiya Pradhan - CPS Response Timer Update CIDM-8867: B-175011- Closing AR/IR cases without completed initial contact 
------------------------------------------------------------------------------------------------------------                                                                                
DECLARE  
v_caseclosurerecordings json;
v_uuidornot character varying(50);
v_intakenumber character varying;

BEGIN 
raise notice 'v_entitytypeid %',v_entitytypeid;
SELECT * into v_uuidornot from uuid_or_null(v_entitytypeid);
IF v_uuidornot IS NOT NULL THEN  
select distinct intakenumber into v_intakenumber from intakeservicerequest where intakeserviceid = v_entitytypeid::uuid and activeflag = 1 LIMIT 1; 
END IF; 
SELECT json_agg(ccr) into v_caseclosurerecordings FROM ( 
SELECT  count(1) over(),     
pn.progressnoteid,                
(SELECT Json_agg(actor)
FROM ((SELECT 
isra.personid,
at.actortype 
      FROM contactparticipant cp
      INNER JOIN intakeservicerequestactor isra on  isra.intakeservicerequestactorid = cp.intakeservicerequestactorid
      INNER JOIN person p on p.personid = isra.personid      
  INNER JOIN
  (
SELECT distinct actortype FROM actortype
  ) at on at.actortype = isra.intakeservicerequestpersontypekey  
      WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag = 1 AND
                  cp.participanttypekey is distinct from 'COLLATERAL') union 
 (SELECT 
c.collateralid,
at.actortype 
      FROM contactparticipant cp
      INNER JOIN collateral c on  c.collateralid = cp.intakeservicerequestactorid and c.activeflag=1
  INNER JOIN collateralroleconfig  cc on c.collateralid = cc.collateralid and cc.activeflag=1
  INNER JOIN
  (
SELECT distinct actortype, typedescription FROM actortype
  ) at on at.actortype = cc.actortypekey  
      WHERE cp.progressnoteid = pn.progressnoteid AND cp.activeflag = 1 AND
                   cp.participanttypekey = 'COLLATERAL')
)actor) :: jsonb AS contactparticipant,                  
CAST(COALESCE (pn.insertedon , pn.insertedon) AS TIMESTAMP(3)) AS recordingdate ,                
pn.starttime ::timestamp  AS starttime ,pn.endtime ::timestamp   AS endtime 
from progressnote as pn
INNER JOIN progressnotetype AS pnt ON pnt.progressnotetypeid = pn.progressnotetypeid    
where 
pn.entitytypeid in (v_entitytypeid, v_intakenumber) and 
pn.progressnotereasontypekey='CC' and 
pnt.progressnotetypekey='Note' 			
) ccr;
RETURN v_caseclosurerecordings;                     
END;
$function$
;