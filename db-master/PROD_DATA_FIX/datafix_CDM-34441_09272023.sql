-- CDM-34441 - 9-25-23--please end date for 6-25-23
/*
-- Issue Description: 
	User request to change the suspension end date from 07/25/2023 to 06/25/2023.

-- Case ID: 3260057
-- New Provider ID: 6062329	(JOHN SHIPE) 
-- Old Provider ID: 5085937 (Gloria Shipe) 
-- Client ID: 3848233 (AMELIA ANCELL) - 0e454f2a-0d8a-404d-8e0d-d4541b01948e
-- GAP ID: 5391 - 2019-12-16 To 2033-08-31 - 0b5fcc6b-d6f1-46dd-b372-b2b0c7c80118
-- GAP Suspension: 2023-06-25 To 2023-07-25 - 12356246-b1bb-43bc-9732-ad26e2881160
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error
-- Fix provided: Datafix has been promoted to update the GAP suspension end date as 06/25/2023.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update the GAP suspension end date (CDM-34441)
-- GAP Suspension: 2023-06-25 To 2023-07-25 - 12356246-b1bb-43bc-9732-ad26e2881160
-- Update End Date as Start Date - 2023-06-25 04:00:00
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	updatedby = 'CDM-34441',
	updatedon = now()	
where gapsuspensionid  = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;

-- To Trigger Under/Over
select guardiansubsidyid, startdate, enddate, approvaldate, approvalstatustypekey, activeflag, updatedby, updatedon 
	from gapsuspensionrevision 
where suspensionid = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;
	
update gapsuspensionrevision
set enddate = startdate,
	approvaldate = now(),
	updatedby = 'CDM-34441',
	updatedon = now()	
where suspensionid = '12356246-b1bb-43bc-9732-ad26e2881160' 
	and activeflag = 1 ;

-- To Fix the GAP Rates
-- Update end date as 2023-06-26 08:00:00
-- 6062329	2023-07-26 08:00:00	2023-12-15 05:00:00	527bb8ca-7e10-4da6-880b-02e87f4c2b0d
select provider_id, startdate, enddate, paymentamout, gapagreementrateid, activeflag, updatedby, updatedon 
	from gapagreementrate
where gapagreementrateid = '527bb8ca-7e10-4da6-880b-02e87f4c2b0d'
	and activeflag = 1 ;
	
update gapagreementrate
set startdate = '2023-06-26 08:00:00',
	activeflag = 1,
	updatedby = 'CDM-34441', 
	updatedon = now() 	
where gapagreementrateid = '527bb8ca-7e10-4da6-880b-02e87f4c2b0d'
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, paymentamt, 
	activeflag, updatedby, updatedon
from gapratesrevision  
where gaprateid = '527bb8ca-7e10-4da6-880b-02e87f4c2b0d'
	and activeflag = 1 ;	

update gapratesrevision
set ratestartdate = '2023-06-26 08:00:00',
	-- approvaldate = now(),
	updatedby = 'CDM-34441', 
	updatedon = now() 	
where gaprateid = '527bb8ca-7e10-4da6-880b-02e87f4c2b0d'
	and activeflag = 1 ;	
	
-- Update provider ID as 5085937 (Gloria Shipe) and end date as 2023-06-25 04:00:00
-- 6062329	2022-12-16 10:00:00	2023-07-25 04:00:00	cc3c29a4-75a2-4ea0-bbed-f3223d8d7832
select provider_id, startdate, enddate, paymentamout, gapagreementrateid, activeflag, updatedby, updatedon 
	from gapagreementrate
where gapagreementrateid = 'cc3c29a4-75a2-4ea0-bbed-f3223d8d7832'
	and activeflag = 1 ;
	
update gapagreementrate
set provider_id = 5085937,
	enddate = '2023-06-25 04:00:00',
	activeflag = 1,
	updatedby = 'CDM-34441', 
	updatedon = now() 	
where gapagreementrateid = 'cc3c29a4-75a2-4ea0-bbed-f3223d8d7832'
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, paymentamt, 
	activeflag, updatedby, updatedon
from gapratesrevision  
where gaprateid = 'cc3c29a4-75a2-4ea0-bbed-f3223d8d7832'
	-- and activeflag = 1 
	;
	
update gapratesrevision
set providerid = 5085937,
	rateenddate = '2023-06-25 04:00:00',
	-- approvaldate = now(),
	updatedby = 'CDM-34441', 
	updatedon = now() 	
where gaprateid = 'cc3c29a4-75a2-4ea0-bbed-f3223d8d7832'
	-- and activeflag = 1 
	;	
