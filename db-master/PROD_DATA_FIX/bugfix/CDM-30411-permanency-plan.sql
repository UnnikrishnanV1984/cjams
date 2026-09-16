
/*
   Issue Description: CDM-30411
   Category/ Module  : permanencyplan 
   Root cause: user requested remove the permanency plan end date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--------2023-03-29T04:00:00.000Z-------
update
	permanencyplan
set
	enddate = null,
	updatedon = now(),
	updatedby = 'CDM-30411'
where
	permanencyplanid = 'cc4fa912-27ac-4772-9675-7b06e7ba201c';