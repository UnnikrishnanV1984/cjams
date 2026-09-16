-- CDM-30758 Adoption subsidy rate
/*
-- Issue Description: 
   Adoption case Overlapping Rate slabs preventing New Rate entry
   
-- Adoption Case ID: 3153577
-- Client ID: 2049009 (KIRALYN KRAMER) - 87c52cee-2817-4017-b1ab-a2d4caaae9e3
-- Provider ID: 5024074	Janice Kramer
-- Adoption ID: 16222 - 2006-12-22 To 2023-09-30 - fcffed18-2ff9-4665-89fe-a959efe9c8a9
-- Rates
-- fcf54864-ab86-4b3f-9a16-eab3785ea093	2007-12-23	2008-12-31	635.00 -- Update End date 2008-03-31 
-- 7c8eb958-cc6d-4e5a-bbe6-7c8c744edd3d	2008-04-01	2023-04-24	635.00 -- Trigger under over
   
-- Category/ Module: Adoption (Case Management) 
-- Root cause: Migrated Data Issue
-- Fix provided: Datafix has been promoted to fix the Overlapping Rate slabs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update end date as 2008-03-31 
-- fcf54864-ab86-4b3f-9a16-eab3785ea093	2007-12-23	2008-12-31	635.00 
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'fcf54864-ab86-4b3f-9a16-eab3785ea093'
	and activeflag = 1;

update adoptioncaseagreementrate
set -- startdate = '2007-12-23 00:00:00.000',
	enddate = '2008-03-31 00:00:00', -- 2008-12-31 00:00:00.000
	-- paymentamout = 635.00, 
	-- approvaldate = now(),
	updatedon = now(), -- 2008-04-10 10:02:36.000
	updatedby = 'CDM-30758' -- MTU014621
where adoptionagreementrateid = 'fcf54864-ab86-4b3f-9a16-eab3785ea093'
	and activeflag = 1;

-- To void incorrect  ARs
-- 7c8eb958-cc6d-4e5a-bbe6-7c8c744edd3d	2008-04-01	2023-04-24	635.00 -- Trigger under over
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '7c8eb958-cc6d-4e5a-bbe6-7c8c744edd3d'
	and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(), -- 2008-04-24 15:42:06.000
	updatedby = 'CDM-30758' -- MTU014621
where adoptionagreementrateid = '7c8eb958-cc6d-4e5a-bbe6-7c8c744edd3d'
	and activeflag = 1;
