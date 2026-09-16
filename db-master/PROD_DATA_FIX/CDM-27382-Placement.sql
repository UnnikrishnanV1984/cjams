/*
   Issue Description: CDM-27382
   Category/ Module  :  Removing placement end date
   Root cause: user requeseted to update placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.placement set enddatetime = null, updatedby ='CDM-27382', updatedon = now()

where placementid ='9aa1eac2-6e31-403c-bbda-0481d69108b1';


update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-27382' 

where placementid ='9aa1eac2-6e31-403c-bbda-0481d69108b1';


update tb_placement_validation set placement_exit_dt = null, 
update_user_id = 'CDM-27382', update_ts = now() where placement_id  = 332335;