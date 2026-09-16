/*
Issue Description:CJAMS-61939 3166976:Need to extend subsidy date to 7/31/28 Screen URL:
Category/Module: Adoption Subsidy 
Root cause: We have completed the data fix to extend the adoption agreement as part of ticket CJAMS-61428, and data fix is not completed.
            It is missing the update on adoption case
Fix provided: Data fix has been done to update the adotion subsidy end date as 07/31/2028 for the case 3166976 and trigger the payments.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a know issue and User story is created to address it.
*/
update adoptioncase
set enddate = '2028-07-31 00:00:00',
	updatedby = 'CJAMS-61939',
	updatedon = now()
where adoptioncaseid='a582e6cf-330d-4ed9-859e-47c875a62b6b'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61939'
where adoptionagreementrateid in ('8abc40ac-1c4d-4a43-a8ac-f1a0436d5fbc','508dfae0-c414-4638-bd6f-10dd5e65a9b3')
and activeflag = 1; 