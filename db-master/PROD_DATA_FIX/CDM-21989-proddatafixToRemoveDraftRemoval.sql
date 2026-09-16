
/*
   Issue Description: CDM-21989
   Category/ Module  : Prod data fix To remove draft Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-21989', updatedon = now() 
where intakeservreqchildremovalid = '60932985-a1aa-4181-ad56-b8fcadd42e61';
