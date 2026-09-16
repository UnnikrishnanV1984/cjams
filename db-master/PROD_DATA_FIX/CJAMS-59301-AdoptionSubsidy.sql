/*
Issue Description: CJAMS-59301: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            1. Agreement end date: 04/18/2028
            2. Assistance Agreement: Title IV-E Adoption assistance agreement
            3. Child Placed By: Title IV-E Agency
            4. Submitted by (Worker Name): Megan Turner
            5. Approved by (Supervisor Name): Kathleen Chaney 
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-59301
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaseagreement 
set enddate = '2028-04-18 00:00:00',
    agreementtyperefid = 'TIAAA',
    issubsidypaid = 1,
    childplacedby = 'iveag',
	updatedby = 'CJAMS-59301',
	updatedon = now()
where adoptionagreementid='4ec79d67-e938-4e09-bf4d-7764a83bdd9e'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-59301'
where adoptionagreementrateid = '5906527b-c01c-4c5b-975a-6aa2200d7aaa'
and activeflag = 1;    
