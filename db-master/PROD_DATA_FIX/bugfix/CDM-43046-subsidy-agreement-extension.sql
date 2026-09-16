/*
Issue Description: CDM-43046: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            1. Agreement end date: 08/26/2027
            2. Assistance Agreement: Title IV-E Adoption assistance agreement
            3. Child Placed By: Title IV-E Agency
            4. Submitted by (Worker Name): Rebecca Downs
            5. Approved by (Supervisor Name): Laura Joiner  
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CDM-43046
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2027-08-26 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CDM-43046',
	updatedon = now()
where adoptionagreementid='800c1b16-7000-4b13-b2ed-717c58b03ae7'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CDM-43046'
where adoptionagreementrateid = 'bd282988-5ce6-44ee-ada8-036aab20046e'
and activeflag = 1;    