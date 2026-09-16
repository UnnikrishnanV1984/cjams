/*
Issue Description: CDM-43046: Subsidy Agreement Extension
Category/Module: Payments/ Adoption subsidy
Root cause: User requested for Data fix in the adoption subsidy agreements for the case 3170094
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
*/


update adoptioncaseagreement 
set enddate = '2027-12-22 00:00:00',
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	parent1signdate= '2009-07-11',
	parent2signdate ='2009-07-11',
	ldssdate ='2009-09-17',
	updatedby = 'CDM-43430',
	updatedon = now()
where adoptionagreementid='55ac0aaa-7475-495b-b2b3-fc2590c78a05'
and activeflag = 1;


update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CDM-43430'
where adoptionagreementrateid = 'a0d1b3a8-34a1-4338-8233-b1e67b0f4c08'
and activeflag = 1;    


update adoptioncase
set enddate = '2027-12-22 00:00:00', updatedby='CDM-43430', updatedon = now()
where adoptioncaseid ='87e8355e-ffbe-4f15-9e3c-7afd4d4d2325'
and activeflag = 1;