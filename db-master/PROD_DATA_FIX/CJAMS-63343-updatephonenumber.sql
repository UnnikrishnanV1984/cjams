/*
Issue: CJAMS-63343 Personal Number captured
Category/Module: User phone number
Root cause: User phone number is update in sailpoint but not reflecting in cjams DB.
Fix provided:  Data fix has been done to correct the user phone number in CJAMS DB.
               Worker email :  wykeba.barnes1@maryland.gov
               phone number : 443-386-9211
Data/Code fix ticket#: CJAMS-63343
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: It's a Known Sailpoint Integration issue
*/


update userprofilephonenumber
set updatedby='CJAMS-63343', updatedon=now(),phonenumber='443-386-9211'
where securityusersid='6d3744d3-6e27-421b-87ac-ae0c6e652795' and activeflag=1;

