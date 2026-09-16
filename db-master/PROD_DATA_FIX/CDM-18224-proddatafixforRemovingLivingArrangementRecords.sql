
/*
   Issue Description: CDM-18224
   Category/ Module  : Removing Duplicated living arrangment records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placement set activeflag = 0, updatedby = 'CDM-18224', updatedon = now() where placementid in ('489fa58b-2b3c-4b75-91c9-088937111f23','a211f59d-7951-46f6-9fd3-2b71f9a82a99');
update livingarrangement set activeflag = 0, updatedby = 'CDM-18224', updatedon = now() where placementid in ('489fa58b-2b3c-4b75-91c9-088937111f23','a211f59d-7951-46f6-9fd3-2b71f9a82a99');
