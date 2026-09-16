
/*
   Issue Description: CDM-15711
   Category/ Module  :  Update CPA end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placementcpahomes set exitdt = '2021-02-15 10:00:00',exittm = '2021-02-15 10:00:00', updatets = now(), updateuserid = 'CDM-15711' where placementcpahomeid = '4df0de2d-746b-4b76-9676-24adec4683b4';
update tb_placement_cpa_homes set exit_dt = '2021-02-15 10:00:00', exit_tm = '2021-02-15 10:00:00', update_ts = now(), update_user_id = 'CDM-15711' where  placement_cpa_home_id = '43202';
