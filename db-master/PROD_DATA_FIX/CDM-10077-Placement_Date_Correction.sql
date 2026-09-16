--Record-1
update placement set enddatetime = '2020-12-22 00:00:00', updatedby = 'CDM-10077', updatedon = now() where placementid = '4cade380-36e0-4772-9cf0-2edae3ddc897';
update placementrevision set exitdate = '2020-12-22 00:00:00', updatedby = 'CDM-10077', updatedon = now() where placementid = '4cade380-36e0-4772-9cf0-2edae3ddc897'
	and placementrevisionid = 'a8aa456e-1e9f-4ebd-a209-b3822bf5617d';
update tb_placement_validation set placement_exit_dt = '2021-12-22', update_user_id = 'CDM-10077', update_ts = current_timestamp  where  placement_validation_id = '1945428' and placement_id = '1557659';


--Record-2
update placement set enddatetime = '2020-12-22 00:00:00', updatedby = 'CDM-10077', updatedon = now() where placementid = '84ef9df4-8c60-490e-ab1f-f83734cca489';
update placementrevision set exitdate = '2020-12-22 00:00:00', updatedby = 'CDM-10077', updatedon = now() where placementid = '84ef9df4-8c60-490e-ab1f-f83734cca489'
	and placementrevisionid = '3d0dc73f-6262-4eb3-b426-6473d2065d53';
update tb_placement_validation set placement_exit_dt = '2021-12-22', update_user_id = 'CDM-10077', update_ts = current_timestamp  where  placement_validation_id = '1944968' and placement_id = '340626';