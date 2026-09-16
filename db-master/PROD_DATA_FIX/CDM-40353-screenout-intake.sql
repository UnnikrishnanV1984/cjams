/*
   Issue Description: CDM-40353
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE intakesnapshot
SET
updatedby = 'CDM-40353', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
--jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{addendumNarrative}', '"<p>Referral staffed with CPS Supervisor T. Bosick for consideration of Physical Abuse due to providing child with toxic substances.  Decision is made to screen out for Physical Abuse as there was no reported lasting effect and the incident occurred allegedly a couple of months ago.  The mother is requesting services via hospital for DSS assistance.  She is willing to accept the child home with DSS services in place.  This referral would allow Supervisor Tyree to change the purpose to Request for Services.  CJAMS ticket # S20240204060343 was created on 7/22/24.  This case was physically assigned to Family Preservation Charmaine Osbourne but unable to provide the case in CJAMS due to this issue. 7/23/24-Screening Supervisor Tyree met with SSA J. Moore and MD THINK Shiny Swaminathan to discuss resolution.This referral is being screened out and Screened In for Family Preservation under city transfer referral# 241012813076  </p>"'))
WHERE intakenumber = 'I241012782885' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40353', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
--jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{addendumNarrative}', '"<p>Referral staffed with CPS Supervisor T. Bosick for consideration of Physical Abuse due to providing child with toxic substances.  Decision is made to screen out for Physical Abuse as there was no reported lasting effect and the incident occurred allegedly a couple of months ago.  The mother is requesting services via hospital for DSS assistance.  She is willing to accept the child home with DSS services in place.  This referral would allow Supervisor Tyree to change the purpose to Request for Services.  CJAMS ticket # S20240204060343 was created on 7/22/24.  This case was physically assigned to Family Preservation Charmaine Osbourne but unable to provide the case in CJAMS due to this issue. 7/23/24-Screening Supervisor Tyree met with SSA J. Moore and MD THINK Shiny Swaminathan to discuss resolution.This referral is being screened out and Screened In for Family Preservation under city transfer referral# 241012813076  </p>"'))
WHERE intakenumber = 'I241012782885' AND activeflag=1;


UPDATE intakeservicerequest  
SET   
    actiontype = null, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000', activeflag = 0, 
    updatedby = 'CDM-40353', updatedon = now() 
WHERE 
    
intakeserviceid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' 
AND activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0,
updatedon = now(),
updatedby = 'CDM-40353'
WHERE objectid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' AND activeflag =1;

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-40353',
  updatedon = now() 
where objectid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-40353',
  updatedon = now() 
where objectid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' and activeflag = 1;

-- DELETE CIS# 405061873 Deonna Peele and ADD CIS#  406061377 Deoona Peele
--Details of CIS# 405061873 Deonna Peele 
--intakeservicerequestactorid  ='21a0f260-3b12-45f8-8f12-a842cb90f5ee' , personid ='562f187e-d4f8-463e-b145-80daa901409f' ,intakeserviceid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' 
-- intakenumber = 'I241012782885'

update intakeservicerequestactor
set personid ='5a961aef-39e0-4ec1-923b-802894922415', updatedby = 'CDM-40353', updatedon = now()
where intakeservicerequestactorid  ='21a0f260-3b12-45f8-8f12-a842cb90f5ee' and personid ='562f187e-d4f8-463e-b145-80daa901409f' and (intakeserviceid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' 
or intakenumber = 'I241012782885') and activeflag = 1;



    
update actor
set personid ='5a961aef-39e0-4ec1-923b-802894922415',	updatedby = 'CDM-40353', updatedon = now()
where personid ='562f187e-d4f8-463e-b145-80daa901409f' and (intakeserviceid = '4d62eb7b-44c7-4406-ac02-beff4750a5a3' 
or intakenumber = 'I241012782885') and activeflag = 1 ;


 UPDATE intakedastaging
 SET 

 updatedby = 'CDM-40353', updatedon = now(), 
 jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{addendumNarrative}', '"<p>Referral staffed with CPS Supervisor T. Bosick for consideration of Physical Abuse due to providing child with toxic substances.  Decision is made to screen out for Physical Abuse as there was no reported lasting effect and the incident occurred allegedly a couple of months ago.  The mother is requesting services via hospital for DSS assistance.  She is willing to accept the child home with DSS services in place.  This referral would allow Supervisor Tyree to change the purpose to Request for Services.  CJAMS ticket # S20240204060343 was created on 7/22/24.  This case was physically assigned to Family Preservation Charmaine Osbourne but unable to provide the case in CJAMS due to this issue. 7/23/24-Screening Supervisor Tyree met with SSA J. Moore and MD THINK Shiny Swaminathan to discuss resolution.This referral is being screened out and Screened In for Family Preservation under city transfer referral# 241012813076  </p>"'))

 WHERE intakenumber = 'I241012782885' AND activeflag=1;

 UPDATE intakesnapshot
 SET 

 updatedby = 'CDM-40353', updatedon = now(), 
 jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{addendumNarrative}', '"<p>Referral staffed with CPS Supervisor T. Bosick for consideration of Physical Abuse due to providing child with toxic substances.  Decision is made to screen out for Physical Abuse as there was no reported lasting effect and the incident occurred allegedly a couple of months ago.  The mother is requesting services via hospital for DSS assistance.  She is willing to accept the child home with DSS services in place.  This referral would allow Supervisor Tyree to change the purpose to Request for Services.  CJAMS ticket # S20240204060343 was created on 7/22/24.  This case was physically assigned to Family Preservation Charmaine Osbourne but unable to provide the case in CJAMS due to this issue. 7/23/24-Screening Supervisor Tyree met with SSA J. Moore and MD THINK Shiny Swaminathan to discuss resolution.This referral is being screened out and Screened In for Family Preservation under city transfer referral# 241012813076  </p>"'))
 WHERE intakenumber = 'I241012782885' AND activeflag=1;


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INTR', '47dc653d-9089-4b47-b40e-0168ef6c2321', '47dc653d-9089-4b47-b40e-0168ef6c2321', '251662f5-88ee-4393-b4cc-d7c9f0b6d9a8', 'CWSP', 'CWSP', 'I241012782885', 8, 0, 'CDM-40353', now(), '47dc653d-9089-4b47-b40e-0168ef6c2321', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', 'screenout', now());

