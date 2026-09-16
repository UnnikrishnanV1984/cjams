/*
   Issue Description: CDM-21466
   Category/ Module  : Placement
   Root cause: user wants change placement date
   Pull request# for code fix: 5237
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_placement_validation
set placement_exit_dt  = '2022-01-15',
update_user_id  = 'CDM-21466',
update_ts = now()
where placement_id  = 1533890
and delete_sw  = 'N' ;
