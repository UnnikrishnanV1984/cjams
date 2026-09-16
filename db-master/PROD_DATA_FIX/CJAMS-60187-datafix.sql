/*
Issue Description: CJAMS-60187: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            1. Agreement End Date: 4/7/2028

2. Assistance Agreement - please select from below option:
Title IV-E Adoption assistance agreement
3. Provider 1 ID: 5003608
Provider 1 Name: Lisa Russell
4. Provider 2 ID: N/A
Provider 2 Name: N/A
5. Adoptive Parent(1) Signature Date: 11/16/2009
6. Adoptive Parent(2) Signature Date: 11/16/2009
7. LDSS Director/Designee Signature Date: 11/16/2009
8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options;
Yes
9. Adoptive Placement Child Placed From - please select from below options;
Within State
10. Child Placed By - please select from below options;
Title IV-E Agency
11. Submitted by (Worker Name): Brielle Ritter
12. Approved by (Supervisor Name); Shawntese Charles 
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-60187
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaseagreement 
set enddate = '2028-04-07 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-60187',
	updatedon = now()
where adoptionagreementid='a92a4b31-5637-4845-b177-7c747d7b255b'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-60187'
where adoptionagreementrateid = 'e26974d5-c6a9-40f7-9560-b0ac64c566ef'
and activeflag = 1; 

update adoptioncase 
set enddate = '2028-04-07 00:00:00',
	updatedby = 'CJAMS-60187',
	updatedon = now()
where adoptioncaseid = '194d409f-262d-4cfb-87f2-09300f058e70'
and activeflag = 1;
