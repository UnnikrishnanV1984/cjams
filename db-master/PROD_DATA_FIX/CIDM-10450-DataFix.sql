/*
Issue:Remove the CPS case (251023046031) created on 04/29 from the client's(CJAMS PID: 4135312) program Area.
Create a service case and connect it to the intake# I251013275403.
Root Cause:The system incorrectly created a CPS case instead of an in home service case during ICAMA intake approval due to a mismatch in service case type mapping, which leads to missing program area data and case invisibility in search and assignments dashboards. CDM-44359 has been created for analysis and code fix
Fix Provided (Data Fix Only):Removed incorrect CPS ,created a correct service case , as per data fix updated the 
intakeservicerequest,createservicecase.
Data/Code fix ticket#: CIDM-10450
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; no logic/code changes required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
--Remove CPS-251023046031
update
	intakeservicerequest
set
	activeflag = 0,
	actiontype = null,
	updatedby = 'CIDM-10450',
	updatedon = now()
where
	intakeserviceid = '91d9314a-a41a-4751-a658-c1611d3d59f7'
	and activeflag = 1;
--new servicecase - I251013275403
   select
	*
from
	cjams.createservicecase('91d9314a-a41a-4751-a658-c1611d3d59f7',
	null,
	1,
	'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae',
	'intake' );

update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CIDM-10450',
	updatedon = now()
where
	personprogramid = '349dbf41-9945-4829-a093-246ed7ee9f43'
	and activeflag = 1;


update
	servicecase
set
	insertedon = '2025-04-29 13:35:01.000',updatedby = 'CIDM-10450',
	updatedon = now()
where
	servicecaseid = (select servicecaseid from intakeservicerequest where intakeserviceid = '91d9314a-a41a-4751-a658-c1611d3d59f7')
	and activeflag = 1;


update
	servicecasedisposition 
set
	statusdate = '2025-04-29 13:35:01.000',
	updatedby = 'CIDM-10450',
	updatedon = now()
where
	servicecaseid = (select servicecaseid from intakeservicerequest where intakeserviceid = '91d9314a-a41a-4751-a658-c1611d3d59f7')
	and activeflag = 1;

