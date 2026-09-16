/*
  Issue Description: CDM-30963
   Category/ Module  :  permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set activeflag = 0, updatedby = 'CDM-30963', updatedon = now() where 
permanencyplanid='7f6eb4fc-1e38-4f02-8106-93770625e086' and activeflag = 1;