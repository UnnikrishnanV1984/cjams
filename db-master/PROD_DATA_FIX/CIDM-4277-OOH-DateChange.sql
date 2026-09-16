/*
   Issue Description: CIDM-4277
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4875
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update personprogramarea set enddate = '2021-12-17 00:00:00', updatedon = now(), updatedby = 'CIDM-4277'
where personprogramid = 'b0b0c3d6-6aae-4ebd-80b5-18c1ac3a1154';