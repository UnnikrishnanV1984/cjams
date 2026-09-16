-- CDM-17795 - Duplicate client with removal
/*
-- Issue Description: 
   user request to delete the Invalid Removal of the duplicate client.  
    
-- Case ID: 3113399
-- Client ID: 200022091 (KEYON Duplicate FORD) - 387fc1f8-2ad0-4cdb-bf15-f9092e894c04
-- Removal ID: 251836 - 2021-04-03 To 2021-04-04 - ac4f7a08-4d19-4131-8029-ef9e79cadeaa


-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 251836
	and rm.personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CDM-17795',
	rm.updatedon = now() 		
where rm.removalid = 251836
	and rm.personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04' 
	and rm.activeflag = 1 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0; 

select * 
	from routing ro 
where ro.eventcode = 'CHRR'
	and ro.objectid = 'ac4f7a08-4d19-4131-8029-ef9e79cadeaa'
	and ro.activeflag = 1 
		and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid::character varying = ro.objectid
			and pl.activeflag = 1
		) = 0; 

update routing ro
set activeflag = 0,
	updatedby = 'CDM-17795',
	updatedon = now()
where ro.eventcode = 'CHRR'
	and ro.objectid = 'ac4f7a08-4d19-4131-8029-ef9e79cadeaa'
	and ro.activeflag = 1 
		and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid::character varying = ro.objectid
			and pl.activeflag = 1
		) = 0; 


select programkey, startdate, enddate, activeflag, updatedby, updatedon
	from personprogramarea 
where personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
	and personprogramid  = '6c19ae4f-4dcc-466d-92c2-547a75fa755f'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-17795',
	updatedon = now()
where personid = '387fc1f8-2ad0-4cdb-bf15-f9092e894c04'
	and personprogramid  = '6c19ae4f-4dcc-466d-92c2-547a75fa755f'
	and programkey = 'OOH'
	and activeflag = 1 ;
	
select eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw 
	from tb_client_eligibility 
where removal_id = 251836
	and delete_sw  = 'N' ;	

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-17795',
	update_ts = now()
where removal_id = 251836
	and delete_sw  = 'N' ;	


-- OOH & IV-E updates missed in CDM-17794
-- Case ID: 211030008142
-- Client ID: 200775142	(Sumiyha Duplicate Avery) - 86556655-86e1-4dce-b342-248263653f24
-- Removal ID: 252247 - 2021-06-21 To 2021-06-21 - 5d07e975-408e-4001-85ab-1267b93b22c1

select programkey, startdate, enddate, activeflag, updatedby, updatedon, * 
	from personprogramarea
where personid = '86556655-86e1-4dce-b342-248263653f24'
	and personprogramid = '3ec083d9-7004-4fc7-bbba-33aa3182b8fd'
	and programkey = 'OOH'
	and activeflag = 1 ;

update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-17794',
	updatedon = now()
where personid = '86556655-86e1-4dce-b342-248263653f24'
	and personprogramid = '3ec083d9-7004-4fc7-bbba-33aa3182b8fd'
	and programkey = 'OOH'
	and activeflag = 1 ;

select eligibility_id, client_id, case_id, eligibility_status_cd, update_ts, update_user_id, delete_sw 
	from tb_client_eligibility 
where removal_id = 252247
	and delete_sw  = 'N' ;	

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-17794',
	update_ts = now()
where removal_id = 252247
	and delete_sw  = 'N' ;	

