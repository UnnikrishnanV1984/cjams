-- CDM-27340-Cannot end date removal
/*
   File Name: CDM-27340-multipletable-Enddateremoval
-- Issue Description: 
   For the case number case #  221030015689 for Makala Wilson, Removal end date should be 11/21/22 but will not appear under removal,Placement was removed and ended on 11/21/22 so removal end data should reflect that information.
   Customer Email ID: jennifer.gardner@maryland.gov

-- Resolution: Updated the exitdate, enddate to 2022-11-21 00:00:00 in intakeservreqchildremoval, personprogramarea and tb_client_eligibility table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


update
	intakeservreqchildremoval
set
	exitdate = '2022-11-21 00:00:00',
	updatedon = now(),
	updatedby = 'CDM-27340'
where
	intakeservreqchildremovalid = '113969dd-4eaf-49b7-8d3e-cd53d60f44ff';

update
	personprogramarea
set
	enddate = '2022-11-21 00:00:00',
	updatedby = 'CDM-27340',
	updatedon = now()
where
	personprogramid = 'cead9df4-a381-4f71-ad82-f139879bb1e7';


update
	tb_client_eligibility
set
	end_dt = '2022-11-21 00:00:00',
	update_user_id = 'CDM-27340',
	update_ts = now()
where
	removal_id = 254789;