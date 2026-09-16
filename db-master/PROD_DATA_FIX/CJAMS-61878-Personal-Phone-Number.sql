/*
-- Issue Description: 
    My personal phone number is showing when I hover over my name at the top of my case. It also is the number that populated into my Service Authorization.      Case - 3307858  
-- Category/ Module: user profile 
-- Root cause: User Request
-- Fix Provided: datafix done to update the personal number with the working phone number.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.userprofilephonenumber
SET phonenumber='2403102490', --3014711134
	updatedby='CJAMS-61878', updatedon=now()
WHERE userprofilephonenumberid='0e532661-afcd-4c1e-b03f-c31bfa43edf0'
and securityusersid='288e289b-af16-487d-b8c9-0e192683cfde' and activeflag=1;