/*
Issue Description: CDM-44233: Adoption Switch Parent
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3183134
            1. Agreement End Date : 01/30/2027
            2. Assistance Agreement :State/Tribal Adoption Assistance Agreement
            3. Provider ID: 6177616
               Provider Name: Gary Ferko
            4. Child Placed By :Title IV-E Agency
            5. Submitted by (Worker Name): Melanie Adam
            6. Approved by (Supervisor Name): Calley Leimbach
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CDM-44233
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2027-01-30 00:00:00',
    agreementtyperefid = 'STAAA',
	childplacedby = 'iveag',
    providerid = 6177616,
    parent1providerid = 6177616,
    parent1providername = 'Gary Ferko',
    parent2providerid = null,  
	parent2providername = null,
	updatedby = 'CDM-44233',
	updatedon = now()
where adoptionagreementid='9aacd048-c37b-4d69-b7bc-77606042c35d'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CDM-44233'
where adoptionagreementrateid = '412c578a-601b-48a2-b17c-a6af5ce0d37f'
and activeflag = 1;