/*
   Issue Description: CDM-16291
   Category/ Module  :  Update removal information
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- NYD
update intakeservreqchildremoval set removaltypekey = 'JD', updatedby = 'CDM-16291', updatedon = now() where removalid = '250926';