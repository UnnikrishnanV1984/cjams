/*
   Issue Description: CIDM-10684
   Category/ Module  : Prod data fix to update case closure request
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- e4271184-e42a-4639-88a5-4168eb1814f7
update routing set tosecurityusersid = '1dcf4151-cfa3-461e-80be-b99dbb7a0b06', updatedby= 'CIDM-10684', updatedon = now()
where routingid = '32f6505e-0190-4c24-b1cc-904385da5395' and tosecurityusersid = 'e4271184-e42a-4639-88a5-4168eb1814f7';
