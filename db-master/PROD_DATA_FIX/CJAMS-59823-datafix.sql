/*
Issue Description: CJAMS-59823: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: Data fix needed to make following changes in the adoption subsidy agreements for the case 3169586
            1. Agreement End Date : 06/28/2026
2. Assistance Agreement -

State/Tribal Adoption Assistance Agreement
3. Provider 1 ID: 5021634
Provider 1 Name: Anne McDorman

4. Provider 2 ID: 5021634
Provider 2 Name: Lee McDorman

5. Adoptive Parent(1) Signature Date: 12/09/2008
6. Adoptive Parent(2) Signature Date:12/09/2008
7. LDSS Director/Designee Signature Date: 1/12/2009  
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
set enddate = '2026-06-28 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-59823',
	updatedon = now()
where adoptionagreementid='c5e501a2-8d42-40a5-aa4d-a7e2eb38d8e0'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-59823'
where adoptionagreementrateid = 'e3685f9a-a543-48da-bfbb-5a4937d5113a'
and activeflag = 1;

update adoptioncase 
  set enddate = '2026-06-28 00:00:00',
      updatedby = 'CJAMS-59823',
	  updatedon = now()
where adoptioncaseid = '12b70a1f-0257-4f08-bce2-1a543226dd4f'	
  and activeflag = 1;
