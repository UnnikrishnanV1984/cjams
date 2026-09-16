/*
Issue Description: CJAMS-61713: adoption agreement extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3158847
            1. Agreement End Date : 8/8/2028
            2. Assistance Agreement - Title IV-E Adoption assistance agreement
            3. Provider 1 ID: 5018110
               Provider 1 Name: Robert Wetzel
            4. Provider 2 ID: 5018110
               Provider 2 Name: Annette Wetzel
            5. Adoptive Parent(1) Signature Date: 3/1/2008
            6. Adoptive Parent(2) Signature Date: 3/1/2008
            7. LDSS Director/Designee Signature Date: 3/1/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - Yes
            9. Adoptive Placement Child Placed From - please select from below options : Within State
            10. Child Placed By -Title IV-E Agency
            11. Submitted by (Worker Name): Megan Turner
            12. Approved by (Supervisor Name); Kathleen Chaney
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-61713
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2028-08-08 00:00:00.000',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-61713',
	updatedon = now()
where adoptionagreementid='0a4f58e3-f151-42da-b0f5-4b73a544341e'
and activeflag = 1;


update adoptioncase
set enddate = '2028-08-08 00:00:00.000',
    updatedby = 'CJAMS-61713',
	updatedon = now() 
where adoptioncaseid='54b2fceb-8d6e-4b49-ba12-ff5bd4a0a942'
and activeflag = 1;

-- To trigger payments batch
update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61713'
where adoptionagreementrateid = '3ba69a69-33ff-4d85-8f5e-6fc9eb438fb6'
and activeflag = 1;