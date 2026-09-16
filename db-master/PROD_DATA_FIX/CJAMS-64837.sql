/*
Issue: CJAMS-64837
User requested to Update overdue reasons as listed below on closed case
		
Contact with Alleged Victim Completed dropdown to Case Not Assigned Timely / Supervisor Delays
Contact with Initial Contact Caregiver Attempted or Completed dropdown to Case Not Assigned Timely / Supervisor Delays.

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64837
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
		updatedby = 'CJAMS-64837',
		updatedon = now()
where cpsresponsetimeractionsid = 'd939eeb0-b047-4fb1-b4da-8edd147fedbe'
	and activeflag = 1;