-- CDM-32389 - GAP Date Error
/*
-- Issue Description: 
	User request to change the GAP Annual Review and GAP Rates
    
-- Case ID: 3286464
-- Client ID: 4216458 (SLAYDEN M ALEXANDER) - 99973849-f900-4dad-8d25-25f3e2e11495
-- GAP ID: 5282 - 2019-06-28 To 2029-07-08 -  850fa6e2-788b-43ba-bead-c9b30f8db0f5

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the GAP Annual Review and GAP Rates as requested by the user.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1) Delete GAP Annual Review dated 06/23/2023
select gapannualreviewid, gapid, reviewdate, effectivedate, updatedby, updatedon 
   from gapannualreview
where gapannualreviewid = '220f7460-408c-4dcb-868c-696f55e3e73c'
	and activeflag = 1 ;

update gapannualreview 
set activeflag = 0,
	updatedby = 'CDM-32389',
	updatedon = now()
where gapannualreviewid = '220f7460-408c-4dcb-868c-696f55e3e73c'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '220f7460-408c-4dcb-868c-696f55e3e73c'
	and eventcode = 'GAYR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32389',
	updatedon = now()
where objectid = '220f7460-408c-4dcb-868c-696f55e3e73c'
	and eventcode = 'GAYR'
	and activeflag = 1 ;

-- 2) Remove the current subsidy rate slab dated 06/25/2023 to 06/25/2023
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-32389',
	updatedon = now()
where gapagreementrateid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-32389',
	updatedon = now()
where gaprateid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32389',
	updatedon = now()
where objectid = '5d88ab76-f81d-4bbb-865e-d69a0c04995c'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- 3 Change the Subsidy Rate slab 06/25/2022 To 06/24/2023  - End Date change 06/24/2023 to 06/14/2023
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon
	from gapagreementrate
where gapagreementrateid = '2ef4aebb-c733-485a-9465-97e1dd00494a'
	and activeflag = 1 ;

update gapagreementrate
set enddate = '2023-06-14 16:00:00',
	updatedby = 'CDM-32389',
	updatedon = now()
where gapagreementrateid = '2ef4aebb-c733-485a-9465-97e1dd00494a'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = '2ef4aebb-c733-485a-9465-97e1dd00494a'
	and activeflag = 1 ;

update gapratesrevision
set rateenddate = '2023-06-14 16:00:00',
	updatedby = 'CDM-32389',
	updatedon = now()
where gaprateid = '2ef4aebb-c733-485a-9465-97e1dd00494a'
	and activeflag = 1 ;

