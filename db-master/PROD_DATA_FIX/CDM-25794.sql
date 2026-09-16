
/*
   Issue Description: CDM-25794
   Category/ Module  : Legislative 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/





update cjams.legislative
set islegislativereporting = '',
	isdataentrynotes = null,
	updatedby = 'CDM-25794',
	updatedon = now()
where  intakeserviceid = 'b05c2e5a-4bbd-4bdc-9b15-8fee0f87fdb1';