/*
   Issue Description: CDM-29113
   Category/ Module  : add placement start date
   Root cause: user requeseted to change placement start date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement 
set startdatetime ='2023-02-28 00:00:00', updatedon =now(), updatedby ='CDM-29113'
where placementid ='e96ffdc6-bea9-4bfe-8dd1-93afc581dc8d';

update placementrevision 
set entrydate ='2023-02-28 00:00:00', updatedon =now(), updatedby ='CDM-29113'
where placementid ='e96ffdc6-bea9-4bfe-8dd1-93afc581dc8d';

update tb_placement_validation 
set placement_entry_dt ='2023-02-28 00:00:00', update_ts =current_timestamp, update_user_id ='CDM-29113'
where placement_id =1570795;