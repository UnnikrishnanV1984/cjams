/*
Issue: CJAMS-64637 Update overdue reasons as listed below on closed case
Contact with Alleged Victim Completed : 
		Alleged victim Unavailable 
		Attempted Face to Face / 1-2 Attempts

Contact with Other Children Attempted or Completed : 
		Other children Unavailable 
		Family was contacted but unavailable to meet within mandate
	
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023175474.
Fix provided:  Data fix has been done to update the LLR information for the case 251023175474 as requested
Data/Code fix ticket#: CJAMS-64637
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', --  null
		cpsresponsetimerreason2 = 'VAFF', --  null
		cpsresponsetimerreason3 = 'V12F', --  null
		cpsresponsetimerreason4 = 'OOCN', --  null
		cpsresponsetimerreason5 = 'OFMN', --  null
		updatedby = 'CJAMS-64637',
		updatedon = now()
where cpsresponsetimeractionsid = 'd87e9a78-e213-477d-b7a3-2b8ca602ccd7'
	and activeflag = 1;



