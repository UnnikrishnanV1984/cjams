
/*
   Issue Description: CDM-15546
   Category/ Module  :  TPR details missing for Adoption case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update legalcustody set personid = 'f520f3b2-c851-443b-9c40-fbb7e17e17fc' , updatedby = 'CDM-15546',updatedon = now()
where legalcustodyid = '8c249338-c58e-4628-9aca-80cc4f958974';
