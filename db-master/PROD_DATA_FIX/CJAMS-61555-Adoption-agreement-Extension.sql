/*
Issue Description: CJAMS-61555: Adoption subsidy end date
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            1. Agreement End Date : 9/29/2028
            2. Assistance Agreement - please select from below options
                                      Title IV-E Adoption assistance agreement
            3. Provider 1 ID: 5020557
               Provider 1 Name: Debra Cardarelli
            4. Provider 2 ID: N/A
            Provider 2 Name
            5. Adoptive Parent(1) Signature Date: 11/15/2008
            6. Adoptive Parent(2) Signature Date:
            7. LDSS Director/Designee Signature Date: 11/15/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options;
            Yes
            9. Adoptive Placement Child Placed From - please select from below options;
            Within State
            10. Child Placed By - please select from below options;
            Title IV-E Agency
            11. Submitted by (Worker Name): Ann Brown
            12. Approved by (Supervisor Name); Allison Mitchell
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-61555
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2028-09-29 00:00:00.000',
    agreementtyperefid = 'TIAAA',
    parent2providerid = NULL,
    parent1signdate = '2008-11-15 00:00:00.000',
    parent2signdate = NULL,
    ldssdate = '2008-11-15 00:00:00.000',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-61555',
	updatedon = now()
where adoptionagreementid='633f96da-f0af-412e-b562-57f5d2b49c07'
and activeflag = 1;


update adoptioncase
set enddate = '2028-09-29 00:00:00.000',
    updatedby = 'CJAMS-61555',
	updatedon = now() 
where adoptioncaseid='e3d3a874-214c-4318-bbca-c5ff4ae72e98'
and activeflag = 1;

-- To trigger payments batch
update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61555'
where adoptionagreementrateid = 'e540bc84-fdc6-4421-8c5f-3327be1de802'
and activeflag = 1;

