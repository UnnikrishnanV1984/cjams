-- CIDM-9568 - Caseworker Visitation Summary as of 07/29/2024
/*
-- Issue Description: 
   Service case is appearing with an error in the Weekly Caseworker visitation report.

-- Case ID: 241030262083 - 01ff0beb-6c8e-4640-bed3-0f08d538f3dc

-- Category/ Module: Weekly Caseworker visitation Ad-hoc Report Issue
-- Root cause: Data issue, servicecase table is having dispositioncode as closed when case is open.
-- Fix Provided: Datafix has been promoted to sync up the case dispositioncode and end date columns with servicecase status. 
-- Regression Impacts: N/A
	Is Code fix Required?: (Yes/No)
	Code fix ticket#: (If Yes)
	Reason why no related code fix: (If No) Generic script for One time data cleanup.
*/

-- To sync up the case dispositioncode and end date columns with servicecase status (CIDM-9568)

update servicecase sc
set statustypekey = 'ASSGN', 
	enddate = NULL,  
	dispositioncode	= NULL, 
	updatedby = 'CIDM-9568', 
	updatedon = now()
where lower(dispositioncode) = lower('Closed')
	and  lower(statustypekey) <> lower('Closed')
	and activeflag  = 1
	and ( select count(*)
			from intakeservreqchildremoval rm
		  where rm.servicecaseid = sc.servicecaseid
			and rm.activeflag  = '1'
			and rm.removaldate is not null
			and rm.exitdate is null
			and ( select count(*) 
					from routing rur
				  where rur.objectid = rm.intakeservreqchildremovalid::character varying
					and rur.eventcode = 'CHRR'
					and rur.activeflag = 1
					and rur.routingstatustypeid = '16'
				) > 0
		 ) > 0	;	
	 