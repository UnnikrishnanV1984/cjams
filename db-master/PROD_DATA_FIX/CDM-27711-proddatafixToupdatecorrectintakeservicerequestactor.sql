/*
   Issue Description: CDM-27711
   Category/ Module  : Prod data fix to update correct intakeservicerequestactorid
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 591138c7-fecf-4a7b-b512-66b20633169a
update permanencyplan set intakeservicerequestactorid = '3999797a-d872-43cc-8579-4926270f9ae7',updatedby = 'CDM-27711', updatedon = now()
where permanencyplanid = '31bb07da-e914-4353-9a68-3137ed4f72b9';

update gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-27711',
	updatedon = now()
where gaprateid = '1fcaacbe-9c40-4183-a373-696207645134' ;
