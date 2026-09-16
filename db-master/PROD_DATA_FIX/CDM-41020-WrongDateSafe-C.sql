/*
Issue Description: Need Data fix for the date change for the approved Safec - c , received approval from supervisor and attached the same in the ticket, attached complete Safe-C in which date changed needed ( two places)
Category/Module: Error
Root cause: User entered wrong date for this Safe-C assessment record
Fix provided: DB query to rectify the date
Data/Code fix ticket#: CDM-41020
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update assessment
set submissiondata = jsonb_set(
	jsonb_set(
		submissiondata::jsonb, '{dateassessmentinitiated}', '"08/08/2024 5:48 pm"'::jsonb),
		'{caseworkercomments}', '"During the closing visit on 8/8/2024 Elizabeth and Louise were present and appeared to be safe in the care of their parents Ryan and Pamela Elias-McCann. Worker Sammons did not know that their sons Lucas and John would be going on a trip to Pennsylvania with their maternal grandparents, but note that on 8/2/24 a visit was done with all children and they appeared to be safe with no concerns. "'::jsonb)
where assessmentid = 'ae0c8364-a006-422f-ae36-c7f642612bea' and activeflag = 1;