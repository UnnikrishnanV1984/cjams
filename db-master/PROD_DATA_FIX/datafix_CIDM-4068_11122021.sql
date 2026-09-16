-- CIDM-4068 - Placement structure updated as "Treatment Foster Care (Private)
/*
-- Issue Description: 
   Private Providers Contract Programs with "Treatment Foster Care" (Service ID: 12) as a Placement Structure.

--   Datafix to update the Placement structure as "Treatment Foster Care (Private)" (Service ID: 78).
-- Current Placement Structure: 76	Residential Treatment Centers
-- New Placement Structure: 14	Residential Group Homes 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User Error - Wrong placement structure was selected under the Provider Contract Program 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Payments 
select payment_id, payment_detail_id, create_ts, draft_service_id, final_service_id,
	update_ts, update_user_id
from tb_payment_detail
where delete_sw = 'N'
	and ( draft_service_id = 12 or final_service_id = 12 )
	and placement_id 
		in ( select alternateid
				from placement
			 where contractprogramid is not null
				and service_id = 12
				and activeflag = 1
			) ;
			
update tb_payment_detail
set draft_service_id = (case when draft_service_id is not null then 78 else null end),
	final_service_id = (case when final_service_id is not null then 78 else null end),
	update_ts = now(),
	update_user_id = 'CIDM-4068'
where delete_sw = 'N'
	and ( draft_service_id = 12 or final_service_id = 12 )
	and placement_id 
		in ( select alternateid
				from placement
			 where contractprogramid is not null
				and service_id = 12
				and activeflag = 1
			) ;
	
-- Update Placement Structure
-- Service ID: 12 (Treatment Foster Care)
select alternateid, altproviderid, placementtypekey, contractprogramid, service_id, 
	startdatetime, enddatetime, isvoided, updatedby, updatedon 
from placement
where contractprogramid is not null
	and service_id = 12
	and activeflag = 1
order by contractprogramid ;

-- Service ID: 78 (Treatment Foster Care (Private))
update placement 
set service_id = 78, 
	updatedby = 'CIDM-4068',
	updatedon = now()
where contractprogramid is not null
	and service_id = 12
	and activeflag = 1 ;
