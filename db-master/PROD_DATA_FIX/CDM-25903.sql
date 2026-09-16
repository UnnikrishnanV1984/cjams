
/*
   Issue Description: CDM-25903
   Category/ Module  : Legislative 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update cjams.legislative
set islegislativereporting = '',
	updatedby = 'CDM-25903',
	updatedon = now()
where  intakeserviceid = '6f4e8ba0-2e3d-46fe-ba99-4ed04db29211';