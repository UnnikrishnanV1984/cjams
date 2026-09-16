/*
Issue Description: CJAMS-64712
3274725:Please correct the date of Contact ID: 15811696 which was entered wrong by accident by the worker. The contact date should be 01/20/2026 instead of 01/13/2026
Root cause: Users requested to correct the contact date.
Fix provided: data fix to update the contact date
Data/Code fix ticket#: CJAMS-64712
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
*/

update cjams.progressnote
	set contactdate ='2026-01-20 00:00:00.000', 
		starttime = '2026-01-20 16:00:00', 
		endtime = '2026-01-20 16:15:00', 
		updatedby  = 'CJAMS-64712', 
		updatedon = now()
	where progressnoteid  = 'c74a291e-1033-47ab-9694-2acad5d4ab46' 
	and activeflag =1;