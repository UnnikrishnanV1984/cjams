/*
Issue Description: Please remove the SEN Flag for CJAMS PID#: 203764094(Jadix Linn)
Category/Module: Error
Root cause: Person can only be viewed, not edited in closed intakes
Fix provided: DB query to deactivate Active Substance exposed new born flag
Data/Code fix ticket#: CDM-41059
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating SEN flag in person
update person
set 
	senstatusflag = 0, substanceexposednewbornflag = 0, substanceexposednewbornsourceid = null, substanceexposednewbornsourcetypekey = null,
	substanceexposednewborntimetamp = null, substanceclasses = null, updatedby = 'CDM-41059', updatedon = now()
where personid = '1c140756-a7d2-43fb-bef3-227f8bb0d38d' and activeflag = 1;