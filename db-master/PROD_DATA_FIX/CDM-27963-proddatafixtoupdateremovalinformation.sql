/*
   Issue Description: CDM-27963
   Category/ Module  : Prod data fix to removal end date update
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update 	Intakeservreqchildremoval
set 	parent2comments = 'Melissa Magness (mom) has sole legal and physical custody of the child',
        parent1id = '1489948',
		isbothparentssigned = 2,
		updatedby = 'CDM-27963',
		updatedon = now()
where removalid = '180883'