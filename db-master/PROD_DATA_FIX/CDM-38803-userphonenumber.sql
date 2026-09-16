/*
   Issue Description: CDM-38803 
   Category/ Module  : User Profile
   Root cause: My personal phone number is still showing up in the CJAMS. Please take my personal phone number off and replace it with my work cell. 240-310-2483. This is not the only case that has this issue. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='240-310-2483', updatedby='CDM-38803 ', updatedon=now()
WHERE userprofilephonenumberid='6741b28d-c7a8-4e81-94fa-7c32d7edd4ce' and 
securityusersid='1b22ed17-fee6-4b52-ad10-ece560c9d6d2' and activeflag=1;
