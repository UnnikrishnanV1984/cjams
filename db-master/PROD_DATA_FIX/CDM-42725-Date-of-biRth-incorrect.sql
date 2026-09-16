 /*
  Issue Description: CDM-42725
   Category/ Module  :  Change DOB
   Root cause: date of birth is listed wrong need to update dob
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update person
set dob = '2002-05-22 00:00:00', updatedby = 'CDM-42725', updatedon = now()
where personid = 'ef0bf6c7-0e6f-4363-a39f-437eb1fbb005' and activeflag = 1;

