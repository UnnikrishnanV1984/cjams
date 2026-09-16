-- CIDM-661 - Placement validations not created
-- Datafix to upadte to update provider_organization_id as 5001618 for Placement ID: 340726
-- And to generate missing Placement Validations

-- Placement
-- Before 
select altproviderid, contractprogramid, providerorganizationid, updatedby, updatedon
	from placement 
where alternateid = 340726
	and activeflag = 1 ;

-- Update
update placement
	set providerorganizationid = 5001618,
		updatedby = 'CIDM-661-2',
		updatedon = now()	
where alternateid = 340726
	and activeflag = 1 ;
																 
		
--After
select altproviderid, contractprogramid, providerorganizationid, updatedby, updatedon
	from placement 
where alternateid = 340726
	and activeflag = 1 ;
	
-- Placement Validations	
-- Before
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id, delete_sw 
	from tb_placement_validation 
where placement_validation_id in  (1930886, 1923718, 1927338 ) ;

-- Update
Update tb_placement_validation
set validation_status_cd = null,
update_user_id = 'CIDM-661-2',
update_ts = now()
where placement_validation_id in (1928124, 1928123, 945944 )
and delete_sw = 'N';

-- After
select placement_id, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id, delete_sw 
	from tb_placement_validation
where placement_validation_id in  (1930886, 1923718, 1927338 ) ;
