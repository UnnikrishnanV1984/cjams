/*
Issue Description:CJAMS-60878 Closed cases showing as open on workload
Category/Module: Adoption case workload
Root cause: We are having around 214 cases with open case assignment and closed adoption cases in the application.

Bulk data fix will be done as the part of this ticket to endate the case assignment as adoption end date.
Adhoc report pulled and added as the part of this ticket
Fix provided: Data fix has been done to end date the open case assignments for the adoption cases which are already closed but have open case assignment.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Reason why no related code fix: N/A
*/

UPDATE caseassignment 
SET enddate = a.enddate,
	statustypekey = null,
	updatedby = 'CJAMS-60878',
	updatedon = now()
FROM adoptioncase a
WHERE a.adoptioncaseid = caseassignment.objectid and
	  a.statustypekey = 'Closed' and
	  caseassignment.statustypekey='Open' and
	  caseassignment.enddate is null and 
	  caseassignment.activeflag=1;