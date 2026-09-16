/*
  Issue Description:  CDM-38335
   Category/ Module  :  OOH Program assignment 
   Root cause: Requested to remove the Enddate for OOH assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personprogramarea set enddate = null, updatedby = 'CDM-38335'  where personprogramid = '4c602286-a79c-4848-b54b-bf06059f1077'
and personid='87699d03-df9c-46ca-ae65-a4935386cd22' and activeflag=1;