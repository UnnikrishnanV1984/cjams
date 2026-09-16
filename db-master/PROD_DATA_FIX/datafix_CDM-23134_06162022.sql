-- CDM-23134 - GAP
/*
-- Issue Description: 
   User Request to delete the existing subsidy rate in Review status 
   
-- Case ID: 3305431 - katherine.slavin1@maryland.gov
-- Client ID: 4456970 (JAMESON HUNLEY) - a6af5b6d-7cd1-47af-b160-fcb0932f1bb3
-- GAP ID: 1006070 - 2022-06-03 To 2037-11-02 - 541756ec-422c-4764-bdb3-1dae3265f7ff
-- Provoder ID: 5096984 (Brandi Hunley) 
-- gapagreementrateid  = 'c75a849b-4064-4729-aca4-54b0bab6398a'
-- 2022-06-03 To 2023-06-02 - $33.15

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

-- Delete Extra GAP Rate Slab 
select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon, activeflag 
from gapagreementrate 
where gapagreementrateid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and activeflag = 1;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-23134',
	updatedon = now()
where gapagreementrateid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and activeflag = 1;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon, activeflag 
from gapratesrevision 
where gaprateid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and activeflag = 1;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-23134',
	updatedon = now()
where gaprateid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and activeflag = 1;

select routingid , eventcode, routingstatustypeid, remarks, updatedby, updatedon , activeflag 
	from routing 
where objectid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and eventcode = 'GARR'
	and activeflag  = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-23134',
	updatedon = now()
where objectid = 'c75a849b-4064-4729-aca4-54b0bab6398a'
	and eventcode = 'GARR'
	and activeflag  = 1 ;
