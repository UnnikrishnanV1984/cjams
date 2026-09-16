
/*
Issue Description: CJAMS-67845 -Investigation Summaries not populating
Category/Module: Case Management
Root cause:  The allegationId on both nvestigationallegation rows was set to 'e54563a4-b41c-4071-bfc0-fc3d33a052f5' but the UI's maltreatment lookup uses:  'e11fc4b5-1edf-4f17-af54-b536bbf6df31'
Fix provided: Data fix has been promoted to update the allegationId from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update investigationallegation 
set allegationid  = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',updatedby ='CJAMS-67845',updatedon=now()
where investigationallegationid  in ('b5e10973-664f-4dab-b13e-29d16ea8ae16', '2a751d9d-4c1c-4edf-a0ca-b5dfcd8ce7eb') and activeflag =1;