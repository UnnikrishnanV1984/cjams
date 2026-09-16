-- CDM-26505 - Subsidy will not generate
/*
-- Issue Description: 
	The subsidy rate still stuck under review status 
	Caseworker name need to be changed from Danielle Moore to lindaj.luallen@maryland.gov 
	and reroute the requet to supervisor (shaquan.brown@maryland.gov) for approval.
   
-- Case ID: 3147696
-- Client ID: 3086243 (MIKELLE BROOKS) - 6eafc718-e0c6-432f-b714-cdf99d3e8cdf
-- GAP ID: 4618 - 2017-09-20 To 2026-02-20 - 83d5a01d-f200-45f8-b637-a8d8ad622a73
-- GAP Rate ID: 2022-09-20 - 2023-09-19	$852.00 - 1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

Updated on 11/18 as the routing record was soft deleted with CDM-25872

*/

-- Baltimore City	
-- b50f2419-42ba-4ab6-84ab-5172917d2d77	Family Support Services #5
-- Linda J. Luallen - lindaj.luallen@maryland.gov (ceca7825-35d6-41bb-bfc9-df3256d9a1d9)
-- Shaquan Brown - shaquan.brown@maryland.gov (3ca8e63d-f885-445b-aab9-24456e91ad4a)

-- Update Requested By and Forwared To with correct user IDs 
select startdate, enddate, paymentamout, insertedby, updatedby, updatedon
	from gapagreementrate 
where gapagreementrateid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and activeflag = 1 ;

update gapagreementrate
set insertedby = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',  -- Linda J. Luallen
	updatedby = 'CDM-26505',
	updatedon = now()
where gapagreementrateid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, insertedby, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and activeflag = 1 ; 

update gapratesrevision
set insertedby = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',  -- Linda J. Luallen
	updatedby = 'CDM-26505',
	updatedon = now()
where gaprateid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and activeflag = 1 ; 

-- Routing Record
select routingid, routingstatustypeid, eventcode, remarks,
	fromsecurityusersid, tosecurityusersid, teamid, insertedby, updatedby, updatedon
	from routing 
where objectid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and eventcode = 'GARR'
	and routingid = '5ee5c22e-068b-40d4-bcf0-9b48744f57fc'
	-- and activeflag = 1 
;

update routing
set activeflag = 1, 
	fromsecurityusersid = 'ceca7825-35d6-41bb-bfc9-df3256d9a1d9',  -- Linda J. Luallen
	tosecurityusersid = '3ca8e63d-f885-445b-aab9-24456e91ad4a', -- Shaquan Brown
	teamid = 'b50f2419-42ba-4ab6-84ab-5172917d2d77', -- Family Support Services #5
	updatedby = 'CDM-26505',
	updatedon = now()
where objectid = '1d20bc1b-ee2f-4b2a-bcfe-882e397fc6e1'
	and eventcode = 'GARR'
	and routingid = '5ee5c22e-068b-40d4-bcf0-9b48744f57fc'
--	and activeflag = 1 
;
