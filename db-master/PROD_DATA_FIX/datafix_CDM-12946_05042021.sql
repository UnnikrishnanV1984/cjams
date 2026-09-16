-- CDM-12946 - Placement Validation Error
/*
-- Issue Description: 
   There are monthly placement validation logs from May 1, 2012-July 31, 2020 for 
   client Xijala Veney (client #2978131, case #3155439) that appear until Linda Tutuh's case load.
   
   Case ID: 3155439 - 88382cc1-fc66-47be-a43c-3399445db1d1
   Client ID: 2978131 (XIJALA P	VENEY) - e96de091-d948-456b-9510-bcc01ef4b24f
   Placement ID: 271856  2012-05-01 to 2012-07-12 - 9a67cd31-ef5c-4db4-92fa-c11c52d22535
   Private Organization : 5001581 (KidsPeace National Centers of North America, Inc.)
   CPA Office: 5001585 (KidsPeace CPA - Columbia)
   Contract Program ID: 10104 (420	Xijala Veney non-tfc sibling) - 2005-11-06 to 2012-06-18 
  
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Placement Data Issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement
-- Update Removal ID
select alternateid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where placementid = '9a67cd31-ef5c-4db4-92fa-c11c52d22535'
and activeflag = 1 ;

-- Removal
-- 0de8ab41-5c0e-42c5-9160-d58c1fd4470e - 2008-06-30 to 2013-02-01
update placement
set intakeservreqchildremovalid = '0de8ab41-5c0e-42c5-9160-d58c1fd4470e',
	updatedon = now(), 
	updatedby = 'CDM-12946'
where placementid = '9a67cd31-ef5c-4db4-92fa-c11c52d22535'
and activeflag = 1 ;

-- Delete Placement Validations out of Placement Range
select validation_start_dt, validation_end_dt, validation_status_cd, delete_sw, update_ts, update_user_id 
	from tb_placement_validation  
where placement_id = 271856
	and delete_sw = 'N'
	and placement_validation_id not in (1927974, 1927975, 1927976) ;

update tb_placement_validation  
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-12946'
where placement_id = 271856
	and delete_sw = 'N'
	and placement_validation_id not in (1927974, 1927975, 1927976) ;

