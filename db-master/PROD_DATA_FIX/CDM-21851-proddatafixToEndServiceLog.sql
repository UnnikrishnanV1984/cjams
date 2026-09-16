
/*
   Issue Description: CDM-21851
   Category/ Module  : Prod data fix To remove the Gap Application
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_service_log set end_dt = '2021-12-10', update_ts = now(),update_user_id = 'CDM-21851' where service_log_id = '2012609';
update guardianship set guardianoneproviderid = '5093334',updatedon = now(), updatedby = 'CDM-21851'
where gapid = 'ec764418-c8a3-4161-bcc2-a566fd12b533';