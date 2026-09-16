-- CDM-15117 - Subsidy agreement issue
/*
-- Issue Description: 
	The subsidy agreement needs to the status changed to approved. 
	There are no payments going out to the family. 
	   
-- Case ID: 3209302

-- Client ID: 4068939 (JAELYN M	HERNANDEZ) - b3859dae-3332-4be6-9952-57427ebe0955
-- GAP ID: 1005549 - 2020-10-29 To 2036-06-28 - 564c9bc3-a620-48d9-b6a2-a469acdb76dc	

-- Cleint ID: 4068940 (JEREMIAH	HERNANDEZ) - 017435ed-c45c-413d-a790-6ed6369e80dd
-- GAP ID: 1005550 - 2020-10-29 - 2037-12-04 - 58bda90a-c826-415d-82b4-f2ace66ebf71		

-- Category/ Module: GAP  (Case Management) 
-- Root cause: This GAP Agreement Rate was approved and GAP Agreement was Rejected.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 4068939 (JAELYN M	HERNANDEZ) - b3859dae-3332-4be6-9952-57427ebe0955
-- GAP ID: 1005549 - 2020-10-29 To 2036-06-28 - 564c9bc3-a620-48d9-b6a2-a469acdb76dc	

insert into cjams.gapagreementrevision
(	gapagreementrevisionid, gapagreementid, gapid, 
	iscomprehensivehomestudy, iscgawardedcustody, isplacementenddate, ischildreceivetca, startdate, 
	enddate, signaturedate, guardianonedate, guardiantwodate, ldssdate, 
	activeflag, effectivedate, insertedby, insertedon, updatedby, 
	updatedon, old_id, tcaamount, isfianotified, fianotifieddate, isrcnotifiedcontact, 
	iscsnotifiedtocustody, approvalstatustypekey, approvaldate
)
values
(	gen_random_uuid(),  'ca3188dd-9cf2-41bc-a9d4-96ab227afdc2'::uuid, '564c9bc3-a620-48d9-b6a2-a469acdb76dc'::uuid, 
	true, NULL, true, false, '2020-10-29 04:00:00.000', 
	'2036-06-28 04:00:00.000', NULL, '2020-10-20 04:00:00.000', NULL, '2020-10-20 04:00:00.000', 
	1, '2021-01-07 15:33:44.000', 'CDM-15117', now(), 'CDM-15117', 
	now(), NULL, NULL, 0, NULL, 
	0, 0, '3047', now()
);

update gapagreementrevision 
set approvaldate = now(),
	activeflag  = 0,
	updatedby = 'CDM-15117',
	updatedon = now()
where gapid = '564c9bc3-a620-48d9-b6a2-a469acdb76dc'
	and approvalstatustypekey  = '3045'
	and activeflag = 1 ;

select routingstatustypeid, updatedby, updatedon 
	from routing 
where objectid =  'ca3188dd-9cf2-41bc-a9d4-96ab227afdc2'
	and routingid  = '94205b1b-7f8b-435b-ae48-36643b3bbcee'
	and activeflag  = 1 ;

update routing 
set routingstatustypeid = '16',
	updatedby = 'CDM-15117',
	updatedon = now()
where objectid = 'ca3188dd-9cf2-41bc-a9d4-96ab227afdc2'
	and routingid = '94205b1b-7f8b-435b-ae48-36643b3bbcee'
	and activeflag = 1 ;


-- Remove the Rejected Rate
select activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid  = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-15117',
	updatedon = now()
where gapagreementrateid  = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag  = 1 ;

select activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag  = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-15117',
	updatedon = now()
where gaprateid = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag  = 1 ;


select activeflag, updatedby, updatedon 
	from routing 
where objectid  = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CDM-15117',
	updatedon = now()
where objectid  = 'f7896fb1-b065-43d1-a479-191f4ec6d019'
	and activeflag = 1;

-- Client ID: 4068940 (JEREMIAH	HERNANDEZ) - 017435ed-c45c-413d-a790-6ed6369e80dd
-- GAP ID: 1005550 - 2020-10-29 - 2037-12-04 - 58bda90a-c826-415d-82b4-f2ace66ebf71		

insert into cjams.gapagreementrevision
(	gapagreementrevisionid, gapagreementid, gapid, 
	iscomprehensivehomestudy, iscgawardedcustody, isplacementenddate, ischildreceivetca, startdate, 
	enddate, signaturedate, guardianonedate, guardiantwodate, ldssdate, 
	activeflag, effectivedate, insertedby, insertedon, updatedby, 
	updatedon, old_id, tcaamount, isfianotified, fianotifieddate, isrcnotifiedcontact, 
	iscsnotifiedtocustody, approvalstatustypekey, approvaldate
)
values
(	gen_random_uuid(), 'd9b11e6c-2699-4ab1-b457-56c18cbdfedd'::uuid, '58bda90a-c826-415d-82b4-f2ace66ebf71'::uuid, 
	true, NULL, true, false, '2020-10-29 04:00:00.000', 
	'2037-12-04 05:00:00.000', NULL, '2020-10-20 04:00:00.000', NULL, '2020-10-20 04:00:00.000', 
	1, '2021-01-07 15:37:12.000', 'CDM-15117', now(), 'CDM-15117', 
	now(), NULL, NULL, 0, NULL, 
	0, 0, '3047', now()
);

update gapagreementrevision 
set approvaldate = now(),
	activeflag  = 0,
	updatedby = 'CDM-15117',
	updatedon = now()
where gapid = '58bda90a-c826-415d-82b4-f2ace66ebf71'
	and approvalstatustypekey  = '3045'
	and activeflag = 1  ;

select routingstatustypeid, updatedby, updatedon 
	from routing 
where objectid = 'd9b11e6c-2699-4ab1-b457-56c18cbdfedd'
	and routingid = 'c41ae27d-20c7-42fb-be34-993111940bcd'
	and activeflag = 1 ;

update routing 
set routingstatustypeid = '16',
	updatedby = 'CDM-15117',
	updatedon = now()
where objectid = 'd9b11e6c-2699-4ab1-b457-56c18cbdfedd'
	and routingid = 'c41ae27d-20c7-42fb-be34-993111940bcd'
	and activeflag = 1 ;

