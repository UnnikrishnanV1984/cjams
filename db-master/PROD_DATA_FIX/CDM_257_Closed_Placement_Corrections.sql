-- Provider Contract Program update

update placement
	set contractprogramid = 2817, updatedon = now()
where placementid = 'fa8737a7-fdd7-4cdb-88ea-3e146cc32f40'
and activeflag = 1;

update tb_placement_validation
	set update_ts = now()
where placement_id = 336203
and delete_sw = 'N';
