/*
   Issue Description: CDM-21762
   Category/ Module: person tab
   Root cause: user wants to remove person and making chnahe in primary care giver form
   Pull request# for code fix:5573 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


update intakeservreqchildremoval set primarycaregiveractorid = '0fa74c28-f930-4284-a2ff-34037c1a0394', updatedby = 'CDM-21762', updatedon = now()
where intakeservreqchildremovalid = 'f84bd541-918c-4d28-bb6c-1fc7cf3302d2';

update cjams.actor 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-21762'
where actorid = 'ee833a11-6dd4-41be-bc9d-b8025c0b66e9';

update cjams.intakeservicerequestactor i 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-21762'
where intakeservicerequestactorid = 'cdc343da-bc41-4d54-9144-8c7fa826c964';

update cjams.personrole p  
set activeflag = 0, updatedon = now(), updatedby = 'CDM-21762'
where personroleid = '3a4ec588-4d53-407e-b1b7-2807808dd034';

update cjams.actorrelationship a2 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-21762'
where intakeservicerequestactorid = 'cdc343da-bc41-4d54-9144-8c7fa826c964';