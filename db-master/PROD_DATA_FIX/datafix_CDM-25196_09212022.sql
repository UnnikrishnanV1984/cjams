-- CDM-25196 - Duplicate removal
/*
-- Issue Description: 
	We need these duplicate removal deleted. 

-- Case ID: 221030018333
-- Client ID: 200949611 (Michael T Conner) - 176ce2c1-fe47-4941-be49-2c09550778dc
-- Delete Duplicate - No Placements 
-- 254217 - 254615	2022-09-01 To Current - 110e650d-78fa-4387-8d4f-1380e9bef730

-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select removalid, removaldate, exitdate, activeflag, updatedby, updatedon
	from intakeservreqchildremoval 
where removalid = 254615
	and personid = '176ce2c1-fe47-4941-be49-2c09550778dc'
	and activeflag = 1 ;
		
update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-25196',
	updatedon = now()
where removalid = 254615
	and personid = '176ce2c1-fe47-4941-be49-2c09550778dc'
	and activeflag = 1 ;
		
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing
where eventcode = 'CHRR'
	and objectid = '110e650d-78fa-4387-8d4f-1380e9bef730'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-25196',
	updatedon = now()	
where eventcode = 'CHRR'
	and objectid = '110e650d-78fa-4387-8d4f-1380e9bef730'
	and activeflag = 1 ;
	
select eligibility_id, eligibility_status_cd, delete_sw, update_ts, update_user_id
	from tb_client_eligibility 
where removal_id = 254615
	and delete_sw = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-25196'
where removal_id = 254615
	and delete_sw = 'N' ;
	
select alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement
where intakeservreqchildremovalid = '110e650d-78fa-4387-8d4f-1380e9bef730'
	and activeflag = 1;
	
update placement
set intakeservreqchildremovalid = '35e1aed2-38cf-42b1-8127-786e14c46ba6',
	updatedby = 'CDM-25196',
	updatedon = now()
where intakeservreqchildremovalid = '110e650d-78fa-4387-8d4f-1380e9bef730'
	and activeflag = 1;
