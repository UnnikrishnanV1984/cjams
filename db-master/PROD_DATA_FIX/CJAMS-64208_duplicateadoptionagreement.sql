 /*
  Issue Description: CJAMS-64208
   Category/ Module  :  Permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CJAMS-64208', updatedon = now() 
where adoptionagreementid in ('ab9ecef3-b97c-4d05-96d3-83b505020ace') and activeflag = 1;