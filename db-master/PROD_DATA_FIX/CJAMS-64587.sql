/*
Issue: CJAMS-64587 Update overdue reasons as listed below on closed case
Contact with Alleged Victim Completed 
	Alleged victim unavailable  
	Family was contacted but unavailable to meet within mandate
		
Contact with Other Children Attempted or Completed
	Other children Unavailable 
	Family was contacted but unavailable to meet within mandate

Contact with Initial Contact Caregiver Attempted or Completed 
	Initial Contact Caregiver Unavailable  
	Family was contacted but unavailable to meet within mandate
	
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023149311.
Fix provided:  Data fix has been done to update the LLR information for the case 251023149311 as requested
Data/Code fix ticket#: CJAMS-64587
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', --  'VEPC'
		cpsresponsetimerreason2 = 'VFCM', --  'VNEC'
		cpsresponsetimerreason4 = 'OOCN', --  null
		cpsresponsetimerreason5 = 'OFMN', --  null
		cpsresponsetimerreason7 = 'CCCN', --  'CEPC'
		cpsresponsetimerreason8 = 'CFMN', --  'CNEC'
		updatedby = 'CJAMS-64587',
		updatedon = now()
where cpsresponsetimeractionsid = 'dc7125f6-d8c5-4445-a008-6e99c03fb071'
	and activeflag = 1;


