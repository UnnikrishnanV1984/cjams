 /* 
    Issue Description: CDM-34654
   Category/ Module  : intake
   Root cause: The subsidy agreement was sent twice, usre request to delete duplicate agreement request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-34654',
	updatedon = now()
where adoptionagreementid  = '8a38c289-ef21-4bba-a222-0d2ff7b87032'
	and activeflag = 1 ;
	

update routing
set activeflag = 0, 	
	updatedby = 'CDM-34654',
	updatedon = now()
where objectid = '8a38c289-ef21-4bba-a222-0d2ff7b87032'
	and eventcode = 'ASAR'
	and activeflag = 1 ;