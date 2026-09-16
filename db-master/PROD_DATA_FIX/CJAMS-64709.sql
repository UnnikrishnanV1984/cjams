/*
Issue: CJAMS-64709 
User requested to Update overdue reasons as listed below on closed case

Contact with Alleged Victim Completed : Initial contact with family would place child's safety at risk

Contact with Initial Contact Caregiver Attempted or Completed : Initial contact with family would place child's safety at risk.

Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information.
Fix provided:  Data fix has been done to update the LLR information as requested
Data/Code fix ticket#: CJAMS-64709
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.cpsresponsetimeractions
	set cpsresponsetimerreason1 = 'VISR', 
		cpsresponsetimerreason2 = null, 
		cpsresponsetimerreason7 = 'CISR', 
		cpsresponsetimerreason8 = null, 
		updatedby = 'CJAMS-64709',
		updatedon = now()
where cpsresponsetimeractionsid = 'e82215c2-9493-4a3c-9045-bf601f07af29'
	and activeflag = 1;