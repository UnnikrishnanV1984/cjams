/*
Issue: CJAMS-64759 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : 
	Alleged victim Unavailable 
	Family was contacted but unavailable to meet within mandate

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64759
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VFCM', 
		updatedby = 'CJAMS-64759',
		updatedon = now()
where cpsresponsetimeractionsid = '162599fc-d5fe-4669-8d10-f29f3c36e8b6'
	and activeflag = 1;