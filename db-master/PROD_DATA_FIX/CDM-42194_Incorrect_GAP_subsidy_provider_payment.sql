/*
   Issue Description: CDM-42194 Incorrect GAP subsdy provider paymant
   Category/ Module  :  GAP Subsidy
   Root cause: Incorrect Subsidy provider in the GAP case
   Fix Provided: Data fix to correct the provider id for GAP subsidy rate as requested by the user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
gapagreementrateid: e15e591c-88a8-468b-a502-0ee443514026
gapagreementid: 7c279667-3e34-4c3a-967b-ee69074e046e
wrong provider id: 5055574, alternateid: 1312007
correct  Provider ID# 5083542 (Katherine Dorsey)
gapid = '8382cdd1-d014-4132-b0b9-73bbb2bc0466'
*/
-- check if the provider the correct guardianship
/*select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = '8382cdd1-d014-4132-b0b9-73bbb2bc0466'
	and activeflag = 1 ;*/

/*
select provider_id, startdate, enddate, paymentamout, activeflag, updatedby, updatedon,isoverride, *
	from gapagreementrate
where gapagreementrateid = 'e15e591c-88a8-468b-a502-0ee443514026'
	and activeflag = 1 ;

select gapagreementid, provider_id, startdate, enddate, paymentamout, 
	rateapprovaldate, status, updatedby, updatedon,*
from gapagreementrate 
where gapagreementid = '7c279667-3e34-4c3a-967b-ee69074e046e' and activeflag =1;
*/

update gapagreementrate
set provider_id = 5083542,
	updatedby = 'CDM-42194',
	updatedon = now()
where gapagreementrateid  = 'e15e591c-88a8-468b-a502-0ee443514026' and activeflag =1;

/*
select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon, activeflag 
from gapratesrevision 
where guardiansubsidyid = '8382cdd1-d014-4132-b0b9-73bbb2bc0466' and activeflag =1;
*/

update gapratesrevision
set providerid = 5083542,
	approvaldate = now(),
	updatedby = 'CDM-42194',
	updatedon = now()
where gapratesrevisionid in ('7d1f98b3-a48e-456a-84b3-8f877c64a153','20ed6116-6811-41b5-bfb1-f568831ee6ec') and activeflag =1;