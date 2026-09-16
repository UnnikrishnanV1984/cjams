/*
Issue Description: CJAMS-58526: Subsidy Agreement Extension 3163984:Getting Error message below when I try to extend the adoption Subsidy 
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3163984
            1. Agreement End Date : 03/25/2028
            2. Assistance Agreement - please select from below options: State/Tribal Adoption Assistance Program
            3. Provider 1 ID: 5002031
               Provider 1 Name: Maurice Sleby
            4. Provider 2 ID: 5002031
               Provider 2 Name Gale Selby
            5. Adoptive Parent(1) Signature Date: 2/12/25
            6. Adoptive Parent(2) Signature Date: N/A
            7. LDSS Director/Designee Signature Date: 3/21/25
            8. Adoptive Parent(s) indicate that they would only be able to adopt if a Subsidy is paid - please select from below options: Yes
            9. Adoptive Placement Child Placed From - please select from below options: Within State
            10. Child Placed By - please select from below options Title IV Agency.
            11. Submitted by (Worker Name): Amy Martini
            12. Approved by (Supervisor Name); Jason Sammons
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CJAMS-58526
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2028-03-25 00:00:00',
    agreementtyperefid = 'STAAA',
	childplacedby = 'iveag',
    parent1signdate = '2025-02-12 00:00:00.000',
    parent2signdate = NULL,
    ldssdate = '2025-03-21 00:00:00.000',
	updatedby = 'CJAMS-58526',
	updatedon = now()
where adoptionagreementid='f34aa2f4-3a0f-4377-901a-daae1905c926'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-58526'
where adoptionagreementrateid = 'd91b5564-f4a1-4cee-b451-c416816e6fb9'
and activeflag = 1;    


update adoptioncase
set enddate = '2028-03-25 00:00:00',
	updatedby = 'CJAMS-58526',
	updatedon = now()
where adoptioncaseid='15fccfa7-b6c7-45b3-b586-bfa99c8906b3'
and activeflag = 1;
