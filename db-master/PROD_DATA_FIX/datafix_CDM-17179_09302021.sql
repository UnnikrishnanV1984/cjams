-- CDM-17179 - GAP agreement stuck in review
/*
-- Issue Description: 
   The GAP The Agreement has been updated and Approved, however, no payment has generated.
   
-- Case ID: 3286587
-- Client ID: 4217743 (JAYDEN SMITH) - 57241a00-0b40-4db4-bcd5-adce2bf2a0d1
-- GAP ID: 1005787 - 2021-06-30 To 2036-09-10 - 071a6fc8-7ed5-46ff-9792-84ccc42d2118
-- Provider ID: 5089089 (Yolanda Dale) 
-- PP ID: 96bdfeee-50e5-4f35-8e01-1d74effdff9f
   
-- Case ID: 3258466
-- Client ID: 3856846 (TERRELL JONES) - 3c3e1a15-508e-4615-a753-0e60ee72102a
-- GAP ID: 1005824 - 2021-06-28 To 2033-07-21 - 868befb5-07a2-4509-b016-d8f477a08904
-- Provider ID: 6001987	(TARSHA S Johnson)
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan -> intakeservicerequestactorid
-- af6d5f1f-8c78-41a2-b2e2-64004aa3fb6b - CHILD - Active
-- b89fc8d3-23de-4dda-bd71-dcebb631201d - AV - Inactive (current)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '96bdfeee-50e5-4f35-8e01-1d74effdff9f'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'dc08fba6-c28f-4939-93ea-268fd0ee65bb',
	updatedby = 'CDM-17179',
	updatedon = now()
where permanencyplanid = '96bdfeee-50e5-4f35-8e01-1d74effdff9f'
	and activeflag  = 1 ;
	
-- To update GAP Agreement status as Approved (as the GAP rate is already in Approved status)
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where eventcode = 'GAAR'
	and objectid = '92a925e5-c2c3-4d1f-b9c6-57ba98857dfc'
	and activeflag = 1
	and routingstatustypeid <> 16 ;
	
update routing
set activeflag = 0,
	updatedby = 'CDM-17179',
	updatedon = now()
where eventcode = 'GAAR'
	and objectid = '92a925e5-c2c3-4d1f-b9c6-57ba98857dfc'
	and activeflag = 1
	and routingstatustypeid <> 16 ;
	
	
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where eventcode = 'GAAR'
	and objectid = '92a925e5-c2c3-4d1f-b9c6-57ba98857dfc'
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
	(	gen_random_uuid(), 'GAAR', 'd2757853-26b7-4656-9189-c890ef76cbcb', 
		'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 'e8a55980-6200-4344-810f-7bef323920e4', 
		'CWSP', 'CWCW', '92a925e5-c2c3-4d1f-b9c6-57ba98857dfc', 16, 1, 
		'CDM-17179', now(), 'CDM-17179', now(), false, 
		NULL, NULL, 'Guardianship Agreement Submitted for review', '3286587', NULL
	);
	
	
-- To Trigger Under Over (GAP is having only 1 rate slab)
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '071a6fc8-7ed5-46ff-9792-84ccc42d2118'
	and coalesce(approvalstatustypekey, '') = '3047'
	-- and gapratesrevisionid  in ( ?? )
	and activeflag = 1 ;
	

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-17179',
	updatedon = now()
where guardiansubsidyid = '071a6fc8-7ed5-46ff-9792-84ccc42d2118'
	and coalesce(approvalstatustypekey, '') = '3047'
	-- and gapratesrevisionid  in ( ?? )
	and activeflag = 1 ;

