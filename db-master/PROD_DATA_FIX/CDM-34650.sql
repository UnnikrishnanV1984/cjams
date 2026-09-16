 /* 
    Issue Description: CDM-34650
   Category/ Module  : intake
   Root cause: The subsidy agreement was sent twice, usre request to delete duplicate agreement request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update adoptionagreement
set activeflag = 0, 	
	updatedby = 'CDM-34650',
	updatedon = now()
where adoptionagreementid  = '1200e229-3e7d-41ae-9d53-604e4a52d103'
	and activeflag = 1 ;
	

update routing
set activeflag = 0, 	
	updatedby = 'CDM-34650',
	updatedon = now()
where objectid = '1200e229-3e7d-41ae-9d53-604e4a52d103'
	and eventcode = 'ASAR'
	and activeflag = 1 ;