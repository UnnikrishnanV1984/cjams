/*
Issue: CJAMS-63451 personal phone number appearing on voucher
Category/Module: User phone number
Root cause: User phone number is update in sailpoint but not reflecting in cjams DB.
Fix provided:  Data fix has been done to correct the user phone number in CJAMS DB.
               Worker email :  amy.crowley@maryland.gov
               phone number : 240-609-8064
Data/Code fix ticket#: CJAMS-63451
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: It's a Known Sailpoint Integration issue
*/


update userprofilephonenumber
set updatedby='CJAMS-63451', updatedon=now(),phonenumber='240-609-8064'
where securityusersid='c2d970f4-7099-4239-b161-9463b41867fd' and activeflag=1;