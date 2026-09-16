
/*
   Issue Description: CDM-21101
   Category/ Module  : Adoption Decision change
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- null YES 
update tb_ive_adoption_audit tiaa set neitheranappnornonappchildfortitleivepurposes = 'YES',adoptionapplicable = null, applicableandnonapplicable = null ,adoptionnonapplicable = null, updatedby = 'CDM-21101', updatedon = now() where adoptionauditid in ('3621','3453','3451');
