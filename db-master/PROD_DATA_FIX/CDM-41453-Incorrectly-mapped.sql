/*
  Issue Description: CDM-41453
   Category/ Module: Incorrectly Mapped
   Root cause: Change of county code to DHS Central
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update 
    cjams.teammember 
set 
    teamid='ee4afe64-57d2-4b81-9a17-eabdaac31217', 
    updatedby='CDM-41453', 
    updatedon=now()
WHERE 
    teammemberid = 'c1940f9c-acb9-4f0b-8cb1-7d4195d0dcd0'::uuid
and 
    activeflag = 1;

update
    userprofile
set
    primarycountycd = 3824,
    updatedby = 'CDM-41453',
    updatedon = now()
where
    securityusersid = '7f4468ae-9056-48f8-9fce-370a6bbd1bed';

update
    userprofileaddress
set
    county = 'DHS Central',
    countyid = '11dc65f0-b116-45a9-a07a-8fbe171f0c9d',
    updatedby = 'CDM-41453',
    updatedon = now()
where
    securityusersid = '7f4468ae-9056-48f8-9fce-370a6bbd1bed';