-- CDM-34800 - Daycare Payment
/*
-- Issue Description: 
   Users are unable to locate the following Purchase Authorizations for approval on the FINANCE side.
  

-- Case ID: 3299449
-- Client ID: 200771687	(Nevaeh Short) - 96784a8f-d646-49ae-82f0-a1a85dbb7ea4
-- Provider ID: 6005440	(Sharlene Hauck) 
-- Authorization ID: 2532900 - 2023-08-01 To 2023-08-31 - $1150.00 
-- Child Care- Formal (Paid)
  
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record for Purchase Authorization)
-- Fix Provided: Datafix has been promoted to fix the routing data.
-- Note: We are working on the RCA and will do the code fix with CIDM-7885
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

No fix is required 
Payment ID 3760558 was generated in CJAMS on 10/23/2023.

*/
		
-- Other impacted Authorizations:		

-- case_id		client_id		provider_id	provider_nm					service_nm										
--------------------------------------------------------------------------------------------------------------------
-- 3292149			3889682		5017672		Charles County DSS			Semi-Independent Living Room and Board (Paid)
-- authorization_id		service_log_id	start_dt	end_dt			cost_no
-- 2635668				2714227			2023-12-01	2023-12-02		650.00
-- 0	41	Forwarded to Payment Approval	47e89954-99b3-4c6e-9b60-9baa9e7d6941
-- Charles County 

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro
where routingid = '47e89954-99b3-4c6e-9b60-9baa9e7d6941'
	and objectid = '2635668'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
	
update routing ro
set activeflag = 1,
	updatedby = 'CDM-34800',
	updatedon = now()
where routingid = '47e89954-99b3-4c6e-9b60-9baa9e7d6941'
	and objectid = '2635668'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
		
-- case_id		client_id		provider_id	provider_nm					service_nm										
--------------------------------------------------------------------------------------------------------------------
-- 221030016272	200913287	6001790		Full Circle Home Care, LLC						Parenting Skills (Paid) 
-- authorization_id		service_log_id	start_dt	end_dt			cost_no
-- 2617109				2370351			2023-09-25	2023-10-01		3780.00
-- 0	44	Forwarded to Funding Approval	482b5d7f-aad2-41de-9105-498f09f7bc91
-- Anne Arundel County 

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro
where routingid = '482b5d7f-aad2-41de-9105-498f09f7bc91'
	and objectid = '2617109'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
	
update routing ro
set activeflag = 1,
	updatedby = 'CDM-34800',
	updatedon = now()
where routingid = '482b5d7f-aad2-41de-9105-498f09f7bc91'
	and objectid = '2617109'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
	
/*	
-- case_id		client_id		provider_id	provider_nm										service_nm										
--------------------------------------------------------------------------------------------------------------------
-- 211030009819	4011614		5036607		Baltimore City Department of Social Services	Clothing Purchase (Paid)
-- authorization_id		service_log_id	start_dt	end_dt			cost_no
-- 2610950				2720399			2023-10-05	2023-10-05		535.06
-- 0	40	Forwarded to Funding Approval	01aea32d-d285-4f8f-96ef-5e286460938f
-- Baltimore City

No fix is required 
This Auth is having active record now 
1	40	Forwarded to Funding Approval	d873bdfb-52c0-4c78-93c4-e7edab3900ba	PCAUTHR
*/
		
-- case_id		client_id		provider_id	provider_nm					service_nm										
--------------------------------------------------------------------------------------------------------------------
-- 2020030403942	201475659	6006385		DHS FCDSS VISA									Health maintenance (Paid)
-- authorization_id		service_log_id	start_dt	end_dt			cost_no
-- 2604386				2715585			2023-09-01	2023-09-01		295.00
-- 0	41	Forwarded to Payment Approval	4acde868-2d10-45ae-92e4-7dcc703aa51d
-- Frederick County 

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro
where routingid = '4acde868-2d10-45ae-92e4-7dcc703aa51d'
	and objectid = '2604386'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
	
update routing ro
set activeflag = 1,
	updatedby = 'CDM-34800',
	updatedon = now()
where routingid = '4acde868-2d10-45ae-92e4-7dcc703aa51d'
	and objectid = '2604386'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
		
		
-- case_id		client_id		provider_id	provider_nm					service_nm										
--------------------------------------------------------------------------------------------------------------------
-- 3301647			200772725	5046744		Successful Childrens Learning Center			Child Care (Paid)
-- authorization_id		service_log_id	start_dt	end_dt			cost_no
-- 2587750				2626232			2023-09-01	2023-09-30		1390.00
-- 0	41	Forwarded to Payment Approval	71aa2a67-fcd4-40f6-899a-8f81775dc777
-- Baltimore City

select objectid, activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro
where routingid = '71aa2a67-fcd4-40f6-899a-8f81775dc777'
	and objectid = '2587750'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
	
update routing ro
set activeflag = 1,
	updatedby = 'CDM-34800',
	updatedon = now()
where routingid = '71aa2a67-fcd4-40f6-899a-8f81775dc777'
	and objectid = '2587750'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' ) 
	and ( select count(*)
			from routing ro1
		  where ro1.objectid = ro.objectid
			and ro1.eventcode in ( 'PCAUTHR', 'PCAUTH' )
			and ro1.activeflag = 1
		) = 0 ;
