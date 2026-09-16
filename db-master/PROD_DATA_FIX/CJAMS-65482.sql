/*
Issue: CJAMS-65482 Overlapping Placement Dates
Category/Module: Person profile 
Root cause: The end date of the current placement for the child is 12/15/2025, which conflicted with the old end date of 12/16/2025. The end date needs to be updated to 12/15/2025 to avoid the overlapping placement dates.
Fix provided: Data fix has been provided to correct the end date of the current placement as requested.
Data/Code fix ticket#: CJAMS-65482
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/
update placementcpahomes
set exitdt='2025-12-15 00:00:00',
updateuserid = 'CJAMS-65482', updatets = now() 
where  placementid='34f377de-4216-403e-9132-b368287e3f9b' and activeflag=1;