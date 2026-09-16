/*
   Issue Description: CDM-32980
   Category/ Module  : Dashboard
   Root cause: User wants to remove CPS-IR case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Screenout I231010579675 and 231020509755
UPDATE intakesnapshot
SET
updatedby = 'CDM-32980', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010579675' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-32980', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010579675' AND activeflag=1;

update routing
set routingstatustypeid = 8
where routingid = '5c33f6fb-4d2a-433f-a751-a50f20947f5f' and objectid = 'I231010579675';

UPDATE intakeservicerequest  
SET  actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
updatedby = 'CDM-32980', updatedon = now() 
WHERE servicerequestnumber = '231020509755' AND intakeserviceid = '7dc324d1-e1b3-4cfd-8f9e-1aee64e51145' AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-32980'
WHERE objectid = '7dc324d1-e1b3-4cfd-8f9e-1aee64e51145' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-32980', updatedon = now() 
where objectid = '7dc324d1-e1b3-4cfd-8f9e-1aee64e51145';

update routing
set activeflag = 0, updatedby = 'CDM-32980', updatedon = now() 
where objectid = '7dc324d1-e1b3-4cfd-8f9e-1aee64e51145' and activeflag = 1;

-- 05/30/2023 to 04/24/2023 for I231010621873 and 231020553882 
update intakedastaging 
set daterecieved = '2023-04-24 17:39:33', timerecieved = '2023-04-24 17:39:33'
, jsondata = replace(jsondata :: text , '05/30/2023 05:39:33 PM', '04/24/2023 05:39:33 PM')::json
, updatedby = 'CDM-32980', updatedon = now()
where intakenumber = 'I231010621873' and activeflag = 1 ;

update intakedastaging 
set jsondata = replace(jsondata :: text , '2023-05-30T21:39:33.703Z', '2023-04-24T21:39:33.703Z')::json
, updatedby = 'CDM-32980', updatedon = now()
where intakenumber = 'I231010621873' and activeflag = 1 ;

update intakeservicerequest set intakedaterecieved = '2023-04-24 17:39:33', reporteddate = '2023-04-24 17:39:33',
updatedby = 'CDM-32980', updatedon = now()
where IntakeNumber = 'I231010621873';	

update intakesnapshot 
set jsondata = replace(jsondata :: text , '2023-05-30T21:39:33.703Z', '2023-04-24T21:39:33.703Z')::json
, updatedby = 'CDM-32980', updatedon = now()
where intakenumber = 'I231010621873' and activeflag = 1 ;

update intakesnapshot 
set jsondata = replace(jsondata :: text , '05/30/2023 05:39:33 PM', '04/24/2023 05:39:33 PM')::json
, updatedby = 'CDM-32980', updatedon = now()
where intakenumber = 'I231010621873' and activeflag = 1 ;

UPDATE cjams.cpsresponsetimeractions
SET intakeserviceid='50f75535-4259-45f9-b0f3-6e5d531de6da', updatedby='CDM-32980', updatedon='2023-07-14 16:36:39'
WHERE cpsresponsetimeractionsid='2ca23596-3267-4228-a037-fc95cb58cf15';

UPDATE cjams.legislative
SET updatedby='CDM-32980', updatedon = now(), islegislativereporting='SDNRAA'
WHERE legislativeid='2ed5e575-c3bd-4e86-afc6-7fd90495adee' and intakeserviceid='50f75535-4259-45f9-b0f3-6e5d531de6da';

