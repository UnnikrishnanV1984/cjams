/*
Issue Description: CJAMS-58181: Adoption subsidy payment
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3154952
            1. Agreement End Date : 3/23/2028
            2. Assistance Agreement: Title IV-E Adoption assistance agreement
            3. Provider 1 ID:5032479
            Provider 1 Name: Michael Altman
            4. Provider 2 ID:5032479
            Provider 2 Name: Brandy Altman
            5. Adoptive Parent(1) Signature Date: 9/25/2009
            6. Adoptive Parent(2) Signature Date: 9/25/2009
            7. LDSS Director/Designee Signature Date: 9/25/2009
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid ; - Yes
            9. Adoptive Placement Child Placed From ; - Within State
            10. Child Placed By ; - Title IV-E Agency
            11. Submitted by (Worker Name): Ann Brown
            12. Approved by (Supervisor Name); Allison Mitchell 
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-58181
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-03-23 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
    parent1signdate = '2009-09-25 00:00:00.000',
    parent2signdate = '2009-09-25 00:00:00.000',
    ldssdate = '2009-09-25 00:00:00.000',
	updatedby = 'CJAMS-58181',
	updatedon = now()
where adoptionagreementid='180e0554-1826-4e38-8ab6-cb5f38ca7486'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58181'
where adoptionagreementrateid = '5bbed02f-db41-4efa-ae64-22fda79b3ad1'
and activeflag = 1;    


update adoptioncase
set enddate = '2028-03-23 00:00:00',
	updatedby = 'CJAMS-58181',
	updatedon = now()
where adoptioncaseid='b285d3f9-b0b8-49c7-bb54-4d4e141d87a8'
and activeflag = 1;
