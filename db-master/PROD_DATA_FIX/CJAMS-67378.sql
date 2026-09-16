
/*
Issue: CJAMS error
Category/Module: Person
Root cause: Incorrect date of birth was enterd for the person.
Fix provided: Data fix provided to update the date of birth for the person.
Data/Code fix ticket#: CJAMS-67378
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error, no code fix needed.
*/
update person
set dob='1976-07-05 00:00:00.000',
updatedby='CJAMS-67378',
updatedon=now()
where personid ='12d1560f-8989-4ae3-ae9b-d433cb483f95'
and cjamspid='200977359' and activeflag=1;

--note: In E360 its pending approval from MDM. 
