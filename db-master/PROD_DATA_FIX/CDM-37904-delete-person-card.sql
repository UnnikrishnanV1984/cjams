/*
   Issue Description: CDM-37904
   Category/ Module  :Need a Person removed
   Root cause: User requested to remove Need to remove  client ID # 202532287 which was create as duplicate
   Fix Privided:  Data fix has been promoted to remove client ID # 202532287 from personswith case #3218937.
*/
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37904'
where actorid ='45442b66-47ab-4dcd-aac4-43935ec2d477';

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37904'
where intakeservicerequestactorid = '285419c1-a169-429b-9cdc-b708b05e5665';

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37904'
where personroleid  = '15ed67e5-06fb-4e1b-9a05-d4eb73a16f0b';

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37904'
where actorrelationshipid = 'fbb3d0dd-c40d-41f8-b25c-2031c29b06bb';


update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37904' 
where personprogramid = '02ffca6a-d7ef-4175-8acb-93bdcb64d28c';

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37904' 
where personroletypeid = '066dd820-5d2d-4c46-a3d3-72c040320f14';