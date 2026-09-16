/* Issue Description:CDM-15497 - unable to close case due to extra maltreator
   Category/ Module  :  investigation Finding data
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a corrupted data issue. Only a data fix is available
*/
update investigationallegation
set activeflag = 0,
updatedby = 'CDM-15497',
updatedon = now()
where investigationallegationid = 'b150b82b-7f75-4d9d-9253-7f326e6b2730';