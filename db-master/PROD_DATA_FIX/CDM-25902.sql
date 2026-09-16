
/*
   Issue Description: CDM-25902
   Category/ Module  : Legislative 
   Root cause: user wants to chnage annual date review. 
   Pull request# for code fix: 4673
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update cjams.legislative
set islegislativereporting = '',
	updatedby = 'CDM-25902',
	updatedon = now()
where  intakeserviceid = '1163e7a0-c76f-4d7c-b19d-16b51627bc52';