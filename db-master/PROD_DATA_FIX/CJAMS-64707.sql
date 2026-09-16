/*
Issue: CJAMS-64707 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : 
	Case not assigned timely  
	Supervisor delays

Contact with Initial Contact Caregiver Attempted or Completed : 
	Case not assigned timely 
	Supervisor delays

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64707
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VCNT', 
		cpsresponsetimerreason2 = 'VSDT', 
		cpsresponsetimerreason7 = 'CCNT', 
		cpsresponsetimerreason8 = 'CSDT', 
		updatedby = 'CJAMS-64707',
		updatedon = now()
where cpsresponsetimeractionsid = '44f1d0c0-4b3c-4e77-a965-744551d5ab93'
	and activeflag = 1;