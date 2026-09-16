/*
   Issue Description: CDM-23537
   Category/ Module  : Prod data fix to remove ACA and disclosure checklist
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionapplicabilityinfo set activeflag = 0,updatedby = 'CDM-23537', updatedon= now()
where adoptionapplicabilityid = '03c37ff9-99ae-4fcf-ba17-1d03da5a2592' and activeflag = 1;

update adoptionchecklist set activeflag = 0, updatedon = now(), updatedby = 'CDM-23537'
where adoptionplanningid = '7f02ea60-2b85-40df-8ab4-22063749af29' and activeflag = 1;