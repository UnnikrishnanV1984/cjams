/*
   Issue Description: CDM-21056
   Category/ Module  : Placement
   Root cause: user wants to add placement for child transferred from another case 
   Pull request# for code fix: 5045
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update  intakeservreqchildremoval
set servicecaseid = '2f210d84-9657-406a-b9f7-ba4e1c2863c7', updatedby = 'CDM-21056', updatedon = now()
where intakeservreqchildremovalid in ('6bced2cb-c61e-42a7-9550-cc150f3be10b', '4099980a-ae77-42f4-ba23-e44772c906b4');
