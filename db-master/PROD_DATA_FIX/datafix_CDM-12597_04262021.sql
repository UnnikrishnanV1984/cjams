-- CDM-12597 - Suspension date correction
/*
-- Issue Description: 
   User Request to change the Adoption Suspension Start date as 2/16/2021 (old value 2021-04-16)
   
   Adoption Case ID: 3279944 
   Client ID: 4129752 (JAYDEN MAHAMADOUN COSSEY) - 29b7b1f8-9c53-428d-8adc-39ea8e37eec3
   Adoption ID: 47686 - 2017-08-17 to 2031-11-23 - e15afb4c-ff3c-4a6b-ac9e-e1460005887f
   Provider ID: 5021217	Yvonne Hedgmon-cossey
 
-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Error	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update Adoption Suspension Start date as 2/16/2021 (old value 2021-04-16)
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' 
	and adoptionsuspensionid = '86dafd8b-e972-49e1-ac4b-80a0b851c4b3' ;

update adoptioncasesuspension
set suspensionbegindate = '2021-02-16 04:00:00',
	updatedby = 'CDM-12597',
	updatedon = now()
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' 
	and adoptionsuspensionid = '86dafd8b-e972-49e1-ac4b-80a0b851c4b3' ;


select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' 
	and adoptionsuspensionid = 'c910aab4-7218-470f-9bd0-739d8f7164e3' ;

update adoptioncasesuspension
set suspensionbegindate = '2021-02-16 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-12597',
	updatedon = now()
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' 
	and adoptionsuspensionid = 'c910aab4-7218-470f-9bd0-739d8f7164e3' ;


select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' ;

update adoptioncasesuspensionrevision
set suspensionbegindate = '2021-02-16 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-12597',
	updatedon = now()
where adoptioncaseid = 'e15afb4c-ff3c-4a6b-ac9e-e1460005887f' ;
