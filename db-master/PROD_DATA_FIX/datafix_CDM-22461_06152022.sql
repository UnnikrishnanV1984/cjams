-- CDM-22461 -- ASHARIA OLUKAYODE TRYING TO UPDATE ANNUAL RECON 
--			    AND IT UPDATEDFOR TWO YEARS INSTEAD OF ONE
/*
-- Issue Description: 
   User Request to delete an extra year rate slab from GAP case

-- Case ID: 3290500 - sandy.snow@maryland.gov
-- Client ID: 1748670 (ASHARIA ALLIYAH OLUKAYODE) - a07d1846-44a6-4d2e-8e56-d32a20ab1534
-- GAP ID: 5411 - 2019-11-14 To 2022-01-27 - d8100365-4cc2-462d-97aa-37de09b1e866
-- Provider ID: 5090944 (Kashaka Olukayode) - Local Department Home
-- gapagreementrateid  = '908d0691-1b46-4d05-8d79-99cedf3999c3'
-- 2023-01-28 To 2024-01-27 - $902

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Delete Extra GAP Rate Slab 
select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon, activeflag 
from gapagreementrate 
where gapagreementrateid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and activeflag = 1;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-22461',
	updatedon = now()
where gapagreementrateid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and activeflag = 1;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon, activeflag 
from gapratesrevision 
where gaprateid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and activeflag = 1;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-22461',
	updatedon = now()
where gaprateid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and activeflag = 1;

select routingid , eventcode, routingstatustypeid, remarks, updatedby, updatedon , activeflag 
	from routing 
where objectid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and eventcode = 'GARR'
	and activeflag  = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-22461',
	updatedon = now()
where objectid = '908d0691-1b46-4d05-8d79-99cedf3999c3'
	and eventcode = 'GARR'
	and activeflag  = 1 ;
