
/*
Issue Description: Unable to extend the agreement end date. Alert message received. Client ID 2655785. Agreement end date should be 3/19/2028
Category/Module: Payments
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3174668
Fix provided: user do not have acces updated data,Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-58332
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-03-19 00:00:00',
    agreementtyperefid = 'STAAA',
    parent1providername = 'Michele Janette Sauder',
    parent2providername = 'Vernon Lamar Sauder',
	updatedby = 'CJAMS-58332',
	updatedon = now()
where adoptionagreementid='b1bf67b4-a517-4475-9043-2bc630b58ab6'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58332'
where adoptionagreementrateid = 'a6c747ef-0fd0-4ecf-8856-681933429581'
and activeflag = 1;    