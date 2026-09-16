/*
   Issue Description: CDM-22578
   Category/ Module  : approval inbox
   Root cause: user wants to delete case which is approved and shows as pending
   Pull request# for code fix: 6688
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-22578',
    updatedon = now()
where routingid = '708c1da7-bbe7-4ff6-a1f8-35012d96a4d4';