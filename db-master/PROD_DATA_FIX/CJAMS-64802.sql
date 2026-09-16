/*
Issue: CJAMS-64802
User requested to Update overdue reasons as listed below on closed case
		
Contact with Alleged Victim Completed: 
	Alleged victim Unavailable 
	Insufficient information reported - attempts were made to obtain 
	3-4 Attempts
	
Contact with Other Children Attempted or Completed: 
	Other children Unavailable / 
	Insufficient information reported - attempts were made to obtain / 
	3-4 Attempts

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64802
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VIIR', 
		cpsresponsetimerreason3 = 'V34R', 
		cpsresponsetimerreason4 = 'OOCN', 
		cpsresponsetimerreason5 = 'OIIN', 
		cpsresponsetimerreason6 = 'O34N', 
		updatedby = 'CJAMS-64802',
		updatedon = now()
where cpsresponsetimeractionsid = 'ed236af2-db46-4f03-9f8b-49c13e7b499b'
	and activeflag = 1;