/*
Issue: CJAMS-58404 INCORRECT DOB OF MALTREATOR
Category/Module: Person Profile
Root cause: Data entry error in the Date of birth of maltreator Destiny Moise.
            SSA approved and data fix needed to update the client DOB from 10/18/2024 to 02/20/1995
            Client ID: 204008965 (Destiny Moise)
Fix provided:  Data fix has been done to update the DOB of maltreator
Data/Code fix ticket#: CJAMS-58404
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/

update Person
set DOB = '1995-02-20 00:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-58404'
where personid = '97031209-238a-423a-9001-87ce1c01bb92'
and activeflag =1;