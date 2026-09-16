/*
  Issue Description:  CDM-35318
   Category/ Module  :  Assignments
   Root cause: User request to Data fix remove the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

Update routing set 
routingstatustypeid = 8,activeflag=0, updatedon= now()
WHERE objectid = 'I231011194599' and routingid = '0c2ecaa3-48fc-4a08-b3cf-28a785c7b2a4';

update intakeDAStatus set status = 8, updatedby = 'CDM-35318', updatedon = now() 
where intakenumber = 'I231011194599' and activeflag =1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-35318', updatedon = now()
WHERE intakenumber = 'I231011194599' AND activeflag=1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-35318', updatedon = now() 
where intakenumber = 'I231011194599';

UPDATE intakesnapshot
SET
updatedby = 'CDM-35318', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011194599' AND activeflag=1;

update servicecase set activeflag =0, updatedby = 'CDM-35318', updatedon = now() 
where servicecaseid = '726be636-5c40-4447-bfeb-bfd994ce1cbd';

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-35318', updatedon = now() 
where servicecaseid = '726be636-5c40-4447-bfeb-bfd994ce1cbd';

update servicecaserequest set activeflag = 0, updatedby = 'CDM-35318', updatedon = now() 
where servicecaseid = '726be636-5c40-4447-bfeb-bfd994ce1cbd';

update caseassignment set activeflag = 0, updatedby = 'CDM-35318', updatedon = now()
where objectid = '726be636-5c40-4447-bfeb-bfd994ce1cbd'
and activeflag = 1;

update routing set activeflag = 0, updatedon = now(),
    updatedby = 'CDM-35318'
where objectid = '726be636-5c40-4447-bfeb-bfd994ce1cbd' and activeflag = 1;
