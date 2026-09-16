/* Issue Description:CDM-15497 - unable to close case due to extra maltreator
   Category/ Module  :  investigation Finding data
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a corrupted data issue. Only a data fix is available
*/

update 
allegation a 
set activeflag = 1,
updatedby = 'CDM-15497',
updatedon = now()
where allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';