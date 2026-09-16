/*
Issue Description:CJAMS-60647 User requested to delete the draft removal record
Category/Module: Child Removal 
Root cause: User created a child removal by mistake and datafix is needed to delete the incorrect removal
             client:Darius Alston-monroe 
             (CJAMS PID#: 201248351) 
             case 231030232724
Fix provided: Data fix has been done to remove the incorrect removal from the case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and requested for a data fix.
*/

update intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-44118',
	updatedon = now()
where intakeservreqchildremovalid='d33b32dc-e0e4-4bf5-be09-2f7c5b8c7788'
and activeflag = 1;


update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-44118',
	updatedon = now()
where intakeservreqchildremovalid='d33b32dc-e0e4-4bf5-be09-2f7c5b8c7788'
and activeflag = 1;