-- CDM-26459 - Subsidy
/*
-- Issue Description: 
   Adoption case Overlapping Rate slabs preventing New Rate entry
   
-- Adoption Case ID: 3148213
-- Client ID: 1931100 (ALAYNA ANDREWS) - e83244bd-129a-4b8e-b3af-4865e3b87634
-- Adoption ID: 15193 - 2006-09-05 To 2023-10-04 - 37c376e7-4a2c-4493-9e1d-a81c93dbe5bd
   
-- Category/ Module: Adoption (Case Management) 
-- Root cause: Migrated Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Fix the overlapping Rate Slabs
/*
-- Correct Rates
09/05/2006 - March 2008 = $635
Apr 2008 - Sept 2022 = $735

-- Current Rates
-- adoptionagreementrateid				startdate	enddate		paymentamout	
------------------------------------------------------------------------------------
eb8fb37e-7a46-49fc-a267-0577efff310a	2006-09-05	2022-09-05	635.00	Approved
-- eb8fb37e-7a46-49fc-a267-0577efff310a	2006-09-05	2022-03-31	635.00	Approved 
-- Update end date as 2022-03-31

e6cb0228-e56c-4ef2-80f3-10a7c0a7c751	2008-04-01	2009-09-05	735.00	Approved

b99ca260-f062-4aed-9673-93ed45105e7a	2009-09-01	2022-10-04	735.00	Review
-- b99ca260-f062-4aed-9673-93ed45105e7a	2009-09-06	2022-10-04	735.00	Review
-- Update Start date status as Approved and Start date as 2009-09-06 

-- Delete the rejected 
42b04278-a08f-47a6-8c28-09201b73f78e	2010-06-01	2022-10-04	735.00	Rejected
*/

-- Update end date as 2008-03-31
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'eb8fb37e-7a46-49fc-a267-0577efff310a'
	and activeflag = 1;

update adoptioncaseagreementrate
set -- startdate = '2006-09-05 00:00:00',
	enddate = '2008-03-31 00:00:00', -- 2022-09-05 00:00:00
	-- paymentamout = 635.00, 
	-- approvaldate = now(),
	updatedon = now(), -- 2007-06-21 16:56:43
	updatedby = 'CDM-26459' -- SBL276222
where adoptionagreementrateid = 'eb8fb37e-7a46-49fc-a267-0577efff310a'
	and activeflag = 1;

-- b99ca260-f062-4aed-9673-93ed45105e7a	2009-09-06	2022-10-04	735.00	Review
-- Update status as Approved and Start date as 2009-09-06 
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'b99ca260-f062-4aed-9673-93ed45105e7a'
	and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2009-09-06 00:00:00', -- 2009-09-01 00:00:00
	-- enddate = '2022-10-04 00:00:00',
	-- paymentamout = 735.00,
	-- approvaldate = now(),
	updatedon = now(), -- 2009-09-11 11:11:00
	updatedby = 'CDM-26459' -- JTR375822
where adoptionagreementrateid = 'b99ca260-f062-4aed-9673-93ed45105e7a'
	and activeflag = 1;
	
select startdate, enddate, approvalstatustypekey, status, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementrateid = 'b99ca260-f062-4aed-9673-93ed45105e7a' ;

update adoptioncaserevision
set startdate = '2009-09-06 00:00:00', -- 2009-09-01 00:00:00
	-- enddate = '2020-10-04 04:00:00',
	approvalstatustypekey = '3047',
	status= 'Approved',
	updatedon = now(), -- 2022-08-29 16:42:10
	updatedby = 'CDM-26459' -- 463361dc-9c6d-47e1-b101-c18960381b32
where adoptionagreementrateid = 'b99ca260-f062-4aed-9673-93ed45105e7a' ;

select eventcode, routingstatustypeid, activeflag, updatedby, updatedon
from routing
where objectid = 'b99ca260-f062-4aed-9673-93ed45105e7a'
	and routingid = '19227a08-dd7c-4336-9cb7-bd1c192936fb' 
	and activeflag = 1;
	
update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-26459' 
where objectid = 'b99ca260-f062-4aed-9673-93ed45105e7a'
	and routingid = '19227a08-dd7c-4336-9cb7-bd1c192936fb' 
	and activeflag = 1;
	
	
-- Rejected 
select startdate, enddate, approvaldate, paymentamout,status, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and activeflag = 1;

update adoptioncaseagreementrate	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-26459' 
where adoptionagreementrateid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and activeflag = 1;
	
select startdate, enddate, approvalstatustypekey, status, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementrateid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and activeflag = 1;

update adoptioncaserevision
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-26459' 
where adoptionagreementrateid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and activeflag = 1;

select eventcode, routingstatustypeid, activeflag, updatedby, updatedon
from routing
where objectid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and routingid = '87b92005-4540-444e-b4ca-d91b155924a1' 
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-26459' 
where objectid = '42b04278-a08f-47a6-8c28-09201b73f78e'
	and routingid = '87b92005-4540-444e-b4ca-d91b155924a1' 
	and activeflag = 1;
