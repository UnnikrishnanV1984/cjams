
/*
   Issue Description: CDM-14861
   Category/ Module  :  Case-worker service log screen 
   Root cause: user requeseted to end date the cpa home request
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placementcpahomes
set exitdt = '2021-02-24T05:00:00.000Z', exittm = '2021-02-24T13:00:00.000Z', updateuserid = 'CDM-14861', updatets = now() 
where placementcpahomeid = '763aa215-5516-4b87-8308-041eecb86ebc';
