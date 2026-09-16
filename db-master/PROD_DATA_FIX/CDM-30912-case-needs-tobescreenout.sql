/*
   Issue Description: CDM-30912
   Category/ Module  : Dashboard
   Root cause: User wants to screenout Intake and remove CPS AR case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CDM-30912',
   updatedon = now() 
where 
servicerequestnumber = '231020484397';

update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CDM-30912',
  updatedon = now() 
where objectid = '51780c27-6e67-4877-9b8e-fe41a4559fd7';

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-30912',
  updatedon = now() 
where objectid = '51780c27-6e67-4877-9b8e-fe41a4559fd7';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-30912',
  updatedon = now() 
where objectid = '51780c27-6e67-4877-9b8e-fe41a4559fd7' and activeflag = 1;

UPDATE intakesnapshot 
SET updatedby = 'CDM-30912', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010282703' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-30912', updatedon = now()
where intakenumber = 'I221010282703' and activeflag = 1;

