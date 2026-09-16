/*
   Issue Description: CDM-23488
   Category/ Module  : Prod data fix to update removalinfo
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--2022-05-19 15:30:00.000
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-23488', updatedon = now() 
where intakeservreqchildremovalid = 'c66712fc-e918-4b39-bdbd-a16fe25077ed';