/*
Issue: CJAMS-64615 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed: 
		Alleged victim unavailable / 
		Attempted face to face 
		1-2 attempts.

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64615
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VAVU', --  null
		cpsresponsetimerreason2 = 'VAFF', --  null
		cpsresponsetimerreason3 = 'V12F', --  null
		updatedby = 'CJAMS-64615',
		updatedon = now()
where cpsresponsetimeractionsid = 'ddd01f9b-ba51-4e4c-80a1-664ce08486db'
	and activeflag = 1;