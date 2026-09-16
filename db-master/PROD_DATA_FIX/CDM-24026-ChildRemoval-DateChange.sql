/*
   Issue Description: CDM-24026
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5941
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval 
set exitdate = '2021-09-07 00:00:00', 
    updatedby = 'CDM-24026', 
    updatedon = now() 
where intakeservreqchildremovalid = '99089081-b8f2-4964-a1e8-5f14ee95ecf6';

update personprogramarea p 
set enddate = '2021-09-07 00:00:00', updatedby = 'CDM-24026', updatedon = now()  
where personprogramid = 'a1b93e95-6041-4d14-a1eb-414eae032e97';