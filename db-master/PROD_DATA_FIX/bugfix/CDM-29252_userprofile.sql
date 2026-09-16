/*
   Issue Description: CDM-29252
   Category/ Module  : User Profile
   Root cause: user requested to update the default supervisor(Change already done in sailpoint)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.userprofile
SET supervisorid='58205b9b-de03-443a-b044-640b8140cda6', updatedby='CDM-29252', updatedon=now()
WHERE securityusersid in ('1e94770a-45d5-47d3-b036-4bbaa46c2d86','6693d7c1-3eb1-45dd-b198-90b4edf78b29',
'31d5a57a-7037-4d3c-9215-2b62c87cdde8', 'abbc066a-30c9-4fc4-9e02-8c45ace937cc','09d6aedd-8bd7-4137-a9ef-20126ddeb6e5');
