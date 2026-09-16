/*
Issue: CJAMS-64634 Update overdue reasons as listed below on closed case
Contact with Alleged Victim Completed : 
		Alleged victim Unavailable 
		Attempted Face to Face / 3-4 Attempts

Contact with Other Children Attempted or Completed : 
		Other children Unavailable 
		Family was contacted but unavailable to meet within mandate
	
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023145253.
Fix provided:  Data fix has been done to update the LLR information for the case 251023145253 as requested
Data/Code fix ticket#: CJAMS-64634
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', --  null
		cpsresponsetimerreason2 = 'VAFF', --  null
		cpsresponsetimerreason3 = 'V34F', --  null
		updatedby = 'CJAMS-64634',
		updatedon = now()
where cpsresponsetimeractionsid = 'd88c2059-f65a-4d08-a822-b9b52a2a153e'
	and activeflag = 1;

