/*
   Issue Description: CDM-26354
   Category/ Module  : Prod data fix to update SDM details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update Intakeservicerequestsdm 
set isneggn_inadequatesupervision = true, updatedby = 'CDM-26354', updatedon = now() 
where intakeserviceid in ('58b926d3-62a8-48cc-9d78-b0168c8dcb1f','de4e6275-9f78-4562-80ba-6159096eac45'); 
