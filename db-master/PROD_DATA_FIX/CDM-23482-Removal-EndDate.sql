/*
   Issue Description: CDM-23482
   Category/ Module  : Child Removal
   Root cause: user wants to end date removal
   Pull request# for code fix: 5816
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval 
set exitdate = '2022-05-12 00:00:00', 
	updatedby = 'CDM-23482', 
	updatedon = now() 
where intakeservreqchildremovalid = 'de35f997-15cf-4f1a-a30d-90ae06f7067d';