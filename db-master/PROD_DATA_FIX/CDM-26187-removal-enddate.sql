/*
   Issue Description: CDM-26187
   Category/ Module  : 
   Root cause: user wants to remove 
   Pull request# for code fix: 6721
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   user is asking to update the exit date 
*/
update intakeservreqchildremoval 
	set exitdate = '2016-07-12 00:00:00', 
		updatedby = 'CDM-26187', 
		updatedon = now() 
	where intakeservreqchildremovalid = 'b801e519-b973-4468-9fbf-dc2471e46e5b';


   update personprogramarea 
   set enddate = '2016-07-12 00:00:00',
   updatedby = 'CDM-26187', 
	updatedon = now()
   where  personprogramid  = '2024d7e9-fa94-4b7a-8437-df189871dae8';