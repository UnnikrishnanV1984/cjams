update placementcpahomes
set exitdt = '2021-03-31 15:00:00',
	exittm = '2021-03-31 15:00',updatets = now(),	updateuserid = 'CDM-14608'
where placementcpahomeid = '67c85e30-f414-4526-87bf-113ea287a0cd' and activeflag = 1 ;

-- select * from tb_placement_validation tpv where placement_id = 337883;