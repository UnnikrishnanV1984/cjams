/*
Issue: CJAMS-59132 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : 
	Alleged victim Unavailable / 
	Attempted Face to Face / 
	1-2 Attempts

Contact with Initial Contact Caregiver Attempted or Completed : 
	Initial Contact Caregiver Unavailable 
	Family was contacted but unavailable to meet within mandate

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-59132
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
		cpsresponsetimerreason8 = 'CFMN', 
		caseworkercomments = 'Worker attempted to meet the child at the school on 1/27/25 however the school was closed. Worker met with the child at the school on 1/28/25, within 5 business days of receiving the CJAMS report. Worker met the face to face mandate but did not document in CJAMS promptly.',
		updatedby = 'CJAMS-59132',
		updatedon = now()
where cpsresponsetimeractionsid = '8f2609dc-8aa6-413c-ac6b-7e64d38b4681'
	and activeflag = 1;