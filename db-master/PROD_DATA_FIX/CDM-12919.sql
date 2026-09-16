update placement set enddatetime = '2020-11-02 00:00:00', updatedby = 'CDM-12919', updatedon = now() where placementid = '8b70c369-4f11-489c-a383-648acd2030cb';

update placementrevision set exitdate = '2020-11-02 00:00:00', updatedby = 'CDM-12919', updatedon = now() where placementrevisionid  = 'b2dd19de-8a87-4f04-a698-283c2ec02166';

update tb_placement_validation
set placement_exit_dt= '2020-11-02', update_user_id = 'CDM-12919', update_ts = now()
where placement_id = 337562 and delete_sw = 'N';

insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 337562, '2019-10-29', '2020-11-02', 1750, 
		NULL, 'CDM-12919', 'CDM-12919', 'N', '2020-11-01', 
		'2020-11-30', now(), now(), NULL, NULL
	);
