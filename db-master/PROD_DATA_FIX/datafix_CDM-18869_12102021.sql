-- CDM-18869 - Douglas Kingsley Placement Validation
/*
-- Issue Description: 
	To fix Placement validation error message "The Provider is missing Provider Category"

-- Case ID: 3264522
-- Client ID: 3738959 (DOUGLAS ALLEN KINGSLEY) - ff722104-5b57-48fb-8fd4-9e3806c8fe8c
-- Placement ID: 1565237 - 2021-05-19 To Current - 960bec2a-b443-47f4-94d5-dfda343f6b1f
-- Private Organization: 6002823 (Lakeland Behavioral Health System Residential Treatment Center)
-- Residential Treatment Center: 6002889 (Lakeland Behavioral Health System RTC - 2323 W. Grand St.)
-- Program: 50002445 (Douglas Kingsley) - 2021-05-19 To 2023-10-31

-- Category/ Module: Placement Valodation (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove old Auto Placement Validation Log records
select placement_auto_validation_log_id, error_reasons, validation_start_dt, validation_end_dt,	activeflag 
	from tb_placement_auto_validation_log 
where placement_id = 1565237
	and placement_validation_id  in (1970561, 1970559, 1970560)
	and activeflag = 1 ;

update tb_placement_auto_validation_log
	set activeflag = 0
where placement_id = 1565237
	and placement_validation_id  in (1970561, 1970559, 1970560)
	and activeflag = 1 ;

/* placement_auto_validation_log_ida: 1006135, 1006136 & 1006137 */