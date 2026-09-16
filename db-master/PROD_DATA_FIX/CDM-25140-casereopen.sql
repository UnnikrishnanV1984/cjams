/*
   Issue Description: CDM-25140
   Category/ Module  : CPS AR Case
   Root cause: User requested to reopen the AR Case 221020235177.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 	intakeserreqstatustypeid from intakeservicerequest 
where 	intakeserviceid = '6afbcc28-a9c4-4997-a39f-e81f415941d2';

update 	intakeservicerequest 
set 	updatedby ='CDM-25140', 
		updatedon = now(), 
		intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da'
where 	intakeserviceid = '6afbcc28-a9c4-4997-a39f-e81f415941d2';

select 	activeflag from Intakeservicerequestdispositioncode
where 	intakeservicerequestdispositioncodeid = '42530a3f-6dbb-4b2c-871b-03f271e3310b';

update  Intakeservicerequestdispositioncode 
set 	activeflag = 0,
		updatedby ='CDM-25140', 
		updatedon = now() 
where 	intakeservicerequestdispositioncodeid = '42530a3f-6dbb-4b2c-871b-03f271e3310b';

select 	routingstatustypeid from routing
where 	routingid = '49fb1bd4-a174-477c-ab2a-bbdd71a1770e'
		and objectid = '42530a3f-6dbb-4b2c-871b-03f271e3310b' and eventcode = 'INDR' and activeflag = 1;

update 	routing
set 	routingstatustypeid = null,
		updatedby ='CDM-25140', 
		updatedon = now() 
where 	routingid = '49fb1bd4-a174-477c-ab2a-bbdd71a1770e'
		and objectid = '42530a3f-6dbb-4b2c-871b-03f271e3310b' and eventcode = 'INDR' and activeflag = 1;