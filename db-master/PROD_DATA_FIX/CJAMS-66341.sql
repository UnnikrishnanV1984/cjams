/*
   Issue Description: CJAMS-66341- Old Flex Fund.
   Category/ Module  : Purchase Authorization
   Root cause: Requested to re direct the purchase authorization to BrandiStocksdale
   Fix provided: Data fix is done to redirect to BrandiStocksdale
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set tosecurityusersid='d2757853-26b7-4656-9189-c890ef76cbcb',updatedby='CJAMS-66341',updatedon=now()
WHERE routingid='5a4433eb-cfc2-4fb8-8a55-48ad6e8431bc' and teamid  ='3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a' and activeflag =1;