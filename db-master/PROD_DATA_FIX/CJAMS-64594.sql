/*
Issue: CJAMS-64594 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : 
	Alleged victim Unavailable / 
	Attempted Face to Face / 
	1-2 Attempts

Contact with Initial Contact Caregiver Attempted or Completed : 
	Initial Contact Caregiver Unavailable 
	Attempted Face to Face 
	1-2 Attempts

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64594
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VAFF', 
		cpsresponsetimerreason3 = 'V12F',
		cpsresponsetimerreason7 = 'CCCN', 
		cpsresponsetimerreason8 = 'CFFN', 
		cpsresponsetimerreason9 = 'C12F',
		updatedby = 'CJAMS-64594',
		updatedon = now()
where cpsresponsetimeractionsid = '4f6df7a3-10ae-41ec-ad7e-21a5af715f3c'
	and activeflag = 1;