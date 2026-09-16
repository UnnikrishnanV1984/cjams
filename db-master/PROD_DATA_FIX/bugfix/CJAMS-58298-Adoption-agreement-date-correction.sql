/*
Issue Description: CJAMS-58298: Adoption subsidy payment
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3154952
            1. Agreement End Date Current end date: 01/28/2026
            2. Assistance Agreement - Title IV-E Adoption assistance agreement
            3. Provider 1 ID: 5014233
            Provider 1 Name: Michele Brown
            4. Provider 2 ID:
            Provider 2 Name
            5. Adoptive Parent(1) Signature Date: 4/15/2009
            6. Adoptive Parent(2) Signature Date:
            7. LDSS Director/Designee Signature Date: 4/16/2009

            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options:Yes
            9. Adoptive Placement Child Placed From - Within State
            10. Child Placed By - Title IV-E Agency
            11. Submitted by (Worker Name): Gail Graves
            12. Approved by (Supervisor Name): Teresa Boston
            Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
            Data/Code fix ticket#: CJAMS-58298
            Regression Impacts: N/A
            Is Code fix Required?: No
            Code fix ticket#: N/A
            Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
            Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
            Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2026-01-28 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
    parent1signdate = '2009-04-15 00:00:00.000',
    parent2signdate = NULL,
    ldssdate = '2009-04-16 00:00:00.000',
	updatedby = 'CJAMS-58298',
	updatedon = now()
where adoptionagreementid='2e009a3f-c3ff-450a-951e-a759ef781cea'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58298'
where adoptionagreementrateid = 'a2960af1-6362-4aa4-8da0-63e669157382'
and activeflag = 1;    


update adoptioncase
set enddate = '2026-01-28 00:00:00',
	updatedby = 'CJAMS-58298',
	updatedon = now()
where adoptioncaseid='d9cc6d95-b969-4aff-838c-af5ed8eced5a'
and activeflag = 1;