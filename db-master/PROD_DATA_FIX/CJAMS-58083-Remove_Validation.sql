/*
  Issue Description: CJAMS-58083
   Category/ Module  :  Data fix is needed to remove the Placement validation (2192769) 
   Root cause: user requested to remove the placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_placement_validation
set delete_sw='Y', update_ts = now(), update_user_id = 'CJAMS-58083'  
where placement_validation_id in ('2200506','2201019');