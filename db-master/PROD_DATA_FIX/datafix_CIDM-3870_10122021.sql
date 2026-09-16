-- CIDM-3870 - CARES Rejection CHCR-TRANSACTION-DATE
/*
-- Issue Description: 
   The CARES rejection is for the below client for whom the Foster Care IV-E Eligibility start date is Null.
   CIS Client ID: 433050716 - Client ID: 3660947 (NOAH D MOORE)
   Foster Care IV-E Eligibility dates should always be in sync with the Removal dates, need data fix.
    
	
-- Category/ Module: CJAMS- CARES Interface
-- Root cause: Data Exception (IV-E Eligibility start date is Null)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

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
	and ce.removal_id  = 252757 ;


update tb_client_eligibility ce
set ce.start_dt	=
	(	select rm.removaldate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	),
	ce.end_dt =
		(	select rm.exitdate::date 
			from intakeservreqchildremoval rm
		where rm.removalid = ce.removal_id
	),
	ce.update_ts = now(),
	ce.update_user_id = 'CIDM-3870'
where ce.delete_sw  = 'N'
	and btrim(ce.eligibility_type_cd) = '2931'
	and ce.start_dt is null
	and ce.removal_id = 252757 ;
	