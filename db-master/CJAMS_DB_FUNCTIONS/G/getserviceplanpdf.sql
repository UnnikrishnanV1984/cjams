DROP FUNCTION IF EXISTS cjams.getserviceplanpdf(uuid, character varying);

CREATE OR REPLACE FUNCTION cjams.getserviceplanpdf(v_id uuid, v_doctype character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare 
-------------------------------------------------------------------------------------------------------------------------------
--Revisions 
--12/12/2022 -- Umasankar Raavi --CIDM-6074-Changed targetdate and effective date as versionfilterenddate and versionfilterstartdate as per user story
--------------------------------------------------------------------------------------------------------------------------------

v_childrennames text;
obj json;
begin

	select string_agg(distinct firstname||' '||lastname, ', ') into v_childrennames from person p
	inner join personprogramarea pa on pa.personid = p.personid and pa.programkey = 'OOH' and pa.activeflag = 1 and pa.sourcetype = 'CW'
	inner join actor a on a.personid = pa.personid and a.activeflag = 1 and a.ishouseholdmember = 1
	inner join intakeservicerequestactor isra on isra.actorid = a.actorid and isra.activeflag = 1 
	and isra.intakeservicerequestpersontypekey in ('OTHERCHILD', 'CHILD')
	and (
	isra.servicecaseid = (select sp.objectid from serviceplan sp where sp.serviceplanid = (select objectid from snapshothist sn where sn.id :: character varying = v_id :: character varying and sn.activeflag =1):: uuid):: uuid 
	OR 
	isra.intakeserviceid = (select sp.objectid from serviceplan sp where sp.serviceplanid = (select objectid from snapshothist sn where sn.id :: character varying = v_id :: character varying and sn.activeflag =1):: uuid):: uuid);


	select json_agg(x) into obj from (
	select sn.snapshotdata,up.fullname,cs.caseno,(sn.snapshotdata ->> 'versionfilterenddate') as enddate, sn.snapshotdata ->> 'versionfilterstartdate' as startdate,
	(sn.snapshotdata ->> 'splangoal')::json as goal, (sn.signatures)::json as signatures , (sn.snapshotdata ->> 'serviceplancandidacy')::json as candidacys, 
	(sn.snapshotdata ->> 'visitationplans')::json as visitationplans, v_childrennames as childrenHeader, (sn.snapshotdata ->> 'legalGuardian') as legalGuardian
	from snapshothist sn 
	left join userprofile up on up.securityusersid = sn.insertedby 
	join serviceplan sp on sp.serviceplanid:: character varying = sn.objectid 
	join (select sc.servicecaseid as caseid,sc.servicecasenumber as caseno from servicecase sc  where sc.activeflag=1
	union all
	select ins.intakeserviceid as caseid , ins.servicerequestnumber as caseno from intakeservicerequest ins where ins.activeflag=1 
     ) cs on cs.caseid :: character varying = sp.objectid	
	where sn.id :: character varying   = v_id :: character varying and sn.activeflag =1
	) x;
 return obj;
		
end;

$function$;