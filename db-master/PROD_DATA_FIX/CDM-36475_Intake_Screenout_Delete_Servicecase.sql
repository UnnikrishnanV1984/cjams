-- CDM-36475- Delete Service Case and Screenout Intake
/* 
-- Issue Description: 
   User request to delete service case and screenout intake
      
-- Case ID: 241030259703 - 49a01fdf-dc8f-4a4a-9e81-875c0fe37f47
-- Intake#: 

-- Category/ Module: Case Deletion

-- Root cause: User Error
-- Fix Provided: Deleted record from servicecase, servicecasedisposition & routing for service case. 
--				 Update intakedastaging, intakesnapshot & routing records to Screenout Intake
-- Pull request# N/A
*/

--- Service Case Delete
select * from servicecase where servicecasenumber = '241030259703';

update servicecase set activeflag = 0, updatedby = 'CDM-36475', updatedon = now()
where servicecaseid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47';

select * from servicecasedisposition where servicecaseid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47' and activeflag = 1;
update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-36475' 
where servicecaseid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47' and activeflag = 1;

select * from routing where objectid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47' and activeflag = 1;
update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-36475' 
where objectid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47'
	and activeflag = 1;
	
select * from caseassignment where objectid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47'  and activeflag = 1;
update caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CDM-36475' 
where objectid = '49a01fdf-dc8f-4a4a-9e81-875c0fe37f47'
	and activeflag = 1;
	
--- Intake Screenout	
--- intakedastaging
select status,activeflag,updatedby,* from intakedastaging where intakenumber ='I241011957744' and activeflag =1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-36475', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241011957744' AND activeflag =1;

-- intakesnapshot
select activeflag,intakesnapshotid,* from intakesnapshot where intakenumber ='I241011957744';

-- Found one record with activeflag = 0 
-- Overriding supervisor decison in anctive record to be in sync with intakedastaging
UPDATE intakesnapshot
SET updatedby = 'CDM-36475', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241011957744';

-- routing
select activeflag,routingstatustypeid, * from routing where objectid in ('I241011957744') and activeflag =1;

select routingstatustypeid,objectid, * from routing where routingid ='7542ada8-6a3c-4063-a291-751b0be4d359';

update routing 
	set activeflag =0, routingstatustypeid =8, updatedby ='64a77a00-ecd8-4a67-adad-2b75e35b601f', updatedon =now() 
	where routingid ='7542ada8-6a3c-4063-a291-751b0be4d359';

-- No records with activeflag = 1
select * from intakeservicerequest where intakenumber ='I241011957744';  -- activeflag = 0 , intakeserviceid = '99b4558a-c94c-4567-8ec4-1eecddf7fb28'

select * from caseassignment where objectid = '99b4558a-c94c-4567-8ec4-1eecddf7fb28';  -- activeflag = 0