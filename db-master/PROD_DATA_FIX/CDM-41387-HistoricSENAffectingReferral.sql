/*
Issue Description: Please do a data fix to uncheck the substance exposed newborn checkbox in SDM in the intake #I241013126605 and Case#  241022905331. Please make sure "There is Risk of Harm for a Substance Exposed Newborn. Response within 48 hours" under Recommendations and Override is also getting unchecked.
Category/Module: Error
Root cause: Child has SEN with 48 hour response even when SEN is historic (old)
Fix provided: DB queries to deactivate SEN in intake and IR case
Data/Code fix ticket#: CDM-41387
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-9374
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating in intakedastaging
update intakedastaging
set
	jsondata = jsonb_set (
		jsonb_set(
			jsonb_set(jsondata::jsonb, '{sdm, noImmediateList, isnoimmed_substantial_risk}', 'false'::jsonb),
			'{sdm, isnegrh_exposednewborn}', 'false'::jsonb),
		'{sdm, riskofHarm}', jsonb_strip_nulls((jsondata::jsonb->'sdm'->'riskofHarm') - 'isnegrh_exposednewborn')
	),
	updatedby = 'CDM-41387', updatedon = now()
where intakenumber = 'I241013126605' and activeflag = 1;

--Updating in intakesnapshot
update intakesnapshot
set
	jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(jsondata::jsonb, '{sdm, noImmediateList, isnoimmed_substantial_risk}', 'false'::jsonb),
			'{sdm, isnegrh_exposednewborn}', 'false'::jsonb),
		'{sdm, riskofHarm}', jsonb_strip_nulls((jsondata::jsonb->'sdm'->'riskofHarm') - 'isnegrh_exposednewborn')
	),
	updatedby = 'CDM-41387', updatedon = now()
where intakesnapshotid = '38640220-0e55-4599-a586-be525ddc7e5f' and activeflag = 1;

--Updating in intakeservicerequestsdm
update intakeservicerequestsdm
set drugexposednewbornflag = 0, updatedby = 'CDM-41387', updatedon = now()
where intakeservicerequestsdmid = '3e323e9c-6b40-4d6b-8eb8-b76ae4e31602' and activeflag = 1;