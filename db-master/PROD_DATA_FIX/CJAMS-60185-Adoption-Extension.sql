/*
Issue Description: CJAMS-60185: 3170347:Unable to extent adoption subsidy end date to 5/4/2026 for Samara Lenz
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3170347
1. Agreement End Date : 05/04/2027
2. Assistance Agreement - please select from below options IV-E

Title IV-E Adoption assistance agreement
3. Provider 1 ID: 5020261
Provider 1 Name: Jeffrey Lenz

4. Provider 2 ID: 5020261
Provider 2 Name Sheryl Jessop

5. Adoptive Parent(1) Signature Date: 12/10/2008
6. Adoptive Parent(2) Signature Date: 12/10/2008
7. LDSS Director/Designee Signature Date: 12/10/2008
8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options;

Yes
9. Adoptive Placement Child Placed From - please select from below options;

Within State
10. Child Placed By - please select from below options;

Title IV-E Agency
11. Submitted by: Ann Brown
12. Approved by: Allison Mitchell
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-60185
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2027-05-04 00:00:00',
	updatedby = 'CJAMS-60185',
	updatedon = now()
where adoptionagreementid='b0a60a44-8a82-4b9a-8218-d56e905452a7'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-60185'
where adoptionagreementrateid = 'e0a2d39d-abc3-44af-8f55-373c8abb3814'
and activeflag = 1;    


update adoptioncase
set enddate = '2027-05-04 00:00:00',
	updatedby = 'CJAMS-60185',
	updatedon = now()
where adoptioncaseid='a2c638dc-cf88-4534-a898-1b809000b88b'
and activeflag = 1;