/*
Issue: CJAMS-64575 Update overdue reasons as listed below on closed case
Contact with Alleged Victim Completed : 
		Alleged victim Unavailable 
		 family was contacted but unable to meet within mandat
	
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023143102.
Fix provided:  Data fix has been done to update the LLR information for the case 251023143102 as requested
Data/Code fix ticket#: CJAMS-64575
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VFCM', 
		updatedby = 'CJAMS-64575',
		updatedon = now()
where cpsresponsetimeractionsid = '594d23c5-52f3-4d27-b7f9-975b90b85ef8'
	and activeflag = 1;

