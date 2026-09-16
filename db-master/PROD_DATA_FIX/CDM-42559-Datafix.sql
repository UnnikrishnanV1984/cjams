/*
  Issue Description:  CDM-42559
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
    updatedby = 'CDM-42559',
    updatedon = now()
where
    investigationallegationid = '0d997522-5490-4c8b-b094-ff94c2a20d22'
    and allegationid = 'e54563a4-b41c-4071-bfc0-fc3d33a052f5';