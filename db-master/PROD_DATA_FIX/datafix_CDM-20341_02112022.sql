-- CDM-20341 - GAP payment not generating
/*
-- Issue Description: 
   Guardian's provider ID is now not showing up in the application section of the GAP.
   
-- Case ID: 3268580
-- Client ID: 1014436 (MYA MARIE GRIMES) - 3d4a1247-c965-40d3-a9b9-a5061cad4ecd
-- GAP ID: 1005958 - Null To 2023-02-12 - 0b4e4702-be93-4496-9aaa-c4fbb3428490
-- Strat Date: 2022-01-20 00:00:00 
-- Provider ID: 6004939 (DANA L GOODMAN)

-- Category/ Module: GAP (Case Management) 
-- Root cause: TDB
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Update GAP Provider Info
-- Provider ID: Prvoider ID: 6004939 (DANA L GOODMAN) - Local Department Home
-- Guardianship Home Approval ID: 108638
-- 3610	Applicant: (527803) DANA GOODMAN
-- 3611	Co-Applicant: None

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'DANA GOODMAN',
	guardianoneid = 527803, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6004939,
	-- primaryrelationshipkey = 'RELOTHR',
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-20341',
	updatedon = now()
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon 
from gapagreementrate 
where gapagreementid = 'f01ac42b-db37-4308-8165-29e240ece09c' ;

update gapagreementrate
set provider_id = 6004939,
	updatedby = 'CDM-20341',
	updatedon = now()
where gapagreementid = 'f01ac42b-db37-4308-8165-29e240ece09c' ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where guardiansubsidyid = '0b4e4702-be93-4496-9aaa-c4fbb3428490' ;

update gapratesrevision
set providerid = 6004939,
	approvaldate = now(),
	updatedby = 'CDM-20341',
	updatedon = now()
where guardiansubsidyid = '0b4e4702-be93-4496-9aaa-c4fbb3428490' ;

-- Update GAP Start Date as 2022-01-20 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2022-01-20 04:00:00',
	updatedby = 'CDM-20341',
	updatedon = now()
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490' ;

update gapagreementrevision
set startdate = '2022-01-20 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-20341',
	updatedon = now()
where gapid = '0b4e4702-be93-4496-9aaa-c4fbb3428490' ;
