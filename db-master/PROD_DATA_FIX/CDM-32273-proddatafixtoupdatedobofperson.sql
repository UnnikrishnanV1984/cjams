
/*
   Issue Description: CDM-32273
   Category/ Module  :  Person
   Root cause: user asked to delete the pending intake and remove the case connect
    Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 1990-01-01 00:00:00
update person set dob= '1987-08-29 00:00:00',updatedby='CDM-32273',updatedon=now()
where cjamspid = '200972083';