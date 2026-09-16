/*
Issue: CJAMS-64586 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed 
	Case not assigned timely 
	Supervisor delays.
	
Contact with Initial Contact Caregiver Attempted or Completed dropdown to 
	Case not assigned timely 
	Supervisor delays.

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64586
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VCNT', --  null
		cpsresponsetimerreason2 = 'VSDT', --  null
		cpsresponsetimerreason7 = 'CCNT', --  null
		cpsresponsetimerreason8 = 'CSDT', --  null
		updatedby = 'CJAMS-64586',
		updatedon = now()
where cpsresponsetimeractionsid = '49e82dd2-0b56-444f-8bc3-798f93ec7cfb'
	and activeflag = 1;