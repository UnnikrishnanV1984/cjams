 /*
  Issue Description: CDM-17224
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update adoptionagreement set activeflag = 0, updatedby ='CDM-17224', updatedon = now() where adoptionagreementid = '6f1a48f7-c8ec-400e-bdb2-0e47aeee8faa';
