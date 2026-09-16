 /*
  Issue Description: CIDM-10802
   Category/ Module  :  Permanency plan
   Root cause: Duplicate adoption agreement
   Pull request# for code fix: Code fix will be fixed as part of CDM-44514 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update adoptionagreement set activeflag = 0, updatedby ='CIDM-10802', updatedon = now() 
where adoptionagreementid in ('588e8f92-8c50-4088-b6dc-1fb4502d6bde', '4406112f-f63f-436c-b1df-f69afe8c7314');