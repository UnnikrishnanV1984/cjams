-- CDM-16663 - New Gap No-payment-3258466
/*
-- Issue Description: 
   The GAP The Agreement has been updated and Approved, however, no payment has generated.
   
-- Case ID: 3258466
-- Client ID: 3856846 (TERRELL JONES) - 3c3e1a15-508e-4615-a753-0e60ee72102a
-- GAP ID: 1005824 - 2021-06-28 To 2033-07-21 - 868befb5-07a2-4509-b016-d8f477a08904
-- Provider ID: 6001987	(TARSHA S Johnson)
-- PP ID: f95f0b42-8fbf-4fcc-bbc6-377645674d54
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- dc08fba6-c28f-4939-93ea-268fd0ee65bb - CHILD - Active
-- 7d6b82d2-8348-45f2-a4cf-43b36473f361 - AV - Inactive (current)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'f95f0b42-8fbf-4fcc-bbc6-377645674d54'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'dc08fba6-c28f-4939-93ea-268fd0ee65bb',
	updatedby = 'CDM-16663',
	updatedon = now()
where permanencyplanid = 'f95f0b42-8fbf-4fcc-bbc6-377645674d54'
	and activeflag  = 1 ;
	
-- To update GAP Agreement status as Approved (as the GAP rate is already in Approved status)
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where eventcode = 'GAAR'
	and objectid = '0ff6b79e-9644-4be7-a90a-4d5dba716c5d'
	and activeflag = 1
	and routingstatustypeid <> 16 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-16663',
	updatedon = now()
where eventcode = 'GAAR'
	and objectid = '0ff6b79e-9644-4be7-a90a-4d5dba716c5d'
	and activeflag = 1
	and routingstatustypeid <> 16 ;
	
	
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where eventcode = 'GAAR'
	and objectid = '0ff6b79e-9644-4be7-a90a-4d5dba716c5d'
	and activeflag = 1
	and routingstatustypeid = 16 ;

insert into cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey 
	)
values
	(	gen_random_uuid(), 'GAAR', '48602c12-8998-48d1-84e5-1aebbf761ceb', 
		'ceca7825-35d6-41bb-bfc9-df3256d9a1d9', 'b50f2419-42ba-4ab6-84ab-5172917d2d77', 
		'CWSP', 'CWCW', '0ff6b79e-9644-4be7-a90a-4d5dba716c5d', 16, 1, 
		'CDM-16663', now(), 'CDM-16663', now(), false, 
		NULL, NULL, 'Guardianship Agreement Submitted for review', '3258466', NULL
	);
	
	
-- To Trigger Under Over (GAP is having only 1 rate slab)
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '868befb5-07a2-4509-b016-d8f477a08904'
	and coalesce(approvalstatustypekey, '') = '3047'
	-- and gapratesrevisionid  in ( ?? )
	and activeflag = 1 ;
	

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-16663',
	updatedon = now()
where guardiansubsidyid = '868befb5-07a2-4509-b016-d8f477a08904'
	and coalesce(approvalstatustypekey, '') = '3047'
	-- and gapratesrevisionid  in ( ?? )
	and activeflag = 1 ;
