/*
Issue: CJAMS-64986 Change in Response Timer
Category/Module: LLR 
Root cause: 251023206858 Case has been closed and data fix needed to update the LLR reasons as requested
            Contact with Alleged Victim Completed: Case not assigned timely / Supervisor delays
            Contact with Initial Contact Caregiver Attempted or Completed: Case not assigned timely / Supervisor delays
Fix provided: Data fix has been done to update the LLR reasons as requested by the user
                Contact with Alleged Victim Completed: Case not assigned timely / Supervisor delays
                Contact with Initial Contact Caregiver Attempted or Completed: Case not assigned timely / Supervisor delays 
Data/Code fix ticket#: CJAMS-64986
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix has been done to correct the LLR Reasons 
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VCNT', 
		cpsresponsetimerreason2 = 'VSDT',
		cpsresponsetimerreason7 = 'CCNT', 
		cpsresponsetimerreason8 = 'CSDT', 
		updatedby = 'CJAMS-64986',
		updatedon = now()
where cpsresponsetimeractionsid = 'dfbed987-c71b-4353-b45f-16b6a36c8023'
	and activeflag = 1;