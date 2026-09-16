/*
   Issue Description: CDM-16063
   Category/ Module  : case plam
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   user is asking to update the exit date with the reason re unification
*/

update intakeservreqchildremoval 
	set exitdate = '2021-02-19 19:00:00', 
		removalexitreason = 'RUF', 
		updatedby = 'CDM-16063', 
		updatedon = now() 
	where intakeservreqchildremovalid = '2386501a-e8b2-4365-b7a8-40dbb6c86d41';