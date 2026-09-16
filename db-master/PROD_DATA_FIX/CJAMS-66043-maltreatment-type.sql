/*
  Issue Description:  CJAMS-66043
   Category/ Module  : NA
   Root cause: User request to delete the incorrect record in AR summary tab.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CJAMS-66043',
    updatedon = now()
where
    investigationallegationid = 'aaf1c8aa-f434-4885-be02-592b5d6c2af4'
    and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31' and activeflag = 1;