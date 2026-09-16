 /*
  Issue Description: CDM-33512
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CDM-33512', updatedon = now() 
where adoptionagreementid in ('4d71fec7-fb6e-4a80-a956-43963ed81214','a4fba089-2145-4193-8366-dd981860c373');