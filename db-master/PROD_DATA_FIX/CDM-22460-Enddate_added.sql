/*
   Issue Description: CDM-22460
   Category/ Module  : End date Added
   Root cause: user wants to add end date
   Pull request# for code fix: 5619
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE  personprogramarea  
set enddate = '2020-03-16',
	updatedby = 'CDM-22460',
	updatedon = now()
where personprogramid  ='e7bca75b-e3d9-4bd7-830f-5c526566ba4f'
	and activeflag = 1;