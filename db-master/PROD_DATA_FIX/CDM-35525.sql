/*
   Issue Description: CDM-35525
   Category/ Module  : Prod data fix to remove the investigation findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-35525'	
where investigationallegationmaltreatorsid = 'c96e0550-c43e-48e1-b625-18b0eafa0182'
	and activeflag = 1 ;