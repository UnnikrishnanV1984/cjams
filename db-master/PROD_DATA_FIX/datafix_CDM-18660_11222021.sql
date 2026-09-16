-- CDM-18660 - Incorrect removal date
/*
-- Issue Description: 
   User Request to change the removal entry date for the child Desira Johnson. 
   The correct date SHOULD BE 11/2/21.
   
-- Case ID: 3148360 - 41cfeed7-716e-42c0-a96a-ce9847bd4470
-- Client ID: 4045365 (DESIRA MARIA	JOHNSON) - 8fad442c-3946-4165-aa05-f446647423e7
-- Removal ID: 253043 - 2021-11-03 To Current - 46c077ab-d3e3-465c-9fc6-7c3e3fe37456

-- Category/ Module: Removal (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 253043
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm 
set rm.removaldate = '2021-11-02 00:00:00',
	rm.updatedby = 'CDM-18660',
	rm.updatedon = now() 
where rm.removalid = 253043
	and rm.activeflag = 1 ;

-- Update OOH
select startdate, enddate, programkey, updatedby, updatedon 
	from personprogramarea  
where personprogramid  = '93f2c4b8-758f-4dae-bbf3-414203f359db'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2021-11-02 00:00:00',
	updatedby = 'CDM-18660',
	updatedon = now()
where personprogramid  = '93f2c4b8-758f-4dae-bbf3-414203f359db'
	and activeflag = 1 ;

-- Update IV-E
select removal_id, start_dt, end_dt, update_ts, update_user_id, delete_sw  
   from tb_client_eligibility
where removal_id = 253043
   and delete_sw = 'N' ;
   
update tb_client_eligibility
set start_dt = '2021-11-02',
	update_ts = now(),
	update_user_id = 'CDM-18660'
where removal_id = 253043
   and delete_sw = 'N' ;
