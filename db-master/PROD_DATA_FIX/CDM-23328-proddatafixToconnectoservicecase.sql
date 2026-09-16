/*
   Issue Description: CDM-23328
   Category/ Module  : Prod data fix to connect correct removal to service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- a436c73e-fa2e-4454-94dc-34067880ecbd
update intakeservreqchildremoval set servicecaseid = 'c961a3b6-97f3-412f-8531-f04971b7d215', updatedby = 'CDM-23328', updatedon = now()
where intakeservreqchildremovalid = '517cbb08-561f-4682-a303-f145f6fe2eef';

-- a436c73e-fa2e-4454-94dc-34067880ecbd ,3098231
update personprogramarea set objectid = 'c961a3b6-97f3-412f-8531-f04971b7d215',entityid = '3232416', updatedby = 'CDM-23328', updatedon = now() 
where personprogramid = 'cbd65402-9c9b-43ba-9c08-cbf45ec59878';