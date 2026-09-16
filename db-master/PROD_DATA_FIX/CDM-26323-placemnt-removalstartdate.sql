/*
   Issue Description: CDM-26323
   Category/ Module  : child Removal, Placement
   Root cause: 
   Pull request# for code fix:7607
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval set removaldate = '2021-09-28 00:00:00', removaltime = '2021-09-28 22:00:00', updatedby = 'CDM-26323', updatedon = now() where removalid = '252868';

update personprogramarea set startdate = '2021-09-28 00:00:00', updatedby = 'CDM-26323', updatedon = now() where personprogramid = '3ebe294d-ed2d-4d85-89f3-7ddfc7adae5b';

update tb_client_eligibility set start_dt = '2021-09-28',update_user_id ='CDM-26323', update_ts = now() where removal_id = 252868;


update placement set startdatetime = '2021-09-28 00:00:00', updatedon = now(), updatedby = 'CDM-26323' where placementid = '42324acf-accc-4445-8f8d-0469729010ee';


