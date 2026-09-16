-- CDM-16666 - Finance
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Authorization ID: 1781842 
-- Case ID: 3216935
-- Client ID: 2886087 (ARIANNA LEIGH MORGAN) - 5244a821-79a3-4f25-aff3-57c33538855d
-- Srevice Log ID: 1981054 - Child Care (Paid) 
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	39	Forwarded to Case Supervisor	07495039-6f34-41ee-950f-f3866d03ff02
-- 1	40	Forwarded to Funding Approval	b258a69f-0af6-4de3-84cd-4d146ecbc942
-- 1	40	Forwarded to Funding Approval	27efc859-cb49-492d-b99f-2d197e94e2a5
-- 1	40	Forwarded to Funding Approval	4c965920-05fd-47b2-8f03-1863e86970f8
-- 1	40	Forwarded to Funding Approval	9de5ee56-fb8a-4684-a9cf-03e34ce6a3c3
-- 1	40	Forwarded to Funding Approval	7f3a6d48-19eb-47af-8fe0-24b54bb2b120
-- 1	40	Forwarded to Funding Approval	8cab7c92-fa6f-41d5-be4c-d92dcea734be

select activeflag, routingstatustypeid, remarks,  *
	from routing 
where routingid  in
	(	'07495039-6f34-41ee-950f-f3866d03ff02', 'b258a69f-0af6-4de3-84cd-4d146ecbc942', 
		'27efc859-cb49-492d-b99f-2d197e94e2a5', '4c965920-05fd-47b2-8f03-1863e86970f8', 
		'9de5ee56-fb8a-4684-a9cf-03e34ce6a3c3', '7f3a6d48-19eb-47af-8fe0-24b54bb2b120', 
		'8cab7c92-fa6f-41d5-be4c-d92dcea734be'
	)
	and objectid = '1781842'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'07495039-6f34-41ee-950f-f3866d03ff02', 'b258a69f-0af6-4de3-84cd-4d146ecbc942', 
		'27efc859-cb49-492d-b99f-2d197e94e2a5', '4c965920-05fd-47b2-8f03-1863e86970f8', 
		'9de5ee56-fb8a-4684-a9cf-03e34ce6a3c3', '7f3a6d48-19eb-47af-8fe0-24b54bb2b120', 
		'8cab7c92-fa6f-41d5-be4c-d92dcea734be'
	)
	and objectid = '1781842'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;

