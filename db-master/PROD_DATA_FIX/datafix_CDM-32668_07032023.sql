-- CDM-32668 - Data fix on GAP subsidy
/*
-- Issue Description: 
	User request to delete duplicate GAP Rate slab and change the dates on another slab.
    
-- Case ID: 3285561
-- Client ID: 2813114 (TYREE ADAIR HOWARD) - f9db171e-aad9-4c76-924c-447dc815a576
-- GAP ID: 1012165 - 2023-06-29 To 2027-06-16 - 8a107d44-2ee8-4541-a46d-79ce4bc153c7
-- Provider ID: 6018071	(LISA M COTTRILL) 
-- Rates: 
-- Delete - bb76714c-a7a6-43e1-b004-6b3a8c45b1e3	2023-06-29	2023-06-29	$886.00
-- Update dates as 2023-06-29 To 2024-06-28 - af27be7d-535c-4e92-a8df-c51069e42361	2023-06-30	2024-06-29	$902.00


-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the GAP Annual Review and GAP Rates as requested by the user.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) Remove the duplicate duplicate GAP Rate slab
-- bb76714c-a7a6-43e1-b004-6b3a8c45b1e3	2023-06-29	2023-06-29	$886.00
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-32668',
	updatedon = now()
where gapagreementrateid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-32668',
	updatedon = now()
where gaprateid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32668',
	updatedon = now()
where objectid = 'bb76714c-a7a6-43e1-b004-6b3a8c45b1e3'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- 2) af27be7d-535c-4e92-a8df-c51069e42361	2023-06-30	2024-06-29	$902.00
-- Update dates as 2023-06-29 To 2024-06-28 
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon
	from gapagreementrate
where gapagreementrateid = 'af27be7d-535c-4e92-a8df-c51069e42361'
	and activeflag = 1 ;

update gapagreementrate
set startdate = '2023-06-29 08:00:00',	
	enddate = '2024-06-28 08:00:00',
	updatedby = 'CDM-32668',
	updatedon = now()
where gapagreementrateid = 'af27be7d-535c-4e92-a8df-c51069e42361'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = 'af27be7d-535c-4e92-a8df-c51069e42361'
--	and activeflag = 1 
	;

update gapratesrevision
set ratestartdate = '2023-06-29 08:00:00',	
	rateenddate = '2024-06-28 08:00:00',
	updatedby = 'CDM-32668',
	updatedon = now()
where gaprateid = 'af27be7d-535c-4e92-a8df-c51069e42361'
	-- and activeflag = 1 
	;
