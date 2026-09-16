
/*
Issue Description: Unable to extend the agreement end date. Alert message received. Client ID 3170594. Agreement end date should be Agreement End Date : 1/12/2028
Category/Module: Payments
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3170594
Fix provided: user do not have acces updated data,Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-61078
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-01-12 00:00:00.000',
	updatedby = 'CJAMS-61078',
	updatedon = now()
where adoptionagreementid='391f2471-4ac7-404d-ba45-8d165e829097'
and activeflag = 1;

update adoptioncase
set enddate = '2028-01-12 00:00:00.000',
	updatedby = 'CJAMS-61078',
	updatedon = now()
where adoptioncaseid='6389e1b1-1715-4305-be58-30340467ca0d'
and activeflag = 1;

--update adoptioncaseagreementrate
--set updatedon = now(),
--    updatedby = 'CJAMS-61078'
--where adoptionagreementid  = '391f2471-4ac7-404d-ba45-8d165e829097'
--and activeflag = 1;    
