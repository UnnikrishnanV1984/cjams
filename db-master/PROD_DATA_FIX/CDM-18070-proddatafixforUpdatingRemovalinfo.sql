
/*
   Issue Description: CDM-18070
   Category/ Module  : Updating Removal info for CLosed case
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
	set exitdate = '2021-09-30 11:00:00', 
		removalexitreason = 'EMANIND', 
		updatedby = 'CDM-18070', 
		updatedon = now() 
	where intakeservreqchildremovalid = 'b99a02f8-840b-454d-a9f8-dc6096eb93fe';

	update personprogramarea set enddate = '2021-09-30 11:00:00', updatedby = 'CDM-18070', updatedon = now() 
	where personprogramid = '3e350cee-31b6-4f8e-9946-e16683516cb5';
