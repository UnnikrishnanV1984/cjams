/*
Issue: CJAMS-64948 Change in Response Timer
Category/Module: LLR 
Root cause: Case has been closed and data fix needed to update the LLR reasons as requested
            Contact with Alleged Victim Completed: Alleged victim Unavailable / Family was contacted but unavailable to meet within mandate
            Contact with Other Children Attempted or Completed: Other children Unavailable / Family was contacted but unavailable to meet within mandate
            Contact with Initial Contact Caregiver Attempted or Completed: Initial Contact Caregiver Unavailable / Family was contacted but unavailable to meet within mandate
Fix provided: Data fix has been done to update the LLR reasons as requested by the user
                Contact with Alleged Victim Completed: Alleged victim Unavailable / Family was contacted but unavailable to meet within mandate
            Contact with Other Children Attempted or Completed: Other children Unavailable / Family was contacted but unavailable to meet within mandate
            Contact with Initial Contact Caregiver Attempted or Completed: Initial Contact Caregiver Unavailable / Family was contacted but unavailable to meet within mandate
Data/Code fix ticket#: CJAMS-64948
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix has been done to correct the LLR Reasons 
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VFCM', 
		cpsresponsetimerreason4 = 'OOCN',
		cpsresponsetimerreason5 = 'OFMN',
		cpsresponsetimerreason7 = 'CCCN', 
		cpsresponsetimerreason8 = 'CFMN', 
		updatedby = 'CJAMS-64948',
		updatedon = now()
where cpsresponsetimeractionsid = 'ac3c85bd-5a5c-455e-bd20-40dc9104815c'
	and activeflag = 1;