/*
   Issue Description: CDM-22343
   Category/ Module  : Placement
   Root cause: user wants to change the timings for the placement
   Pull request# for code fix: 5732
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update placement 
set endtime = '15:00', updatedon = now(), updatedby = 'CDM-22343'
where placementid = 'd1569b81-92ef-4039-ad35-3de2c663d79e';

update placement 
set starttime = '15:30', updatedon = now(), updatedby = 'CDM-22343'
where placementid = '582d8b6f-a102-4abe-ad1b-ec293499e9cf';	

update placementrevision 
set exittime = '15:00', updatedon = now(), updatedby = 'CDM-22343'
where placementid = 'd1569b81-92ef-4039-ad35-3de2c663d79e' and activeflag = 1;