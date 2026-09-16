-- CIDM-8126 - Fix for 10/30 E&E rejection - CJAMS outbound Batch # 607
/*
-- Issue Description: 
   The E&E rejection for the below client for whom the Foster Care IV-E Eligibility start date is Null.
   INVALID TRANSACTION_DATE error
   
-- Client ID: 200901971	(Taylor LaMonica) - e8c282ba-8dd2-4a1a-817a-999e83819e32	
-- CIS Client ID: 463063982
	
-- Category/ Module: CJAMS- E&E Interface
-- Root cause: Data Issue (IV-E Eligibility start date is Null)
-- Fix Provided: Generic datafix script has been promoted to update Eligibility start/end dates to match with the Child removal start/end dates.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Generic script to update Eligibility dates 
select ce.eligibility_id, 
	ce.removal_id,  
	ce.client_id, 
	ce.start_dt,
	ce.end_dt, 
	ce.update_ts,
	ce.update_user_id,
	(	select rm.removaldate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	) as removal_start_date,
	(	select rm.exitdate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	) as removal_end_date	
from tb_client_eligibility ce
where ce.delete_sw  = 'N'
	and btrim(ce.eligibility_type_cd) = '2931'
	and ce.start_dt is null
	and ( select count(*) 
			from intakeservreqchildremoval rm
		  where rm.removalid = ce.removal_id
		  and rm.removaldate is not null
		) > 0 ;


update tb_client_eligibility ce
set start_dt	=
	(	select rm.removaldate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	),
	end_dt =
		(	select rm.exitdate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	),
	update_ts = now(),
	update_user_id = 'CIDM-8126'
where ce.delete_sw  = 'N'
	and btrim(ce.eligibility_type_cd) = '2931'
	and ce.start_dt is null
	and ( select count(*) 
			from intakeservreqchildremoval rm
		  where rm.removalid = ce.removal_id
		  and rm.removaldate is not null
		) > 0 ;
