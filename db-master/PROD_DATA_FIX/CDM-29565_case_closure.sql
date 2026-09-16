/*
   Issue Description: CDM-29565
   Category/ Module  :Case closure
   Root cause: : Duplciates in relationship between alleged victim and alleged maltreator
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update personrole  set activeflag = 0, updatedby ='CDM-29565', updatedon = NOW() where personroleid ='3f1fe7ad-85a3-4533-9ca0-48591120caf6';