/*
  Issue Description:  CDM- 40430
   Category/ Module  :  Application
   Root cause: User error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update servicecase set activeflag =0, updatedby = 'CDM-40430', updatedon = now() 
where servicecaseid = 'd9933a51-73d3-4beb-93aa-2516bcf8ab10' and activeflag =1;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-40430', updatedon = now() 
where servicecaseid = 'd9933a51-73d3-4beb-93aa-2516bcf8ab10' and activeflag =1;

update servicecaserequest set activeflag = 0, updatedby = 'CDM-40430', updatedon = now() 
where servicecaseid = 'd9933a51-73d3-4beb-93aa-2516bcf8ab10' and activeflag =1;

update caseassignment  set activeflag = 0, updatedby = 'CDM-40430', updatedon = now()
where objectid = 'd9933a51-73d3-4beb-93aa-2516bcf8ab10'
and activeflag = 1;


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-40430', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012802155' AND activeflag=1;

update routing set supervisordecision = 'screenout'  where routingid = 'd49d6d1c-efc8-42b5-8e73-21cb1dac801b' 
and objectid = 'I241012802155';
