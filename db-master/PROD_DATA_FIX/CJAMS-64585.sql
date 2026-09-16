/*
Issue: CJAMS-64585 Update overdue reasons on closed case
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023212310.
Fix provided:  Data fix has been done to update the LLR information for the case 251023212310 as requested
Data/Code fix ticket#: CJAMS-64585
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VCNT', -- 'VEPC'
		cpsresponsetimerreason2 = 'VSDT', --  'VNEC'
		cpsresponsetimerreason4 = 'OCNT', --  'OEPC'
		cpsresponsetimerreason5 = 'OSDT', --  'ONEC'
		cpsresponsetimerreason7 = 'CCNT', --  'CEPC'
		cpsresponsetimerreason8 = 'CSDT', --  'CNEC'
		updatedby = 'CJAMS-64585',
		updatedon = now()
where cpsresponsetimeractionsid = '1768cec5-2377-4af7-89b8-8b59d769d69a'
	and activeflag = 1;