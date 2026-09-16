/*
   Issue Description: CDM-29802
   Category/ Module  : intake
   Root cause: servicase disappeared so updated the actiontype 
   Pull request# for data fix: 8212
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix

   update intakeservicerequest set actiontype ='AR', updatedby = 'CDM-29082', 
   updatedon = now() where intakenumber = 'I231010510354';
*/

/*
-- CDM-29082 - CDM-29082 Case disappeared after assignment
-- Issue Description: 
   case #231020436746 still appears and should be removed.
   User request to update Intake decision as Screened-Out and delete the associated CPS Case
      
-- Intake ID: I231010510354
-- CPS-IR: 231020436746
-- "intakeserviceid":"7e2e0294-d341-4116-aef7-57f52f3b77a0"

-- Category/ Module: Adoption (Case Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakesnapshot 
set updatedby = 'CDM-29082', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}', 
	jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
	jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I231010510354' 
	and activeflag = 1;

update intakedastaging 
set status = 'Closed', 
	updatedby = 'CDM-29082', 
	updatedon = now()
where intakenumber = 'I231010510354' 
and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, 
	updatedby = 'CDM-29082', 
	updatedon = now() 
where servicerequestnumber = '231020436746' 
	and activeflag = 1;

select personprogramid, programkey, subprogramkey, startdate, enddate, updatedby, updatedon 
from personprogramarea 
where objectid 
		in (	select intakeserviceid::character varying
					from intakeservicerequest 
				where servicerequestnumber = '231020436746'
			)
	and activeflag = 1;

update personprogramarea 
set activeflag = 0, 
	updatedby = 'CDM-29082', 
	updatedon = now()
where objectid 
		in (	select intakeserviceid::character varying
					from intakeservicerequest 
				where servicerequestnumber = '231020436746'
			)
	and activeflag = 1;

select routingid, routingstatustypeid, remarks, updatedby, updatedon 
	from routing  
where objectid = '7e2e0294-d341-4116-aef7-57f52f3b77a0'
	and servicerequestnumber = '231020436746'
	and activeflag = 1;

update routing
set activeflag = 0, 
	updatedby = 'CDM-29082', 
	updatedon = now()
where objectid = '7e2e0294-d341-4116-aef7-57f52f3b77a0'
	and servicerequestnumber = '231020436746'
	and activeflag = 1;
	
select caseassignmentid, responsibilitytypekey, startdate, enddate, updatedby, updatedon  
	from caseassignment 
where objectid = '7e2e0294-d341-4116-aef7-57f52f3b77a0'
	and objecttypekey = 'servicerequest'
	and activeflag = 1;

update caseassignment 	
set activeflag = 0, 
	updatedby = 'CDM-29082', 
	updatedon = now()
where objectid = '7e2e0294-d341-4116-aef7-57f52f3b77a0'
	and objecttypekey = 'servicerequest'
	and activeflag = 1;

-- objectid = 'I231010510354' -- use below  where objectid = 'I231010510354' to get the routingid
select routingid, routingstatustypeid, eventcode, remarks, updatedby, updatedon 
	from routing
where routingid = '29b7a656-c259-4fbd-8efc-dab021dd29ae' ;

delete from routing 
where routingid = '29b7a656-c259-4fbd-8efc-dab021dd29ae' ;

/*
-- To revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('29b7a656-c259-4fbd-8efc-dab021dd29ae', 'INTR', 'da379eec-8f1f-40ee-9183-40029de0724f', '7414c353-30fb-40ce-a0e6-1a74dc43e118', '9422c3a0-ee8a-4876-a489-273e5bef2623', 'CWIW', 'CWSP', 'I231010510354', 8, 0, 'da379eec-8f1f-40ee-9183-40029de0724f', '2023-02-27 11:05:13.244', '7414c353-30fb-40ce-a0e6-1a74dc43e118', '2023-02-27 12:25:59.510', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/