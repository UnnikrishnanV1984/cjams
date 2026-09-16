
/*
   Issue Description: CDM-21211
   Category/ Module  : Adoption Decision change
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- APPROVED
update tb_ive_adoption_audit tiaa set approvalstatus = null, updatedby = 'CDM-21211', updatedon = now() where adoptionauditid in ('3451');
