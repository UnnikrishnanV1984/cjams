/*
   Issue Description: CDM-34455
   Category/ Module  : Prod data fix to update the adoption emotional ties
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 92d02094-f8cd-4fd8-94eb-f973979b666b
update adoptionemotional set adoptionplanningid = 'bf7f85f9-ccd5-4c9d-a6e3-d44059006454', updatedby ='CDM-34455', updatedon = now()
where adoptionemotionalid = 'aae76914-4d13-4044-a8ad-da80b7eba57f';