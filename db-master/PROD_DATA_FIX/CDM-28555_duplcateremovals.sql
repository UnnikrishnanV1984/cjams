/*
   Issue Description: CDM-28555
   Category/ Module  : Duplicate Persons
   Root cause:221020287490:Aaron Ayres shows up twice in Others with same IDs.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update  personrole  set activeflag =0, updatedby= 'CDM-28555', updatedon = now() where personroleid ='2ef797c8-d382-449a-918b-970901b4b06c';