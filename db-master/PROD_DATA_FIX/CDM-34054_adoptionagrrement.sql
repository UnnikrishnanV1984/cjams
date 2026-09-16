 /*
  Issue Description: CDM-34054
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CDM-34054', updatedon = now() 
where adoptionagreementid in ('10d07974-da7b-4858-b361-d78423c4b3b2');