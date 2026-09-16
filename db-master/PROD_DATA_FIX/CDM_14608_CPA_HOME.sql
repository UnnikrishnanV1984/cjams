/*
   Issue Description: CDM-14608
   Category/ Module  :  Case-worker service log screen 
   Root cause: user requeseted to end date the cpa home request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placementcpahomes
set exitdt = '2021-03-13T19:00:00.000Z', exittm = '2021-03-13T15:00:00.000Z', updateuserid = 'CDM-14608', updatets = now() 
where placementcpahomeid = '67c85e30-f414-4526-87bf-113ea287a0cd';
