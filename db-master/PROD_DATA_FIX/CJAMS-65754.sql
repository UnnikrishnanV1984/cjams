/*
Issue: CJAMS-65754 Education Record Update
Category/Module: Person Education
Root cause: User is not able to update end date for education record.
Fix provided:  Data fix provided to update end date for education record.
Data/Code fix ticket#: CJAMS-65754
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-11185 - Code fix will be provided as part of this ticket
Reason why no related code fix: NA
*/

update cjams.personeducation
	set enddate = '2026-01-16 00:00:00',
		updatedon = now(),
		updatedby = 'CJAMS-65754'
	where personeducationid = '022983c7-c03e-44ba-98b7-a9cec14b2407';