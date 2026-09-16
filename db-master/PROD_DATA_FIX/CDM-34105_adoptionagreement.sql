 /*
  Issue Description: CDM-34105
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CDM-34105', updatedon = now() 
where adoptionagreementid in ('2090ced6-f8f1-42ee-a008-ce8c9eaf179c');