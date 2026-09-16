/*
   Issue Description: 20506
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4855
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval i set exitdate = '2021-12-05 00:00:00', updatedby = 'CDM-20506',updatedon = now() 
where intakeservreqchildremovalid = '79912cf2-56d8-40ef-a28b-ec176a7aaa78';

update placement set enddatetime = '2021-12-05 00:00:00', updatedby = 'CDM-20506',updatedon = now()
where placementid = 'cf7db165-0e59-43d4-b48d-0c5cb4c7d51e';

update livingarrangement set livingenddate = '2021-12-05 00:00:00', updatedby = 'CDM-20506',updatedon = now()
where placementid = 'cf7db165-0e59-43d4-b48d-0c5cb4c7d51e';