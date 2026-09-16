/*
Issue Description: CJAMS-57995: Adoption subsidy payment
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3154952
            1. Agreement End Date : 02/06/2028
            2. Assistance Agreement ; Title IV-E Adoption assistance agreement
            3. Provider 1 ID: 5018069
            Provider 1 Name: Garroll Mace
            4. Provider 2 ID: 5018069
            Provider 2 Name: Dawn Toner
            5. Adoptive Parent(1) Signature Date: 11/8/2007
            6. Adoptive Parent(2) Signature Date: 11/8/2007
            7. LDSS Director/Designee Signature Date: 11/8/2007
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid : Yes
            9. Adoptive Placement Child Placed From : Within State
            10. Child Placed By : Title IV-E Agency
            11. Submitted by (Worker Name): Ann Brown
            12. Approved by (Supervisor Name): Allison Mitchell 
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
set enddate = '2028-02-06 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-57995',
	updatedon = now()
where adoptionagreementid='b74b79fe-f118-4cbb-bf87-153c297e6f4f'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-57995'
where adoptionagreementrateid = 'b74b79fe-f118-4cbb-bf87-153c297e6f4f'
and activeflag = 1;    