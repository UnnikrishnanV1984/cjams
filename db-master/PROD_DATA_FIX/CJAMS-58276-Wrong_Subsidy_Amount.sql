/* 
    Issue Description: CJAMS-58276
   Category/ Module  : GAP Subsidy rate
   Root cause: User requested to update subsidy rate dates
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update gapagreementrate 
set startdate = '2025-01-25 01:00:00.000',
	enddate = '2026-01-24 01:00:00.000',
	updatedby = 'CJAMS-58276',
	updatedon = now()
where gapagreementid = '5e260d20-8843-4223-a01f-3be17fc6695f'
	and gapagreementrateid = 'd86acc35-abc2-4f7a-a1ee-b2e6ae3eedf6'
	and activeflag = 1;

update gapratesrevision 
set ratestartdate = '2025-01-25 01:00:00.000',
    rateenddate = '2026-01-24 01:00:00.000',
    approvaldate= now(),
    updatedby = 'CJAMS-58276',
    updatedon = now()
where gaprateid = 'd86acc35-abc2-4f7a-a1ee-b2e6ae3eedf6'
    and activeflag = 1;