/*
   Issue Description: CDM-25860
   Category/ Module  : Prod data fix To update approval status
   Pull request# for code fix:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
--*/

-- Delete GAP Subsidy rate stuck in review mode
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-25860',
	updatedon = now()
where gapagreementrateid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-25860',
	updatedon = now()
where gaprateid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-25860',
	updatedon = now()
where objectid = '70bc14ea-038b-4685-9714-864a05bc3d49'
	and eventcode = 'GARR'
	and activeflag = 1 ;


