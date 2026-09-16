/*
   Issue Description: CDM-20265
   Category/ Module  : Persons missing in persons tab
   Root cause: user wants to add persons (children) 
   Pull request# for code fix: 4812
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update intakeservicerequestactor set isprimary = true, updatedby = 'CDM-20265', updatedon = now()
where  intakeserviceid = 'def3dd27-f30a-4fad-b6ec-0f73a8867681' and personid in (
'46cdad1e-9d13-4f94-be84-b004cef4de9a',
'b7b92a46-f317-45d3-bcba-1dd0fd6df4a6',
'923f90cf-2549-4bb2-b88f-deaef46710cd');
