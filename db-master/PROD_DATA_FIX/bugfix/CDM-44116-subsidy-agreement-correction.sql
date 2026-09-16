/*
Issue Description: CDM-44116: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            Case# 3170889, Client ID: 2531485 (NOAH KEENEY)
            1. Agreement end date: 8/15/2028
            2. Assistance Agreement - Title IV-E Adoption assistance agreement
            3. Child Placed By -Title IV-E Agency
            4. Submitted by (Worker Name): Kathy Ballard-Harry  
            5. Approved by (Supervisor Name): Jecelyn Litzenberger
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CDM-44116
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-08-15 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CDM-44116',
	updatedon = now()
where adoptionagreementid='c9c5d328-5c05-466d-bda9-c8a74a963867'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CDM-44116'
where adoptionagreementrateid = 'e026f37a-2382-43d7-b904-b78fa445fe1b'
and activeflag = 1;

update adoptioncase
set enddate = '2028-08-15 00:00:00',
    updatedby = 'CDM-44116',
	updatedon = now()
where adoptioncaseid ='c37f1e21-4232-4a81-b286-9748a3a1a49a' and activeflag = 1;