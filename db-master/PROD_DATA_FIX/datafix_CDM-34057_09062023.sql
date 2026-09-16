-- CDM-34057 - Lost Purchase Authorizations
/*
-- Issue Description: 
   Finance is unable to locate the following Purchase Authorizations for approval on the FINANCE side.
  
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.
--				 Please ask the Baltimore City finance users to approve the same.				
-- Note: Create CIDM for the code fix.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the routing records (CDM-34057)

-- Case ID: 3304394
-- Client ID: 4335368 (ADEN ROBERTS) - e356244c-bb98-4d6b-9535-33e14689f910
-- Auth ID: 2474400 - Clothing Purchase (Paid) 
-- Provider ID: 5015695	(Forman Mills)

-- 0	41	Forwarded to Payment Approval	c545b512-67f6-43cf-8cf3-72e19e60db10	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'c545b512-67f6-43cf-8cf3-72e19e60db10'
	and objectid = '2474400'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = 'c545b512-67f6-43cf-8cf3-72e19e60db10'
	and objectid = '2474400'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;


-- Case ID: 211030009779
-- Client ID: 200789362 (Dyson L Williams) - 6f6ca394-b810-4c5b-928a-be4dbafdc607
-- Auth ID: 2475727 - Child Care (Paid)  
-- Provider ID: 55044034 (Woodlawn Recreation and Parks)

-- 0	41	Forwarded to Payment Approval	5c964519-8041-4174-823d-b4c5b0d57b07	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '5c964519-8041-4174-823d-b4c5b0d57b07'
	and objectid = '2475727'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = '5c964519-8041-4174-823d-b4c5b0d57b07'
	and objectid = '2475727'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

-- Case ID: 3259270
-- Client ID: 1640927 (ELENORA J MARSHALL) - 0e624701-b870-4b62-b344-6d474c2ff678
-- Auth ID: 2471305 - Rent Payments/Deposit (Paid)   
-- Provider ID: 6065474	(Brick Street Property Management)

-- 0	41	Forwarded to Payment Approval	d938c987-9b36-4e56-baee-19481c6eb064	PCAUTHR	
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'd938c987-9b36-4e56-baee-19481c6eb064'
	and objectid = '2471305'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = 'd938c987-9b36-4e56-baee-19481c6eb064'
	and objectid = '2471305'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
-- Other Impacted cases
-- 0	40	Forwarded to Funding Approval	f9151b08-7412-47d3-8c71-9a4861e5d6a7	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'f9151b08-7412-47d3-8c71-9a4861e5d6a7'
	and objectid = '2482412'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = 'f9151b08-7412-47d3-8c71-9a4861e5d6a7'
	and objectid = '2482412'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
-- 0	41	Forwarded to Payment Approval	39d85811-b49f-4d83-9def-ddedb23bc064	PCAUTHR
-- Baltimore City - Finance  31eabbb0-f686-41dc-94d3-a3c26b12043a
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '39d85811-b49f-4d83-9def-ddedb23bc064'
	and objectid = '2475130'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = '39d85811-b49f-4d83-9def-ddedb23bc064'
	and objectid = '2475130'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;

-- 0	41	Forwarded to Payment Approval	30db8663-113f-478f-a39b-c8e5856fa5b3	PCAUTHR
-- Howard - Finance - 48661136-51fe-4e97-ac66-1a0a658678cb
select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = '30db8663-113f-478f-a39b-c8e5856fa5b3'
	and objectid = '2461960'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
update routing
set activeflag = 1,
	updatedby = 'CDM-34057',
	updatedon = now()
where routingid = '30db8663-113f-478f-a39b-c8e5856fa5b3'
	and objectid = '2461960'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) ;
	
