--CDM-10758 Incorrect End Date
update placement set enddatetime = '2021-01-14 00:00:00', updatedby = 'CDM-10758', updatedon = now() where placementid = '7935195e-8289-4ede-8d50-c0f668f2608c'; 

update placementrevision set exitdate = '2021-01-14 00:00:00', updatedby = 'CDM-10758', updatedon = now()  where placementrevisionid ='476312a7-3603-4381-8a1e-c7718cce0c6e';

update tb_placement_validation set placement_exit_dt = '2021-01-14 00:00:00', update_ts = now()  where  placement_id = '1559298';
