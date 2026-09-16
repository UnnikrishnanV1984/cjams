/*
   Issue Description: CDM-37365
   Category/ Module  : Permanency plan
   Root cause: unable to  break the link due to duplicate subsidy agreement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-37365',
	updatedon = now()
where adoptionagreementid  = '0bc93ebe-6af9-4845-aa0d-75ba7dd6df52'
	and activeflag = 1 ;
	

update routing
set activeflag = 0, 	
	updatedby = 'CDM-37365',
	updatedon = now()
where objectid = '0bc93ebe-6af9-4845-aa0d-75ba7dd6df52'
	and eventcode = 'ASAR'
	and activeflag = 1 ;