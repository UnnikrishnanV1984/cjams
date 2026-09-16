/*
   Issue Description: CDM-27979
   Category/ Module  : Prod data fix to update servicecaseid which was null, and it was preventing from case closure
   Pull request# for code fix: 7664
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update placement set servicecaseid = '5f5b35f1-53a1-4390-8177-b6177ed66a4e',
updatedby ='CDM-27979',
updatedon =now()
where placementid = '87a7cc8d-2667-48b0-8745-e77cf12fd1be';