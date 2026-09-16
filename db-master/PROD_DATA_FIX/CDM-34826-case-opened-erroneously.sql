/*
   Issue Description: CDM-34826
   Category/ Module  : Intake
   Root cause: user wants to Screenout referral and delete service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot
SET
updatedby = 'CDM-34826', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011357737' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-34826', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231011357737' AND activeflag=1;


update intakedastatus 
	set status = 8, updatedby = 'CDM-34826', updatedon = now()
	where intakenumber = 'I231011357737'
	and activeflag = 1;
	
update routing set routingstatustypeid =8 ,updatedby = 'ca0e23df-c05e-4f45-8815-a3abfd8b0e18', updatedon = now() where routingid ='bbe50f53-3a1c-446f-9fd3-e16886c79d75';
	


update 	servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-34826', 
		updatedon = now() 
where 	servicecaseid = '8e93fdb2-4a5f-4ea8-bfa5-d18a2937d1ae' and activeflag = 1;

update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-34826', updatedon = now() 
where 	servicecaseid = '8e93fdb2-4a5f-4ea8-bfa5-d18a2937d1ae' and activeflag = 1;


select activeflag ,* from routing where objectid  ='8e93fdb2-4a5f-4ea8-bfa5-d18a2937d1ae';

update 	cjams.routing 
set 	activeflag =0,  updatedby = 'CDM-34826', updatedon = now() 
where 	routingid = '165ea1a0-f859-4c6f-9251-b0db4849c187' and activeflag = 1;