/*
   Issue Description: CJAMS-58077
   Category/ Module  : Placement
   Root cause: User requested to change the ned date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update placementrevision set exitdate = '2024-12-13 00:00:00',updatedby = 'CDM-58077', updatedon = now()
where placementid = '2ed03afd-b0c2-47fe-badc-4530ef718f2c' 
and placementrevisionid = 'e1eaab24-f407-463b-a082-0664a72ce31c';

update tb_placement_validation
set placement_exit_dt = '2024-12-13'::date,
    update_ts = now(),
    update_user_id = 'CJAMS-58077'
where placement_id = 1676821
    and  delete_sw = 'N' ;
