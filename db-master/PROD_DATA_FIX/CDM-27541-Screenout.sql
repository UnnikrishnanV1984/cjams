/*
   Issue Description: CDM-27541
   Category/ Module  : Intake screen out and delete the case
   Root cause: user wants to delete case and decision is screenout 
   Pull request# for code fix: 5491
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
--Checked with QA so user requsted to screenout intake and remove case so they can go with new intake 

UPDATE intakesnapshot 
SET updatedby = 'CDM-27541', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010346909' AND activeflag=1;

update intakedastaging 
set status = 'Closed', updatedby = 'CDM-27541', updatedon = now()
where intakenumber = 'I221010346909' and activeflag = 1;


update intakeservicerequest set activeflag =0, updatedby = 'CDM-27541', updatedon = now() 
where servicerequestnumber = '221020283417' and activeflag =1;


update cjams.routing set routingstatustypeid =8, updatedby ='CDM-27541', updatedon = now()
where routingid ='047700b6-73c1-4cd8-a19f-f6ad1bdc42e8';



select * from routing where servicerequestnumber ='221020283417';


update routing set activeflag =0, updatedby ='CDM-27541', updatedon = now()

where routingid in('f3a01181-32d5-48b7-83e8-371fec8e4390','91d2e1a5-1475-46b5-9e47-3cdbf27fc510');




update personprogramarea set activeflag =0, updatedby ='CDM-27541', updatedon = now()
where personprogramid in('c30883f0-63d2-4fa2-b3d7-a1e825ec1ec2','dd6ff0a8-1764-416c-8b13-ae3eec5f3866','3f1d00a0-01b8-4b3b-8783-8b4ef624d0da',
'c0f4a42d-5d69-4437-83ab-08c912aadcfc','a17d45f6-74ca-4e48-a1be-6868825845ae', '51daf7b2-e86e-4c94-8189-e6a18cc426dd','f1c3b1ab-dbf9-4af0-bb1a-ac424d524058');


