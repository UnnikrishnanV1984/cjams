 /*
  Issue Description: CJAMS-68137
   Category/ Module:  Person DOB
   Root cause: date of birth is listed wrong need to update dob
   Fix Provided: Data fix has been provided by updating the dob as requested
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


update person
set dob='1983-11-23 00:00:00', updatedby='CJAMS-68137', updatedon=now()
Where personid='042b95e2-ba85-482d-8215-ef0ef46e510c' and cjamspid='204791164' and activeflag=1;