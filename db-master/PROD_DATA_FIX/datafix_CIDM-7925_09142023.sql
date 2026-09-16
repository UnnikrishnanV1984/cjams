-- CIDM-7925 - Provider Vacancy data fix for the Provider - 6025595
/*
-- Issue Description: 
	Provider # 5001278 has a zero vacancy count for program # 50002302. 
	There are 7 contracted beds, 6 active youth and 0 vacancy count on both the contract 
	and placement search preventing a new placement.
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: Placement was deleted with CDM-34142, but the vacancy update was missed in that fix.
-- Fix Provided: Datafix has been promoted to update the provider vacancy based on the current active placements. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Private Organization: 5083107 (Destiny Group Home)
-- Program ID: 50004805	(Emily Cady) - 06/01/2023 To 06/30/2025
-- RCC Facility Site ID: 6025595 (Destiny's Group Home - 8031 Wood Ave)	
-- Contracted Beds: 1
-- Vacancy: 0

-- To fix the provider vacancy based on the current active placements (CIDM-7925) 
-- Before
select program_id, program_nm, program_status_cd, contract_beds_no, vacancy_no, update_ts, update_user_id 
	from prov.tb_contract_program
where program_id = 50004805
	and delete_sw = 'N' ;
	
-- Update
update prov.tb_contract_program cp
set update_user_id = 'CIDM-7925',
	update_ts = now(),
	vacancy_no = contract_beds_no
		-  (select count(*) 
				from placement pl
			where pl.contractprogramid = cp.program_id
				and pl.activeflag = 1
				and pl.startdatetime is not null
				and pl.enddatetime is null
				and coalesce(pl.isvoided, 0) <> 1
				and (
						( select count(*)
							from routing ro
						  where ro.objectid = pl.placementid::character varying
							and ro.eventcode = 'PLTR'
							and ro.routingstatustypeid = 16
							and ro.activeflag = 1
						) > 0	
						or 
						( select count(*)
							from routing ro
						  where ro.objectid = pl.placementid::character varying
							and ro.eventcode = 'PLTR'
							and ro.routingstatustypeid = 15
							and ro.activeflag = 1
						) > 0	
					)
			) -- active_placement
where program_id = 50004805
  and delete_sw = 'N' ; 

-- After
select program_id, program_nm, program_status_cd, contract_beds_no, vacancy_no, update_ts, update_user_id 
	from prov.tb_contract_program
where program_id = 50004805
	and delete_sw = 'N' ; 