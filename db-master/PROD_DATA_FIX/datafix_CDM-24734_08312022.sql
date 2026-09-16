-- CDM-24734 - Duplicate case
/*
-- Issue Description: 
   User request to update Intake decision as Screened-Out and delete the associated CPS Case
      
-- Intake ID: I211010191513
-- CPS-IR: 211020140607 - e8eb95a5-1011-45b8-bdee-4fa44ec0cc44

-- Category/ Module: Adoption (Case Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakesnapshot 
set updatedby = 'CDM-24734', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I211010191513' 
	and activeflag = 1;

update intakedastaging 
set status = 'Closed', 
	updatedby = 'CDM-24734', 
	updatedon = now()
where intakenumber = 'I211010191513' 
and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, 
	updatedby = 'CDM-24734', 
	updatedon = now() 
where servicerequestnumber = '211020140607' 
	and activeflag = 1;

select personprogramid, programkey, subprogramkey, startdate, enddate, updatedby, updatedon 
from personprogramarea 
where objectid 
		in (	select intakeserviceid::character varying
					from intakeservicerequest 
				where servicerequestnumber = '211020140607'
			)
	and activeflag = 1;

update personprogramarea 
set activeflag = 0, 
	updatedby = 'CDM-24734', 
	updatedon = now()
where objectid 
		in (	select intakeserviceid::character varying
					from intakeservicerequest 
				where servicerequestnumber = '211020140607'
			)
	and activeflag = 1;

select routingid, routingstatustypeid, remarks, updatedby, updatedon 
	from routing  
where objectid = 'e8eb95a5-1011-45b8-bdee-4fa44ec0cc44'
	and servicerequestnumber = '211020140607'
	and activeflag = 1;

update routing
set activeflag = 0, 
	updatedby = 'CDM-24734', 
	updatedon = now()
where objectid = 'e8eb95a5-1011-45b8-bdee-4fa44ec0cc44'
	and servicerequestnumber = '211020140607'
	and activeflag = 1;
	
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon  
	from caseassignment 
where objectid = 'e8eb95a5-1011-45b8-bdee-4fa44ec0cc44'
	and objecttypekey = 'servicerequest'
	and activeflag = 1;

update caseassignment 	
set activeflag = 0, 
	updatedby = 'CDM-24734', 
	updatedon = now()
where objectid = 'e8eb95a5-1011-45b8-bdee-4fa44ec0cc44'
	and objecttypekey = 'servicerequest'
	and activeflag = 1;


-- objectid = 'I211010191513'
select routingid, routingstatustypeid, eventcode, remarks, updatedby, updatedon 
	from routing
where routingid = 'd73b05c8-354d-4f8f-9616-b9e8e75cf429' ;

delete from routing 
where routingid = 'd73b05c8-354d-4f8f-9616-b9e8e75cf429' ;

/*
-- To revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d73b05c8-354d-4f8f-9616-b9e8e75cf429'::uuid, 'XXXX', 'f2d9b273-d477-41d7-9fb6-fe52c9551f3b', 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', '7cc38f64-153a-46e5-9230-bff302e8e606'::uuid, 'CWIW', 'CWSP', 'I211010191513', 1, 0, 'f2d9b273-d477-41d7-9fb6-fe52c9551f3b', '2021-09-16 23:34:57.251', 'f2d9b273-d477-41d7-9fb6-fe52c9551f3b', '2021-09-17 07:42:14.086', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/