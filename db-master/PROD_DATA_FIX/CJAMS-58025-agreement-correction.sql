/*
Issue Description: CJAMS-58025: Adoption subsidy payment
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3165662
            1. Agreement End Date : 02/22/2025
            2. Assistance Agreement: Title IV-E Adoption assistance agreement
            3. Provider 1 ID:5017799
            Provider 1 Name: Brian Joseph Vislusky
            4. Provider 2 ID:5017799
            Provider 2 Name: Kara Devon Vislusky
            5. Adoptive Parent(1) Signature Date: 7/18/2008
            6. Adoptive Parent(2) Signature Date: 7/18/2008
            7. LDSS Director/Designee Signature Date: 8/13/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid ; - Yes
            9. Adoptive Placement Child Placed From : - Within State
            10. Child Placed By ; - Title IV-E Agency
            11. Submitted by (Worker Name): Megan Turner
            12. Approved by (Supervisor Name): Kathleen Chaney 
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-58025
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaseagreement 
set enddate = '2028-02-22 00:00:00',
    agreementtyperefid = 'TIAAA',
    parent1signdate = '2008-07-18 00:00:00',
    parent2signdate = '2008-07-18 00:00:00',
    ldssdate = '2008-08-13 00:00:00',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-58025',
	updatedon = now()
where adoptionagreementid='d8d795bf-7009-4a58-8c6f-6181a283fe6b'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58025'
where adoptionagreementrateid = '2ce09c46-9c7e-46c3-8bfd-b9f0b99fa6b9'
and activeflag = 1;

update adoptioncase
set enddate = '2028-02-22 00:00:00',
    updatedby = 'CJAMS-58025',
	updatedon = now()
where adoptioncaseid = '42921ac9-e3f3-474e-ad4a-bcc83f1e5161'
and activeflag=1;