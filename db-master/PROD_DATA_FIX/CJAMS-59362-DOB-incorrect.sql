/*
  Issue Description: CJAMS-59362
   Category/ Module  :  Change DOB
   Root cause: User Error and Completed case, date of birth is listed wrong need to update dob
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update
    person
set
    dob = '1991-10-02',
    updatedby = 'CJAMS-59362',
    updatedon = now()
where
    cjamspid = 204077798
    and personid = '7f8f8207-1e70-427d-9cdc-466f13f47b31';