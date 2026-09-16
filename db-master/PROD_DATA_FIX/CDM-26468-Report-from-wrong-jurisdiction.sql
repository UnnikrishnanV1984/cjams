/*
   Issue Description: CDM-26468
   Category/ Module  : Report from wrong jurisdiction
   Root cause: REMOVE THIS CASE FROM HER SYSTEM ALERTS.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update usernotification set updatedby = 'CDM-26468', updatedon = now(), activeflag ='0' where usernotificationid  = 'f777ee5e-92b9-4fd2-aa9e-958312b589a6';

update usernotificationmap set updatedby = 'CDM-26468', updatedon = now(), activeflag = '0' where tosecurityusersid = '88f55d96-49e4-49c4-bf29-08490b292d32' ;
and usernotificationid = 'f777ee5e-92b9-4fd2-aa9e-958312b589a6'

update servicecasedisposition  set updatedon = now(), insertedby  = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', updatedby = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1' where 
servicecaseid = '44737c6e-f051-4acb-9fe5-3cf57fcaedac' and servicecasedispositionid  = '225f98dc-7e88-4cb0-96d6-c8f8195af6c9';

update routing set updatedon = now(), fromsecurityusersid = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', tosecurityusersid  = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', teamid = '32feacbf-2de9-47a6-b542-e837d92715a7',
insertedby  = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', updatedby = 'e4bcec66-b8ef-476f-915c-375f6c71a5d1' where routing id = '0308d658-fdb0-4980-8b8b-9c0274aad190' and objectid = '44737c6e-f051-4acb-9fe5-3cf57fcaedac';
