/*
Issue: CJAMS-64500 GAP Suspension Issue
Category/Module: GAP Suspension
Root cause:  GAP Suspension was enetered for wrong CJAMS PID and payments were not generated beacuse of this.
Fix provided:  Data fix has been done to remove the wrong suspension entered for CJAMS PID#	4102008 and corrected the suspension start date  for CJAMS PID#	:	4102009
Data/Code fix ticket#: CJAMS-64500
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
*/


update cjams.gapsuspension
	set startdate = '2025-08-22 05:00:00.000',
		updatedby = 'CJAMS-64500',
		updatedon = now()
	where gapsuspensionid = '854983af-b861-4f97-b233-6e2448a5dbce';

update cjams.gapsuspensionrevision
	set startdate = '2025-08-22 05:00:00.000',
		approvaldate = now(),
		updatedby = 'CJAMS-64500',
		updatedon = now()
	where gapsuspensionrevisionid = '1a96f6b0-c3cf-4a93-a0a0-78c148c10c8d';
	
update cjams.gapsuspension
	set activeflag = 0,
		updatedby = 'CJAMS-64500',
		updatedon = now()
	where gapsuspensionid = '3bfd46c9-7cef-47fc-a56c-0e18da49ccb2';
	
update cjams.gapsuspensionrevision
	set activeflag = 0,
		updatedby = 'CJAMS-64500',
		updatedon = now()
	where suspensionid = '3bfd46c9-7cef-47fc-a56c-0e18da49ccb2'
	and activeflag = 1; 
	
update cjams.routing
	set activeflag = 0,
		updatedby = 'CJAMS-64500',
		updatedon = now()
	where objectid = '3bfd46c9-7cef-47fc-a56c-0e18da49ccb2'
	and activeflag = 1;