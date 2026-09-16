-- CDM-26052 - Maintenance payment
/*
-- Issue Description: 
	Validation for Qadus Giles did not populate for the month of September 2022. 
	Maintenance payment not paid due to validation error. 
	Placement: Second Family 5001652

-- Case ID: 3241064
-- Client ID: 3526327 (QADUS GILES) - 95024366-a8b5-4aa3-a59c-f27c5ae2954f
-- Placement ID: 1561967 - 2021-03-01 To Current - 1c87ad17-da8d-4009-85cd-239d1d01a75f
-- Private Organization: 5001652 (Second Family, Inc.)
-- RCC Facility: 5049803 (Second Family - Crosswick DDA)
-- Program ID: 50002367	(MF/PG Expansion-Crosswick Turn)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Contarct program Rate was $0.00 (Fixed with CDM-25752)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over batch
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002367
	and program_rate_id = 215009923
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set update_ts = now(),
	update_user_id = 'CDM-26052'
where program_id = 50002367
	and program_rate_id = 215009923
	and delete_sw = 'N' ;

