/*
   Issue Description: CDM-26229
   Category/ Module  : Prod data fix To update POSC approval status
   Pull request# for code fix:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update safecareplan 
set approvalstatus = null, 
	updatedby = 'CDM-26229',
	updatedon = now()
where safecareplanid = 'dcfec41b-82b6-4117-9811-f954722f8f22';

update routing 
set activeflag = 0, 
	updatedby = 'CDM-26229',
	updatedon = now()
where objectid = 'dcfec41b-82b6-4117-9811-f954722f8f22';
