-- CDM-27109 - Closed case removal end date entry
/*
-- Issue Description: 
   User reuest to remove the duplicate Removal

-- Case ID: 221030014851
-- Client ID: 200882037 (Luka Galloway) - ff42625b-eb29-4d1e-82ec-d392b83d2cff
-- Removal ID: 253711 - 2022-03-16 To Current - cfa4a605-611f-4fd2-bce0-edc8a41bb7a9

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove the Duplicate Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253711
	and rm.personid = 'ff42625b-eb29-4d1e-82ec-d392b83d2cff'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
update intakeservreqchildremoval rm
set activeflag = 0,
	updatedby = 'CDM-27109',
	updatedon = now()
where rm.removalid = 253711
	and rm.personid = 'ff42625b-eb29-4d1e-82ec-d392b83d2cff'
	and rm.activeflag = 1
	/*
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0
	*/	 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'cfa4a605-611f-4fd2-bce0-edc8a41bb7a9'
	and ro.activeflag = 1 ;	
	
update routing ro
set activeflag = 0,
	updatedby = 'CDM-27109',
	updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.objectid  = 'cfa4a605-611f-4fd2-bce0-edc8a41bb7a9'
	and ro.activeflag = 1 ;
	
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 253711
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27109'
where removal_id = 253711
	and delete_sw = 'N' ;	

-- No duplcate OOH and No Associated Placements