-- 2020-01-30 00:00:00
update placement set enddatetime = '2021-06-02 00:00:00', updatedby = 'CDM-14423', updatedon = now() where placementid = '8dba236a-42c0-47e8-979e-6ebe734607d6';
update placementrevision set exitdate = '2021-06-02 00:00:00', updatedby = 'CDM-14423', updatedon = now() where placementid = '84ef9df4-8c60-490e-ab1f-f83734cca489'
	and placementrevisionid = 'c1e7f5bc-7c3f-4119-87f3-d9d2be5ff54b';
update tb_placement_validation set placement_exit_dt = '2021-06-02', update_user_id = 'CDM-14423', update_ts = current_timestamp  where  placement_validation_id = '933221';
