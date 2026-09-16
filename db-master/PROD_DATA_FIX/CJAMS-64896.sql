/*
Issue: CJAMS-64896
User requested to Update overdue reasons as listed below on closed case
		
Contact with Alleged Victim Completed: 
	Alleged victim unavailable  
	Attempted Face to Face 
	3-4 Attempts

Contact with Initial Contact Caregiver Attempted or Completed: 
	Initial Contact Caregiver Unavailable / 
	Attempted Face to Face / 
	3-4 Attempts


Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64896
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VAFF', 
		cpsresponsetimerreason3 = 'V34F', 
		cpsresponsetimerreason7 = 'CCCN', 
		cpsresponsetimerreason8 = 'CFFN', 
		cpsresponsetimerreason9 = 'C34F', 
		updatedby = 'CJAMS-64896',
		updatedon = now()
where cpsresponsetimeractionsid = '8e795b05-a440-4386-84d0-4917c3a7a6d7'
	and activeflag = 1;