/* Issue Description:CDM-17314- removal end date closure
   Category/ Module  :  user wants to update
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update intakeservreqchildremoval 
	set exitdate = '2021-08-04 00:00:00', 
		removalexitreason = 'RUF', 
		updatedby = 'CDM-17314', 
		updatedon = now() 
	where intakeservreqchildremovalid = '8f83267b-aaad-46fb-8a9c-8b7b2700460d';

	update personprogramarea set enddate = '2021-08-04 00:00:00', updatedby = 'CDM-17314', updatedon = now() 
	where personprogramid = '449a10b4-9284-4f27-bebe-c296c8366502';