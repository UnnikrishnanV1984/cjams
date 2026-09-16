/*
Issue Description: CJAMS-60392: Subsidy Agreement Extension 3165077:Naomi Molder - CJAMS #- 3165077Cannot extend the subsidy end date to reflect the 21st birthday
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3163984
1. Agreement End Date : 7/29/2028
2. Assistance Agreement - please select from below options
Title IV-E Adoption assistance agreement
3. Provider 1 ID: 5007418
Provider 1 Name: Pauline Molder
4. Provider 2 ID:
Provider 2 Name N/A
5. Adoptive Parent(1) Signature Date: Date is there - 7/22/2008
6. Adoptive Parent(2) Signature Date: Date is there - 7/22/2008
7. LDSS Director/Designee Signature Date: Date is there - 7/30/2008
8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options;
Yes
9. Adoptive Placement Child Placed From - please select from below options;
Within State
10. Child Placed By - please select from below options;
Title IV-E Agency
11. Submitted by (Worker Name): Kathy Ballard
12. Approved by (Supervisor Name); Jecelyn Litzenberger
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-60392
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-07-29 00:00:00',
    parent2providerid = NULL,
    parent1providername = 'PAULINE  MOLDER',
    parent2providername = NULL,
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-60392',
	updatedon = now()
where adoptionagreementid='177af591-1053-4f74-a5b8-d47ef702e822'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-60392'
where adoptionagreementrateid = '9cb86205-8ffd-4ff7-b99d-59c0d921f424'
and activeflag = 1;    


update adoptioncase
set enddate = '2028-07-29 00:00:00',
	updatedby = 'CJAMS-60392',
	updatedon = now()
where adoptioncaseid='6713e3c1-e557-43d2-b8ca-9cf111ee358e'
and activeflag = 1;