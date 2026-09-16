
/*
   Issue Description: CDM-17849
   Category/ Module  :  Child Removal Fix
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-17849', updatedon = now() where intakeservreqchildremovalid = '9430e2d8-b5a3-4629-b2e0-df8c19cd8ba0';
