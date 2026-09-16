-- CDM-23905 - Erroneous client on Foster Care milestone report
/*
-- Issue Description: 
   The erroneous ID 200800745 for child Angela Seri continues to appear on our milestones reports

-- Client ID: 200800745	(Angela seri) - 396646ab-5350-43a8-86b5-0d53faee1cd9
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: Deleted duplicate client with active Removal 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to close and delete the removal/OOH/Placement/IV-E of the deleted duplicate client
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 252687
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = removaldate,
	activeflag = 0, 
	updatedby = 'CDM-23905',
	updatedon = now()
where removalid = 252687
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon, activeflag
	from cjams.personprogramarea 
where personprogramid = '0ef98c8e-833b-4fe0-95bb-039afefcdf17' ;

update cjams.personprogramarea 
set enddate = startdate, 
	activeflag = 0, 
	updatedby = 'CDM-23905',
	updatedon = now()
where personprogramid = '0ef98c8e-833b-4fe0-95bb-039afefcdf17' ;
	
select alternateid, altproviderid, startdatetime, enddatetime, activeflag, updatedby, updatedon
	from cjams.placement
where intakeservreqchildremovalid = 'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba'
	and placementid in (	'529fd4e2-b37d-4a88-9607-a2a309ef6320',
							'650a4f01-9bf8-4f10-a328-9bfc1dd83032'
						)
	and activeflag = 1;
	
update cjams.placement 
set enddatetime = startdatetime, 
	activeflag = 0, 
	updatedby = 'CDM-23905',
	updatedon = now()
where intakeservreqchildremovalid = 'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba'
	and placementid in (	'529fd4e2-b37d-4a88-9607-a2a309ef6320',
							'650a4f01-9bf8-4f10-a328-9bfc1dd83032'
						)
	and activeflag = 1;

select alternateid, altproviderid, startdatetime, enddatetime, activeflag, updatedby, updatedon
	from cjams.placement
where intakeservreqchildremovalid = 'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba'
	and placementid = 'dbcf87f4-b99c-40f3-a38a-7f6d942d3734'
	and activeflag = 1;
	
update cjams.placement 
set activeflag = 0, 
	updatedby = 'CDM-23905',
	updatedon = now()
where intakeservreqchildremovalid = 'e5ad23cf-fe8b-4723-8674-d5a6acdf7eba'
	and placementid = 'dbcf87f4-b99c-40f3-a38a-7f6d942d3734'
	and activeflag = 1;
	
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  252687
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = start_dt,
	delete_sw = 'Y',
	update_user_id = 'CDM-23905',
	update_ts = now()
where removal_id =  252687
	and delete_sw = 'N' ;

select client_id, payment_id, payment_detail_id, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id = 3089226
	and payment_detail_id = 4253043
	and delete_sw  = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-23905'
where payment_id = 3089226
	and payment_detail_id = 4253043
	and delete_sw  = 'N' ;
