/*
   Issue Description: CDM-20697
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 4913
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update placement p set startdatetime =  '2019-08-13 00:00:00', updatedby = 'CDM-20697', updatedon = now() 
where placementid = '5f3f47a7-032c-4d5f-a1c3-4774b27f58f2';

update tb_placement_validation set placement_entry_dt = '2019-08-13', update_ts = now(), update_user_id = 'CDM-20697'
where placement_id  = 336313
and delete_sw  = 'N' ;

update placementrevision p2 set entrydate = '2019-08-13 00:00:00', updatedby = 'CDM-20697', updatedon = now() 
where placementid = '5f3f47a7-032c-4d5f-a1c3-4774b27f58f2' and entrydate::date = '2019-08-15';