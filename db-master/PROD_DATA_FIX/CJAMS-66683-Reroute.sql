/*
   Issue Description: CJAMS-66683- Unable to deny Service Log sent to Program Manager.
   Category/ Module  : Purchase Authorization
   Root cause: Requested to re direct the purchase authorization to stephanie.cooke1@maryland.gov
   Fix provided: Data fix is done to redirect to stephanie.cooke1@maryland.gov
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set tosecurityusersid='3101f5ad-e192-45d1-9ea3-5e268508f6d9',updatedby='CJAMS-66683',updatedon=now()
WHERE routingid='3d0a0dec-d0d9-4121-b47d-ea1e51338652' and teamid  ='98097a8f-3ecf-4f09-874a-f6681c60df5d' and activeflag =1;