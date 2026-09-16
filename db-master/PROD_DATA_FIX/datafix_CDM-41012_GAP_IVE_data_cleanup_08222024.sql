-- CDM-41012 - Fiscal Category inconsistent with eligibility decision
/*
-- Issue Description: 
   User error, commingled account is NOT linked to Foster Care Youth Saving Accounts

-- Category/ Module: Account Payable (Finance Management) 
-- Root cause: CJAMS is assigning 71xx code for Eligible Reimbursable clients GAP payments.
-- Title IV-E table is having data issue the IV start date column is null (this date should be GAP Agreement start date). 
-- Fix provided: Datafix has been provided to fix the start & end dates in Title IV-E table.
-- Regression Impacts: TBD
-- Is Code fix Required?: Yes, will be done using the new CIDM.
-- Code fix ticket#: (If Yes)
-- Reason why no related code fix: TBD
*/
	
-- To fix the start & end dates in Title IV-E table (CDM-41012)

-- Remove duplicate gapagreement record
update gapagreement 
set activeflag = 0,
	updatedby = 'CDM-41012',
	updatedon = now()
where gapagreementid = '99414889-2ad8-43f1-9118-aedb27d8f8d3'
	and activeflag = 1;


update tb_client_eligibility ce
set start_dt = ( select ga.startdate::date
			from guardianship gs,
				gapagreement ga 
			where gs.gapid = ga.gapid 
			   and gs.activeflag = 1
			   and ga.activeflag = 1
			   and gs.alternateid = ce.guardian_subsidy_id
		),
	update_user_id = 'CDM-41012',
	update_ts = now()			
where btrim(ce.eligibility_type_cd) = '2935'
	and ce.delete_sw = 'N'
	and ce.start_dt is null ; 
	
update tb_client_eligibility ce
set end_dt = ( select ga.enddate::date
				from guardianship gs,
					gapagreement ga 
				where gs.gapid = ga.gapid 
				   and gs.activeflag = 1
				   and ga.activeflag = 1
				   and gs.alternateid = ce.guardian_subsidy_id
			),
	update_user_id = 'CDM-41012',
	update_ts = now()			
where btrim(ce.eligibility_type_cd) = '2935'
	and ce.delete_sw = 'N'
	and ce.end_dt is null ; 	
