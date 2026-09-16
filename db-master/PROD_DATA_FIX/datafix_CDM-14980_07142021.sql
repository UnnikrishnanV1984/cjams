-- CDM-14980 - Incorrect Suspension Date
/*
--	Issue Description: 
	User Request to changes to Adoption Suspensions 
    
	Remove the record which is under review (Transaction date - 07/12/2021)

	Update the record which is already approved (Transaction date- 01/01/2020 ) 
	update the suspension end date to 05/15/2021 
   
-- Adoption Case ID: 3204331 - rochelle.smith@maryland.gov
-- Cleint ID: 3277036 (DWAYNE RAE DAWSON) - 1f84d377-6e14-4be3-9ed5-98cf9570a4af
-- Adoption ID: 31863 - 2011-09-07 To 2024-07-28 - 9163778f-d1ab-4013-ba0e-01ef76aa310c
-- Provider ID: 5050189 (renda Dawson)

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete  
-- 969260d4-c9f2-49d1-a6a2-3d1a69a20a12	2020-01-01 To 2021-05-15 - Undre Review

select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '969260d4-c9f2-49d1-a6a2-3d1a69a20a12'
	and activeflag  = 1 ;
	
update adoptioncasesuspension
set suspensionbegindate = suspensionenddate,
	activeflag = 0,
	updatedby = 'CDM-14980',
	updatedon = now()
where adoptionsuspensionid = '969260d4-c9f2-49d1-a6a2-3d1a69a20a12'
	and activeflag  = 1 ;


select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
	from adoptioncasesuspensionrevision
where adoptionsuspensionid = '969260d4-c9f2-49d1-a6a2-3d1a69a20a12'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionbegindate = suspensionenddate,
	activeflag = 0,
	updatedby = 'CDM-14980',
	updatedon = now()
where adoptionsuspensionid = '969260d4-c9f2-49d1-a6a2-3d1a69a20a12'
	and activeflag = 1 ;	
	
-- Update
-- 975af2df-f8a3-4d09-83d0-a49c6c3a74f2	2020-01-01 To 2021-06-15 - Approved
--										2020-01-01 To 2021-05-15
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptionsuspensionid = '975af2df-f8a3-4d09-83d0-a49c6c3a74f2'
	and activeflag = 1 ;	
	
update adoptioncasesuspension
set suspensionenddate = '2021-05-15 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-14980',
	updatedon = now()
where adoptionsuspensionid = '975af2df-f8a3-4d09-83d0-a49c6c3a74f2'
	and activeflag = 1 ;	

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptionsuspensionid = '975af2df-f8a3-4d09-83d0-a49c6c3a74f2'
	and activeflag = 1 ;	

update adoptioncasesuspensionrevision
set suspensionenddate = '2021-05-15 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-14980',
	updatedon = now()
where adoptionsuspensionid = '975af2df-f8a3-4d09-83d0-a49c6c3a74f2' 
	and activeflag = 1 ;	


-- To trigger udre/over starting 05/15/2021
select startdate, enddate, paymentamout, status, approvaldate, updatedon, updatedby 
	from adoptioncaseagreementrate
where adoptionagreementrateid = '5b0e6a58-e8ae-4115-94d9-7ea895d4a34e'
	and activeflag  = 1
order by startdate ;

update adoptioncaseagreementrate
set updatedby = 'CDM-14980',
	updatedon = now()
where adoptionagreementrateid = '5b0e6a58-e8ae-4115-94d9-7ea895d4a34e'
	and activeflag  = 1 ;
