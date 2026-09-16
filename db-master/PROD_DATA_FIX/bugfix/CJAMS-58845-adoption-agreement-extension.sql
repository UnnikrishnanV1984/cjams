/*
Issue Description: CJAMS-58845: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3161729
            1. Agreement End Date : 3/21/2027 (21st birthday)
            2. Assistance Agreement -State/Tribal Adoption Assistance Agreement
            3. Provider 1 ID: 5025145
               Provider 1 Name: Phillip Burnett
            4. Provider 2 ID: 5025145
               Provider 2 Name: Kimberly Burnett
            5. Adoptive Parent(1) Signature Date: 5/15/2008
            6. Adoptive Parent(2) Signature Date: 5/15/2008
            7. LDSS Director/Designee Signature Date: 5/15/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options :Yes
            9. Adoptive Placement Child Placed From - please select from below options:Within State
            10. Child Placed By - please select from below options : Title IV-E Agency
            11. Submitted by (Worker Name): Megan Turner
            12. Approved by (Supervisor Name); Kathleen Chaney
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-58845
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2027-03-21 00:00:00',
	updatedby = 'CJAMS-58845',
	updatedon = now()
where adoptionagreementid='e307e06d-659f-46ce-8a45-f915f7bd2ff3'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58845'
where adoptionagreementrateid = 'cd9a5f1f-987f-439e-b2c4-ffe030ca93a9'
and activeflag = 1;