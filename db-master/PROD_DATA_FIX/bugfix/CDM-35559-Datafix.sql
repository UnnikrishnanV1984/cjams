/*
   Issue Description: CDM-35559
   Category/ Module  : Permanency Plan
   Root cause: Unable to break the link, The subsidy agreement was sent twice, usre request to delete duplicate agreement request
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/
update adoptionagreement
set activeflag = 0,	
updatedby = 'CDM-35559',
updatedon = now()
where adoptionagreementid = '13dcb258-91f7-4200-9291-c36ca432e0d4'
and activeflag = 1;
	

update routing
set activeflag = 0, 	
updatedby = 'CDM-35559',
updatedon = now()
where objectid = '13dcb258-91f7-4200-9291-c36ca432e0d4'
and eventcode = 'ASAR'
and activeflag = 1 ;