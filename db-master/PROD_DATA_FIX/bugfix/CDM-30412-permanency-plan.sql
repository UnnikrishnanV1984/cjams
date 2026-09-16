
/*
   Issue Description: CDM-30412
   Category/ Module  : permanencyplan 
   Root cause: user requested remove the permanency plan end date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--------2022-12-09T05:00:00.000Z-------
update
	permanencyplan
set
	enddate = null,
	updatedon = now(),
	updatedby = 'CDM-30412'
where
	permanencyplanid = '1dff474a-9830-4f68-9fde-78502197c9af';