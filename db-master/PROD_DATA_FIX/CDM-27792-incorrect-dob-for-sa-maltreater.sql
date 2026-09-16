 /*
  Issue Description: CDM-27792
   Category/ Module  :  Change DOB
   Root cause: date of birth is listed wrong need to update dob
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update
    person
set
    dob = '1996-04-06',
    updatedby = 'CDM-27792',
    updatedon = now()
where
    cjamspid = 200932949
    and personid = '8fcd66be-85ae-49cc-baf6-68af5e91c1e5';