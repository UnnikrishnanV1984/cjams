/*
   Issue Description: CDM-34836
   Category/ Module  : Permanency plan
   Root cause: unable to  break the link due to duplicate subsidy agreement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-34836',
	updatedon = now()
where adoptionagreementid  = '57e046ee-2cca-4fa4-a821-df05bc970d72'
	and activeflag = 1 ;
	

update routing
set activeflag = 0, 	
	updatedby = 'CDM-34836',
	updatedon = now()
where objectid = '57e046ee-2cca-4fa4-a821-df05bc970d72'
	and eventcode = 'ASAR'
	and activeflag = 1 ;