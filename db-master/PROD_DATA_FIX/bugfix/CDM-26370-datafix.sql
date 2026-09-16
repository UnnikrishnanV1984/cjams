-- CDM-26370 - VPA Second Signature Needed
/*
-- Issue Description: 
	1. User requested to update dates for Client 2011708
		mother signature date as - 9/30/2021
		Father signature date as - 10/19/2021
		Please remove the Agency signed date 
	2. update 2nd parent missing signature reason for Client 3232890
			- Unable to locate the adoptive father 

-- Category/ Module: Child Removal
-- Root cause: User Request
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Client Id 2011708
select 	activeflag , vpaparentssigneddate , parent2signeddate , isbothparentssigned , agencysigneddate, parent1id , parent2id, * from Intakeservreqchildremoval
where 	intakeservreqchildremovalid = '4ba6f9ea-6de0-4de3-b07f-762b82bb9c2b';

update 	Intakeservreqchildremoval
set 	vpaparentssigneddate = '2021-09-30',
		parent2signeddate = '2021-10-19',
		agencysigneddate = null,
		parent2id = '2011693',
		updatedby = 'CDM-26370',
		updatedon = now()
where 	intakeservreqchildremovalid = '4ba6f9ea-6de0-4de3-b07f-762b82bb9c2b';

--Client Id 3232890
select 	activeflag , parent2comments , * from Intakeservreqchildremoval
where  	intakeservreqchildremovalid = '7705da6d-1514-4175-9e1b-744cd03b85f5';

update 	Intakeservreqchildremoval
set 	parent2comments = 'Unable to locate the adoptive father',
		isbothparentssigned = 2,
		updatedby = 'CDM-26370',
		updatedon = now()
where 	intakeservreqchildremovalid = '7705da6d-1514-4175-9e1b-744cd03b85f5';