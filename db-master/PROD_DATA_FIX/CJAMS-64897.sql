/*
Issue: CJAMS-64897
User requested to Update overdue reasons as listed below on closed case
		
Contact with Alleged Victim Completed : Alleged victim unavailable / Attempted Face to Face / 1-2 Attempts

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64897
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', 
		cpsresponsetimerreason2 = 'VAFF', 
		cpsresponsetimerreason3 = 'V12F',
		allegedvictimcontact = false,
		updatedby = 'CJAMS-64897',
		updatedon = now()
where cpsresponsetimeractionsid = 'a33cd7b6-7bcc-47c6-b1a7-32b226a43b0c'
	and activeflag = 1;