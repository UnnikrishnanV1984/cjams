/*
   Issue Description: CDM-43705
   Category/ Module  : Dashboard
   Root cause: User wants to remove CPS-IR case and screen out the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-43705', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013159576' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-43705', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013159576' AND activeflag=1;

update routing
set activeflag = 0, routingstatustypeid = 8, supervisordecision = 'screenout', updatedon = now()
where routingid = '97908529-17c3-48b6-b04e-c5204e2e8d9d' and objectid = 'I241013159576' and activeflag=1;

UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CDM-43705', updatedon = now() 
WHERE servicerequestnumber = '241022937290' AND intakeserviceid = '94808f94-868e-464c-840b-292a76b107f7' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-43705'
WHERE objectid = '94808f94-868e-464c-840b-292a76b107f7' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-43705', updatedon = now() 
where objectid = '94808f94-868e-464c-840b-292a76b107f7';

update routing
set activeflag = 0, updatedby = 'CDM-43705', updatedon = now() 
where objectid = '94808f94-868e-464c-840b-292a76b107f7' and activeflag = 1;

update 
intakeservicerequestdispositioncode
set 
	activeflag = 0,  
  updatedby = 'CDM-43705',
  updatedon = now() 
where intakeserviceid = '94808f94-868e-464c-840b-292a76b107f7'
and activeflag = 1;

update 
actor
set 
  activeflag = 0,  
  updatedby = 'CDM-43705',
  updatedon = now() 
where intakeserviceid = '94808f94-868e-464c-840b-292a76b107f7'
and activeflag = 1;

update 
intakeservicerequestactor
set 
  activeflag = 0,  
  updatedby = 'CDM-43705',
  updatedon = now() 
where intakeserviceid = '94808f94-868e-464c-840b-292a76b107f7'
and activeflag = 1;


update 
personrole
set 
  activeflag = 0,  
  updatedby = 'CDM-43705',
  updatedon = now() 
where intakeserviceid = '94808f94-868e-464c-840b-292a76b107f7'
and activeflag = 1;


