/*
   Issue Description: CDM-13943
   Category/ Module  :  child welfare 
   Root cause: placement wrongly entered end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error wrong data issue. 
*/

update placement 
set 
enddatetime = '2021-03-22 00:00:00',
endtime = '08:30',
updatedon = now(),
updatedby = 'CDM-13943'
where placementid = 'ea2ec505-f687-4a9b-b92c-58721e515849';

update tb_placement_validation 
set
placement_exit_dt = '2021-03-22',
update_ts = now(),
update_user_id = 'CDM-13943'
where placement_id = '332848';

update placementrevision 
set 
exitdate = '2021-03-22 00:00:00',
exittime = '08:30',
updatedon = now(),
updatedby = 'CDM-13943'
where placementid = 'ea2ec505-f687-4a9b-b92c-58721e515849';