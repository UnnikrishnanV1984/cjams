/*
Issue: CJAMS-59130 
User requested to Update overdue reasons as listed below on closed case

Alleged Victim Unavailable > Family contacted but unable to meet within the mandate 
Other children unavailable > Family contacted but unable to meet within the mandate 
Initial contact caregiver unavailable > Family contacted but unable to meet within the mandate

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-59130
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VFCM', 
		cpsresponsetimerreason4 = 'OOCN',
		cpsresponsetimerreason5 = 'OFMN',
		cpsresponsetimerreason7 = 'CCCN', 
		cpsresponsetimerreason8 = 'CFMN', 
		updatedby = 'CJAMS-59130',
		updatedon = now()
where cpsresponsetimeractionsid = '3be439e9-41ee-4a0c-bf48-8c43686eb719'
	and activeflag = 1;