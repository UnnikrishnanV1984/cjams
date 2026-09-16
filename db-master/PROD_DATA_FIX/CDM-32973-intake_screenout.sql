/*
   Issue Description: CDM-32973
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-32973', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010633069' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-32973', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010633069' AND activeflag=1;

UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-32973', updatedon = now() 
WHERE 
    servicerequestnumber = '231020569577'
AND intakeserviceid = '4b6b0c75-96e7-488b-b840-baaf3708ed7d' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32973'
WHERE objectid = '4b6b0c75-96e7-488b-b840-baaf3708ed7d' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-32973',
  updatedon = now() 
where objectid = '4b6b0c75-96e7-488b-b840-baaf3708ed7d';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-32973',
  updatedon = now() 
where objectid = '4b6b0c75-96e7-488b-b840-baaf3708ed7d' and activeflag = 1;

