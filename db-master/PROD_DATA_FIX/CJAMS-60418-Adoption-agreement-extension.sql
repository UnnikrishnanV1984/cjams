/*
Issue Description: CJAMS-60418: Subsidy Agreement Extension 3170913Program says there are over lapping dates that will not allow me to extend subsidy to 21st birthday,Previously had same issue with case # 3163984
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3170913
1. Agreement End Date : 06/12/2028
2. Assistance Agreement - please select from below options; Title IV-E Adoption assistance agreement

3. Provider 1 ID: 5029927
Provider 1 Name: Sharon Donahue

4. Provider 2 ID: -
Provider 2 Name

5. Adoptive Parent(1) Signature Date: 01/15/2009
6. Adoptive Parent(2) Signature Date: 01/15/2009

7. LDSS Director/Designee Signature Date: 01/15/2009
8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options; Yes
9. Adoptive Placement Child Placed From - please select from below options; Within State
10. Child Placed By - please select from below options; Title IV-E
11. Submitted by (Worker Name): Amy Martini
12. Approved by (Supervisor Name); Jason Sammons
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-60418
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2028-06-12 00:00:00',
    parent2providerid = NULL,
    parent2providername = NULL,
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
    ldssdate = '2009-01-15 00:00:00',
	updatedby = 'CJAMS-60418',
	updatedon = now()
where adoptionagreementid='9edc2e61-94a4-4ce5-a49e-15ffe7b9659f'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-60418'
where adoptionagreementrateid = 'adb66c1e-3e65-4f22-9dd2-92f4f8177d2d'
and activeflag = 1;    


update adoptioncase
set enddate = '2028-06-30 00:00:00',
	updatedby = 'CJAMS-60418',
	updatedon = now()
where adoptioncaseid='e9d0d751-12df-4ca7-8fe7-e0ace6e55fa6'
and activeflag = 1;