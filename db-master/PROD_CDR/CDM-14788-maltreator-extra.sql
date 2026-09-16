/* Issue Description:CDM-14788 - unable to close case due to extra maltreator
   Category/ Module  :  investigation Finding data
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a corrupted data issue. Only a data fix is available
*/
update investigationallegation
set activeflag = 0,
updatedby = 'CDM-14788',
updatedon = now()
where investigationallegationid = 'd0d92fe9-146d-48f9-89c0-c90230f79b3f';