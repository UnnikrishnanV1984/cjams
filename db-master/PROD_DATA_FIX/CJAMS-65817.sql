/*
Issue: CJAMS-65817 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : Alleged victim Unavailable / Attempted Face to Face / 3-4 Attempts
Contact with Other Children Attempted or Completed : Other children Unavailable / Insufficient information reported - attempts were made to obtain / 3-4 Attempts

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-65817
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VAFF', 
		cpsresponsetimerreason3 = 'V34F',
		cpsresponsetimerreason4 = 'OOCN',
		cpsresponsetimerreason5 = 'OIIN', 
		cpsresponsetimerreason6 = 'O34N', 
		updatedby = 'CJAMS-65817',
		updatedon = now()
where cpsresponsetimeractionsid = '13a0841b-bbcd-4ede-9f40-7cd4e20e9611'
	and activeflag = 1;