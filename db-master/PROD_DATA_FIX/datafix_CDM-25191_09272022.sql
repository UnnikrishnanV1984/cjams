-- CDM-25191 - Back payment
/*
-- Issue Description: 
   To Fix Adoption Suspension End date & Overlapping Rate Dates 
      
-- Case ID: 3225387
-- Adoption ID: 37257 - 2013-06-27 To 2025-07-04 - 4905e484-3cc8-4feb-beda-aa0d7eb21727
-- Client ID: 3538224 (MEGAN LOUISE	WALLACE) - 6608a233-f447-4cdb-9873-33eb064fa5e4

-- Category/ Module: Adoption (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update Adoption Suspension End date as 08/01/2021 (Old Value 2022-06-01 04:00:00)
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, 
	approvalstatustypekey, approvaldate, updatedby, updatedon, activeflag
from adoptioncasesuspension
where adoptioncaseid = '4905e484-3cc8-4feb-beda-aa0d7eb21727' 
	and adoptionsuspensionid = '9bfe3a64-d2a6-456d-8084-8f47a00a8ae3' ;

update adoptioncasesuspension
set suspensionenddate = '2021-08-01 04:00:00',
	updatedby = 'CDM-25191',
	updatedon = now()
where adoptioncaseid = '4905e484-3cc8-4feb-beda-aa0d7eb21727' 
	and adoptionsuspensionid = '9bfe3a64-d2a6-456d-8084-8f47a00a8ae3' ;

select adoptionsuspensionid, approvalstatustypekey, approvaldate,
    suspensionbegindate, suspensionenddate, updatedby, updatedon, activeflag  
from adoptioncasesuspensionrevision
where adoptioncaseid = '4905e484-3cc8-4feb-beda-aa0d7eb21727' 
	and adoptionsuspensionid = '9bfe3a64-d2a6-456d-8084-8f47a00a8ae3' ;

update adoptioncasesuspensionrevision
set suspensionenddate = '2021-08-01 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-25191',
	updatedon = now()
where adoptioncaseid = '4905e484-3cc8-4feb-beda-aa0d7eb21727' 
	and adoptionsuspensionid = '9bfe3a64-d2a6-456d-8084-8f47a00a8ae3' ;

-- Fix Rates
-- Delete 
-- 8e31d8ee-1cd7-414a-a5e8-b007c9a6391d	2022-06-01 08:00:00	2022-06-01 04:00:00	5049141	835
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '8e31d8ee-1cd7-414a-a5e8-b007c9a6391d'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '8e31d8ee-1cd7-414a-a5e8-b007c9a6391d'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon, activeflag 
	from adoptioncaserevision
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '8e31d8ee-1cd7-414a-a5e8-b007c9a6391d' 
	and activeflag = 1 ;

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '8e31d8ee-1cd7-414a-a5e8-b007c9a6391d' 
	and activeflag = 1 ;

-- Update End date as 2021-07-31 04:00:00
-- 78c4d71e-5779-4ccf-a18b-1e74d48dba96	2021-06-01 04:00:00	2022-05-31 04:00:00	5049141	835
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '78c4d71e-5779-4ccf-a18b-1e74d48dba96'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set enddate = '2021-07-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '78c4d71e-5779-4ccf-a18b-1e74d48dba96'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon, activeflag 
	from adoptioncaserevision
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '78c4d71e-5779-4ccf-a18b-1e74d48dba96' 
	and activeflag = 1 ;

update adoptioncaserevision
set enddate = '2021-07-31 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '78c4d71e-5779-4ccf-a18b-1e74d48dba96' 
	and activeflag = 1 ;
	

-- Update Start date as 2021-08-01 05:00:00 and End date as 2022-07-31 16:00:00
-- 67c5cb34-5604-4ee8-8330-5d4830fda9e7	2022-01-01 05:00:00	2023-06-01 16:00:00	6005979	835
-- Trigger Under Over

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '67c5cb34-5604-4ee8-8330-5d4830fda9e7'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set startdate = '2021-08-01 05:00:00',
	enddate = '2022-07-31 16:00:00',
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '67c5cb34-5604-4ee8-8330-5d4830fda9e7'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon, activeflag 
	from adoptioncaserevision
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '67c5cb34-5604-4ee8-8330-5d4830fda9e7' 
	and activeflag = 1 ;

update adoptioncaserevision
set startdate = '2021-08-01 05:00:00',
	enddate = '2022-07-31 16:00:00',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-25191'
where adoptionagreementid = '1a23c67c-cfdd-4231-8fac-374f2c2b5a7c'
	and adoptionagreementrateid = '67c5cb34-5604-4ee8-8330-5d4830fda9e7' 
	and activeflag = 1 ;
