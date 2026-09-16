/*
   Issue Description: CDM-19498
   Category/ Module  : connect case to intake
   Root cause: user wants to connect case to intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select * 
from cjams.createservicecase(
'4c226631-16ea-4b29-9af6-ca7b2eea8aec',
'39ba866a-c4a8-4261-82c8-feada14a4099', 
0, 
'6e0584d0-90b0-4d46-87ce-004e6b740419', 
'',
'intake');

update intakeservicerequestdispositioncode 
set intakeserreqstatustypeid  = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-19498', updatedon = now() 
where intakeserviceid = '4c226631-16ea-4b29-9af6-ca7b2eea8aec';