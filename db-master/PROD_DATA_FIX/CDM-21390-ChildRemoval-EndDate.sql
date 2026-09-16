
	/*
   Issue Description: CDM-21390
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5146
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix and code fix 
*/


update intakeservreqchildremoval set exitdate = '2022-01-31 09:30:00', removalexitreason = 'GNONREL', 
updatedby = 'CDM-21390', updatedon = now() where intakeservreqchildremovalid = 'd6a787fa-943e-4ae3-ae61-c43fed6054ea';
update intakeservreqchildremoval set exitdate = '2022-01-31 09:30:00', removalexitreason = 'GNONREL', 
updatedby = 'CDM-21390', updatedon = now() where intakeservreqchildremovalid = '0c10b795-5204-4912-aa0e-3e4c76e547ca';
update intakeservreqchildremoval set exitdate = '2020-02-01 09:30:00', removalexitreason = 'GNONREL', 
updatedby = 'CDM-21390', updatedon = now() where intakeservreqchildremovalid = '7417a4d1-9306-4735-92a3-0775278a9209';
