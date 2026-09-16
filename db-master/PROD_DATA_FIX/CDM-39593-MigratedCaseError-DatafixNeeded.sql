/*
Issue Description: Case: 3209375 - Lyric. Please remove the GAP end date
Category/Module: Permanency Plan
Root cause: Data fix to remove the GAP end date under Permanency Plan tab for Lyric Patrice-Ne Arnold.
Fix provided: Yes, write db query
Code fix ticket#: CDM-39593
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

update permanencyplan
set 
	enddate = null,
	updatedby = 'CDM-39593',
	updatedon = now()
where permanencyplanid = '7f83a732-39e1-4634-8596-960b609f78c9' and activeflag = 1;