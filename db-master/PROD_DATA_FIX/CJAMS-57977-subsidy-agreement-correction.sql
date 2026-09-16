/*
Issue Description: CJAMS-57995: Adoption subsidy payment
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3167288
            1. Agreement End Date : 2/17/2028
            2. Assistance Agreement : Title IV-E Adoption assistance agreement
            3. Provider 1 ID: 5008216
            Provider 1 Name: Betsy Ross
            4. Provider 2 ID: single parent adoption
            Provider 2 Name: 
            5. Adoptive Parent(1) Signature Date: 5/14/2008
            6. Adoptive Parent(2) Signature Date: 
            7. LDSS Director/Designee Signature Date: 5/14/2008
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid : Yes
            9. Adoptive Placement Child Placed From : Within State
            10. Child Placed By : Title IV-E Agency
            11. Submitted by (Worker Name): Erika McManus
            12. Approved by (Supervisor Name): Sarah Callahan 
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-57995
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaseagreement 
set enddate = '2028-02-17 00:00:00',
    agreementtyperefid = 'TIAAA',
    parent1providername = 'Betsy Ross',
    singleparentadoptioncheck = 1,
    parent1providerid = 5008216, 
    parent2providerid = null,
    parent2providername = null,    
	childplacedby = 'iveag',
	updatedby = 'CJAMS-57995',
	updatedon = now()
where adoptionagreementid='cc03247d-d8b3-4a18-ae7f-ea506c069363'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-57995'
where adoptionagreementrateid = 'b5798e49-04fc-4243-a5db-7686aef8bb85'
and activeflag = 1;

update adoptioncase 
set enddate='2028-02-17 00:00:00',
    updatedby = 'CJAMS-57995',
	updatedon = now()
where adoptioncaseid='b37beda9-221f-4f6e-bd4c-77f8b03edbbd'
and activeflag = 1;   
