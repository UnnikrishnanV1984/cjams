/*
Issue Description: CJAMS-59845: Subsidy Payments Missing
Category/Module: Payments/ Adoption subsidy
Root cause: Adoption agreement extension was done as the part of CJAMS-58298 and it was missing in the adoptioncase table as the part of this data fix.
            Payments are missing for April and May months due to this and we need to provide a data fix to resolve it.
Fix provided: Data fix has been done to update the end date in adoption case table.
Data/Code fix ticket#: CJAMS-59845
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This issue was due updation missing in the recent data fix and data fix should resolve it.
*/

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-59845'
where adoptionagreementrateid = '6bbf08de-b15f-4573-b844-fd6893be28a6'
and activeflag = 1;


update adoptioncase
set enddate = '2028-03-19 00:00:00.000',
	updatedby = 'CJAMS-59845',
	updatedon = now()
where adoptioncaseid='03057d34-30d4-47e5-80a6-0807d606fd7b'
and activeflag = 1;