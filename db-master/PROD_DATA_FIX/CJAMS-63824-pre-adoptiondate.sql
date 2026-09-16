/*
Issue: CJAMS-63824 Unable to add person
Category/Module: Person profile
Root cause: User is unable to add the person Derek Pindell to an intake (DOB 1/11/1982) as he was adopted and the age at adoption is not entered. 
            Data fix needed to add the adoption previous date with 10/10/1990 for client ID# 1365456 (Derek A Pindell)
Fix provided:  Data fix needed to add the adoption previous date with 10/10/1990 for client ID# 1365456 (Derek A Pindell)
Data/Code fix ticket#: CJAMS-63824
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a data entry error and data fix should resolve it.
*/

update person
set preadoptiondate = '1990-10-10',
    updatedon = now(),
    updatedby = 'CJAMS-63824'
where personid = '5e98bc5d-462d-4ea0-a4d4-c6b5261ce6ab'
and activeflag =1;  