/*
  Issue Description:  CDM-42448
   Category/ Module  : SDM
   Root cause: User request to delete the incorrect Investigation Finding which is marked as Ruled out.
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update
    investigationallegation
set
    activeflag = 0,
    updatedby = 'CDM-42448',
    updatedon = now()
where
    investigationallegationid = '9c5e2315-028f-4e51-96b0-7896e085be8d'
    and allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31';