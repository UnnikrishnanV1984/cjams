-- CDM-20217 - Pending Child Account Approvals
/*
-- Issue Description: 
   Child Account Disbursements apporval issues (multiple accounts)
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Partial Transaction (data issue)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3377282 (AFATU WAKO) - 96746af1-f12b-4239-b9ea-accf6d9e456f
-- Account ID: 1015879 (Foster Care Youth Saving) 
-- Balacne: $3312.21

-- Update Disbusrment Amount as $3312.21 (old Value $3311.80 diff $0.41)
select client_account_id,  amount, update_ts, update_user_id  
	from tb_child_account_disbursement 
where disbursement_id = 1006625
	and delete_sw = 'N' 
	and funding_approval_status  = '3045';

update tb_child_account_disbursement 
set amount = 3312.21,
	update_ts = now(),
	update_user_id = 'CDM-20217'
where disbursement_id = 1006625
	and delete_sw = 'N' 
	and funding_approval_status  = '3045';

-- Client ID: 3651583 (SAMUEL JACOB	GOMES) - ff7f784f-58d2-43bb-98e6-c4340ec3f58f
-- Account ID: 11322 (Conserved) 
-- Balacne: $$961.00
select routingid, eventcode, remarks, activeflag, updatedby, updatedon 
	from routing  
where objectid = '5881' 
	and routingstatustypeid  = 56
	and eventcode = 'FINALDIS'
	and activeflag = 1 ;
	
update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20217'
where objectid = '5881' 
	and routingstatustypeid  = 56
	and eventcode = 'FINALDIS'
	and activeflag = 1 ;

-- Soft delete 
select routingid, eventcode, remarks, activeflag, updatedby, updatedon 
	from routing  
where objectid = '5881' 
	and eventcode = 'FINALDIS'
	and activeflag = 1 
	and routingid in (  '55c71f5c-0dc1-4c36-8260-d0418a90754a',
						'abedddf5-d555-48a1-bc7c-4ce51b2208fe',
						'b6434850-4fb1-47ce-9948-4a2c153f9e43'
					 );  

update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20217'
where objectid = '5881' 
	and eventcode = 'FINALDIS'
	and activeflag = 1 
	and routingid in (  '55c71f5c-0dc1-4c36-8260-d0418a90754a',
						'abedddf5-d555-48a1-bc7c-4ce51b2208fe',
						'b6434850-4fb1-47ce-9948-4a2c153f9e43'
					 );  


select routingid, eventcode, remarks, tosecurityusersid,  activeflag, updatedby, updatedon 
	from routing  
where objectid = '5881' 
	and eventcode = 'FINALDIS'
	and routingstatustypeid is null
	and activeflag = 1 
	and routingid = 'e0f75256-8cac-4fe9-a12d-3af080d6dba6' ;

update routing	
set tosecurityusersid = '49210800-530c-43cc-bd5c-7d045ba54883', -- patricia.spann@montgomerycountymd.gov
	routingstatustypeid = 57,
	updatedon = now(), 
	updatedby = 'CDM-20217'
where objectid = '5881' 
	and eventcode = 'FINALDIS'
	and routingstatustypeid is null
	and activeflag = 1 
	and routingid = 'e0f75256-8cac-4fe9-a12d-3af080d6dba6' ;


-- Client ID: 4288033 (LARNISE SWINSON) - 54c6f1d0-663c-40b4-9c67-9f43379c30cf
-- Account ID: 1016048 (Dedicated) 
-- Balacne: $0.00 (Closed)
-- Delete Duplicate Disbursement Transaction
select client_id, amount, funding_approval_status, payment_approval_status, delete_sw, update_ts, update_user_id 
	from cjams.tb_child_account_disbursement  
where disbursement_id = 1006405
	and delete_sw  = 'N' ;

update cjams.tb_child_account_disbursement
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-20217'
where disbursement_id = 1006405
	and delete_sw  = 'N' ;
	

select routingid, eventcode, remarks, activeflag, updatedby, updatedon 
	from routing  
where objectid = '1006405' 
	and eventcode = 'FINALDIS'
	and activeflag = 1 
	and routingid = 'b41745fc-bd1d-420f-a1de-19ef9490f9ea' ;  

update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20217'
where objectid = '1006405' 
	and eventcode = 'FINALDIS'
	and activeflag = 1 
	and routingid = 'b41745fc-bd1d-420f-a1de-19ef9490f9ea' ;  


-- Mass update for all remaining hanging on funding disbursements

select r.objectid, r.routingid, r.routingstatustypeid, r.remarks, r.activeflag, r.updatedby, r.updatedon 
from routing r 
where r.routingstatustypeid  = 56
	and r.eventcode = 'FINALDIS'
	and r.activeflag = 1
	and r.tosecurityusersid = '49210800-530c-43cc-bd5c-7d045ba54883' -- patricia.spann@montgomerycountymd.gov
	and (select count(*)
			from routing r2 
		 where r2.objectid = r.objectid 
			and r2.eventcode = 'FINALDIS'
			and r2.routingstatustypeid  = 58
			and r2.activeflag = 1
		 ) > 0	
	and (select count(*) 
		   from tb_child_account_disbursement 
		 where disbursement_id = r.objectid::bigint  
			and delete_sw  = 'N'
			and payment_id > 0	
		) > 0
	order by r.objectid ;

update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20217'
where eventcode = 'FINALDIS'
	and activeflag = 1 
    and routingid in (
		select r.routingid
		from routing r 
		where r.routingstatustypeid  = 56
			and r.eventcode = 'FINALDIS'
			and r.activeflag = 1
			and r.tosecurityusersid = '49210800-530c-43cc-bd5c-7d045ba54883' -- patricia.spann@montgomerycountymd.gov
			and (select count(*)
					from routing r2 
				 where r2.objectid = r.objectid 
					and r2.eventcode = 'FINALDIS'
					and r2.routingstatustypeid  = 58
					and r2.activeflag = 1
				 ) > 0	
			and (select count(*) 
				   from tb_child_account_disbursement 
				 where disbursement_id = r.objectid::bigint  
					and delete_sw  = 'N'
					and payment_id > 0	
				) > 0
			order by r.objectid 
		) ;  