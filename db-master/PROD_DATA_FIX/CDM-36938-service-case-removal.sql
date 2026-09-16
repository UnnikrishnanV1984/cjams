 /*
-- CDM-36938 - 

-- Issue Description: 
We decided that this should not be screened in as a case. It needs to be removed please help to remove Brooklyn Ferrell case.
  
-- Customer Email ID:whitney.daggett2@maryland.gov

-- Root cause: user requested to remove the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
 
 UPDATE intakesnapshot 
SET 
updatedby = 'CDM-36938', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241011887638' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-36938', updatedon = now()
where intakenumber = 'I241011887638'
and activeflag = 1;

update intakedastatus set status = 8, updatedby = 'CDM-36938', updatedon = now() where intakenumber  = 'I241011887638' and activeflag = 1;

Update routing set 
routingstatustypeid = 8
WHERE objectid = 'I241011887638';

UPDATE intakeservicerequest 
SET servicecaseid = null,
    updatedon = now(),
    updatedby = 'CDM-36938'
WHERE servicerequestnumber  = '241021736825';
 
select * from servicecase where servicecaseid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
---service case delete
update servicecase set activeflag = 0, updatedon = now(), updatedby = 'CDM-36938' 
   where servicecaseid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
  
select * from servicecasedisposition where servicecaseid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
---servicecase Disposition removal
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-36938', updatedon = now() 
where servicecaseid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';

select * from caseassignment where objectid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
---caseassignment removal
update caseassignment set activeflag = 0, updatedby = 'CDM-36938', updatedon = now() 
where objectid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d' and activeflag = 1 ;

select * from routing where objectid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
--routing removal
update routing set activeflag = 0, updatedby = 'CDM-36938', updatedon = now() 
where objectid = '5ffd7305-5b3c-4ee1-99e1-8a4785d68f4d';
 