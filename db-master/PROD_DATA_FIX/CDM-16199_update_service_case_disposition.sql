/*
   Issue Description: CDM-16199
   Category/ Module  :  Case showing as Closed in Client search
   Root cause: dispositioncode column in not updated
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

UPDATE servicecase 
SET dispositioncode = 'Open', updatedby = 'CDM-16199',updatedon = now() 
WHERE servicecaseid = '38222ecb-4b91-4f25-ba1d-3cd5b1eed48b';