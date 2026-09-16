/*
Issue Description: CJAMS-62087: adoption agreement extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3162190
            1. Agreement End Date :  07/27/2026
            2. Assistance Agreement - please select from below options-
               - State/Tribal Adoption Assistance Agreement /
            3. Provider 1 ID:   5028920
               Provider 1 Name:  Jeffrey Bodick
            4. Provider 2 ID:   5028920
               Provider 2 Name:  Lisa Bodick
            5. Adoptive Parent(1) Signature Date:  4/23/2008
            6. Adoptive Parent(2) Signature Date:  4/23/2008
            7. LDSS Director/Designee Signature Date: 5/8/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options;
            - Yes /
            9. Adoptive Placement Child Placed From - please select from below options;
            - Within State
            10. Child Placed By  - please select from below options;
            - Title IV-E Agency
            11. Submitted by (Worker Name):  Ann Brown
            12. Approved by (Supervisor Name);  Allison Mitchell
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-62087
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2026-07-27 00:00:00.000',
    agreementtyperefid = 'STAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-62087',
	updatedon = now()
where adoptionagreementid='163513ea-0c64-45c8-b4c9-c83f6522bc3b'
and activeflag = 1;


update adoptioncase
set enddate = '2026-07-27 00:00:00.000',
    updatedby = 'CJAMS-62087',
	updatedon = now() 
where adoptioncaseid='9cbd9ff3-0259-47f7-bad3-609812be99e5'
and activeflag = 1;

-- To trigger payments batch
update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-62087'
where adoptionagreementrateid = '88bc49c7-631b-43a2-b1b9-97683d7f259b'
and activeflag = 1;