/*
Issue: CJAMS-64982 Change in Response Timer
Category/Module: LLR 
Root cause: 251023144669 Case has been closed and data fix needed to update the LLR reasons as requested by the user
Fix provided: Data fix has been done to update the LLR reasons as requested by the user
              Contact with Alleged Victim Completed : Case not assigned timely / Supervisor delays
              Contact with Other Children Attempted or Completed : Case not assigned timely / Supervisor delays
              Contact with Initial Contact Caregiver Attempted or Completed : Case not assigned timely / Supervisor delays
Data/Code fix ticket#: CJAMS-64982
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix has been done to correct the LLR Reasons 
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VCNT', 
		cpsresponsetimerreason2 = 'VSDT', 
		cpsresponsetimerreason4 = 'OCNT',
		cpsresponsetimerreason5 = 'OSDT',
		cpsresponsetimerreason7 = 'CCNT', 
		cpsresponsetimerreason8 = 'CSDT', 
		updatedby = 'CJAMS-64982',
		updatedon = now()
where cpsresponsetimeractionsid = 'd76b98bb-3b04-4f4b-af5a-d8b5338aafa3'
	and activeflag = 1;