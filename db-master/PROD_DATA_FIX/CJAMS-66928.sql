/*
  Issue Description: CJAMS-66928
   Category/ Module  :  Data fix is needed to remove the Placement validation (2011492,2008299,2004982,2002018,2002017) 
   Root cause: user requested to remove the placement
   Fix provided: data fix has been done to remove the placemnet validations
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_placement_validation
set delete_sw='Y', update_ts = now(), update_user_id = 'CJAMS-66928'  
where placement_validation_id in ('2011492','2008299','2004982','2002018','2002017');