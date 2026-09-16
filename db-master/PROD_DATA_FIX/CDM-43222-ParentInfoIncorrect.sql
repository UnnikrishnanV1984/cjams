/*
Issue Description: In the Parent Information Sheet (VIIIa) under Permanency Progress tab, the Father details are showing incorrect 
Category/Module: Bug
Root cause: Wrong parent info was recorded in this case plan, possibly due to data error
Fix provided: DB query to insert parent info from latest available records
Data/Code fix ticket#: CDM-43222
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating snapshothist
update snapshothist
set snapshotdata = jsonb_set( snapshotdata::jsonb, '{0, fatherdetails}',
	'{"dob": "2006-02-01T00:00:00.00", "akaname": " ", "clientid": 1695388, "ssnvalue": "***-**-2567", "parentname": "MARCUS  WOODARD", "phonenumber": "410-664-0590", "parentaddress": "1126 GORSUCH AVE  Baltimore MD 21217"}'::jsonb, true),
	updatedby = 'CDM-43222', updatedon = now()
where id = '0f350993-b1a7-48cc-8e82-308eb106e162' and activeflag = 1;