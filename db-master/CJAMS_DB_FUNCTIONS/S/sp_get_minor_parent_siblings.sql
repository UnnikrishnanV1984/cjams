DROP FUNCTION IF EXISTS cjams.sp_get_minor_parent_siblings(character varying);
CREATE OR REPLACE FUNCTION cjams.sp_get_minor_parent_siblings(cjamspid character varying)
 RETURNS TABLE(siblingsinfo json, childproviderid int)
 LANGUAGE plpgsql
AS $function$

 -------------------------------------------------------------------------------------------
--Revision(s)
-- 12/27/2023 Palani/Manasa - Query optimization changes(CIDM-8263)
-------------------------------------------------------------------------------------------  

DECLARE 
        vs_cjamspid                   character varying;
        vs_motherDob                  timestamp without time zone;
        vs_childDob                   timestamp without time zone;
        vs_childpersonid              uuid;
        vs_parentpersonid             uuid;
        vs_parentage                  int;
        

BEGIN
vs_cjamspid            := cjamspid;

select pr.personid, pr.dob into vs_childpersonid, vs_childDob from person pr where pr.cjamspid:: character varying = vs_cjamspid;
select pr.personid, pr.dob into vs_childpersonid, vs_childDob from person pr where pr.cjamspid = vs_cjamspid::bigint;
select pr.personid, pr.dob into vs_parentpersonid, vs_motherDob from person pr where pr.personid = 
(select ar.person1id from actorrelationship ar where ar.person2id = vs_childpersonid  and ar.relationshiptypekey = 'BGMTHR' limit 1);

select * into vs_parentage from f_age(vs_childDob,vs_motherDob);
 

RETURN QUERY
SELECT

(SELECT 
	Json_agg(e) AS siblingsinfo 
	FROM 
	(
  select  
  concat (p.firstname ||' '|| p.lastname) as name, p.cjamspid as siblingclientid,
  (SELECT 
	Json_agg(gsj) AS guardianinfo 
	FROM 
  (select gs.guardianoneproviderid, gs.guardianonename from guardianship gs 
    inner join permanencyplan pp on gs.permanencyplanid = pp.permanencyplanid
    inner join intakeservicerequestactor isra on isra.intakeservicerequestactorid = pp.intakeservicerequestactorid and isra.servicecaseid = pp.servicecaseid
    where isra.personid = p.personid) As gsj):: json,
  (select ar.relationshiptypekey from actorrelationship ar
                where ar.person1id = p.personid and person2id = vs_childpersonid Limit 1) 
  from person p 
     join tb_client_eligibility tce on p.cjamspid = tce.client_id and tce.eligibility_type_cd = '2935'   
     where p.personid in
            (select person1id from actorrelationship 
                where person2id = vs_childpersonid and relationshiptypekey in ('BGSISTR','BIOBR'))
) AS e) :: json,
(select pl.altproviderid  from placement pl inner join intakeservicerequestactor ia ON pl.intakeservicerequestactorid = ia.intakeservicerequestactorid where ia.personid = vs_childpersonid order by pl.startdatetime Desc Limit 1)
FROM  
(
  SELECT       
        p.personid
        
      FROM
        person p
    WHERE
        p.cjamspid = vs_cjamspid::bigint
)AS  "Person" LIMIT 1;


END;
    

$function$;
