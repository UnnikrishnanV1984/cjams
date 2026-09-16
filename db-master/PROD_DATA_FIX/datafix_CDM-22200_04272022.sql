-- CDM-22200 - GAP Annual Renewal
/*
-- Issue Description: 
	GAP Subsidy Rate was submitted and still in review. 
	Does not show who submitted for review and does not show in supervisor box for approval.
	   
-- Case ID: 3212105
-- Provider ID: 5035341	(Jean Williams)
-- Client ID: 1768922 (YATES GARY MOORE) - 58e5756a-1cd4-4f32-97fb-230ac866a62b
-- GAP ID: 2748 - 2013-03-15 To 2023-06-12 - 637b3b05-0a0c-407a-8006-2212809031e6
-- gapagreementid: 13d4362a-6bb4-47bf-bc71-87f3f7d083bb
-- gapagreementrateid: 8e415674-cd34-45aa-beca-f37601f006b4
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- GAP Rate with Missing Routing record
-- Delete 
select status, startdate, enddate, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid  = '8e415674-cd34-45aa-beca-f37601f006b4'
	and activeflag  = 1	;
	
update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-22200',
	updatedon = now()
where gapagreementrateid  = '8e415674-cd34-45aa-beca-f37601f006b4'
	and activeflag  = 1	;

-- Delete
select approvalstatustypekey, ratestartdate, rateenddate, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '8e415674-cd34-45aa-beca-f37601f006b4'
	and activeflag = 1 ;

update gapratesrevision 
set activeflag = 0,
	updatedby = 'CDM-22200',
	updatedon = now()
where gaprateid = '8e415674-cd34-45aa-beca-f37601f006b4'
	and activeflag = 1 ;
