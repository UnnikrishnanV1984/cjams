/*
   Issue Description: CDM-20379
   Category/ Module  : Permanency plan date changes
   Root cause: user wants to removeold plan to add new plan
   Pull request# for code fix: 4826
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
	update permanencyplan set activeflag = 0, 
    updatedby = 'CDM-20379', updatedon = now() where permanencyplanid = '5b503851-1a7e-44ae-8169-5f49caf714ab';