-- CDM-26051 - System Adjustment has not interfaced
/*
-- Issue Description: 
	No system adjustment payment listed for Emilio (client ID: 3775958). 
	The placement validation has been done by the caseworker.

-- Case ID: 3258659
-- Client ID: 3775958 (EMILIO GONZALEZ) - a7ac2e94-cda0-4caa-9e75-6d4d37fd4901
-- Placement ID: 1561954 - 2021-03-01 To Current - 2b6c264b-881b-4a3a-a5fb-d346eaf4f62b
-- Private Organization: 5001652 (Second Family, Inc.)
-- RCC Facility: 5019648 (Second Family 1008 Nyanga DDA)	
-- Program ID: 50002363 (MF/Capitol Hghts.-Nyanga Ave.)

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Contarct program Rate was $0.00 (Fixed with CDM-25752)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To soft-delete the $0.00 rate slabs
select program_id, program_rate_id, start_dt, end_dt, per_diem_rate_no, monthly_rate_no, annual_rate_no, 
	update_ts, update_user_id, delete_sw 
from prov.tb_prov_program_rates 
where program_id  = 50002363
	and program_rate_id  in ( 215009936, 215009933 )
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-26051'
where program_id  = 50002363
	and program_rate_id  in ( 215009936, 215009933 )
	and delete_sw = 'N' ;
	
-- To Trigger Under Over batch
select program_rate_id, per_diem_rate_no, start_dt, end_dt, rate_status, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_program_rates
where program_id = 50002363
	and program_rate_id = 215009932
	and delete_sw = 'N' ;

update prov.tb_prov_program_rates
set update_ts = now(),
	update_user_id = 'CDM-26051'
where program_id = 50002363
	and program_rate_id = 215009932
	and delete_sw = 'N' ;

