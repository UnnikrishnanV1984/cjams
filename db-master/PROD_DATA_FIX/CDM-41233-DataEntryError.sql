/*
Issue Description: Sarah Hanratty's date of birth is entered wrong. Her dob is 11/17/1980 and system has 1918.
Category/Module: Error
Root cause: Date of birth was entered wrong
Fix provided: DB query to correct the data entry
Data/Code fix ticket#: CDM-41233
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Update date of birth in person
update person
set dob = '1980-11-17 00:00:00', updatedby = 'CDM-41233', updatedon = now()
where personid = 'fa907bd7-f2e1-4fd2-85c4-6c124155d1db' and activeflag = 1;