-- CDM-15404 - Provider payment
/*
-- Issue Description: 
   Missing GAP payment for June 2021 
   
-- Case ID: 3106893
-- Client ID: 1738311 (ISAIAH CLAY) - a4d1f6b2-0338-494d-8733-c7f729cf9b44
-- GAP ID: 457 - 2007-10-31 - 2022-01-13 - d11c084d-f382-483c-8f38-f218f0c4dd14	
-- Provider ID: 5013163	(Darlene Dubose)
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Additional Rate Salb  in Rejected status is causing an error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- Modified on 08/06/2021 to add the mssing semicolons.
*/

-- Delete 
select status, startdate, enddate, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and gapagreementrateid  = 'bbd1c65f-3bb9-41a1-a714-188498361230'
	and activeflag  = 1	;
	
update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-15404',
	updatedon = now()
where gapagreementid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and gapagreementrateid  = 'bbd1c65f-3bb9-41a1-a714-188498361230'
	and activeflag  = 1	;


-- Delete
select approvalstatustypekey, ratestartdate, rateenddate, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = 'd11c084d-f382-483c-8f38-f218f0c4dd14'
	and gaprateid = 'bbd1c65f-3bb9-41a1-a714-188498361230'
	and activeflag = 1 ;

update gapratesrevision 
set activeflag = 0,
	updatedby = 'CDM-15404',
	updatedon = now()
where guardiansubsidyid = 'd11c084d-f382-483c-8f38-f218f0c4dd14'
	and gaprateid = 'bbd1c65f-3bb9-41a1-a714-188498361230'
	and activeflag = 1 ;
	

-- Delete 
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where eventcode = 'GAAR'
	and objectid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and activeflag  = 1
	and routingid in (	'e9833bc5-41b3-402c-8822-a5f85e357dde', 
						'326d87c1-2d7c-4464-9178-a94d9292b78e',
						'26702301-ef07-4c3a-84bf-22d3d7925388', 
						'b525edfe-5f9e-43d7-824a-32f47ce91552'
					 ) ;


update routing 
set activeflag = 0,
	updatedby = 'CDM-15404',
	updatedon = now()
where eventcode = 'GAAR'
	and objectid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and activeflag  = 1
	and routingid in (	'e9833bc5-41b3-402c-8822-a5f85e357dde', 
						'326d87c1-2d7c-4464-9178-a94d9292b78e',
						'26702301-ef07-4c3a-84bf-22d3d7925388', 
						'b525edfe-5f9e-43d7-824a-32f47ce91552'
					 ) ;	

-- Make Active
select * 
	from routing
where eventcode = 'GAAR'
	and objectid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and activeflag = 0
	and routingid in ( '81bcdb09-90eb-43c9-9e67-b5fde5362fce',
						'05216ff4-ed08-4d60-a679-a7ee723b924e',
						'37ff9a64-4836-4a92-937a-6dfa3bae00d0' 
					  );

update routing 
set activeflag = 1,
	updatedby = 'CDM-15404',
	updatedon = now()
where eventcode = 'GAAR'
	and objectid = 'b587f1ca-5879-4e73-9173-e755d74a7767'
	and activeflag = 0
	and routingid in ( '81bcdb09-90eb-43c9-9e67-b5fde5362fce',
						'05216ff4-ed08-4d60-a679-a7ee723b924e',
						'37ff9a64-4836-4a92-937a-6dfa3bae00d0' 
					  );


-- Datafix to trigger Under/Over for generating Jan 2021 payment
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, activeflag, updatedby, updatedon 
	from gapratesrevision 
where guardiansubsidyid = 'd11c084d-f382-483c-8f38-f218f0c4dd14'
	and approvaldate is not null
	and activeflag = 1 ;

update gapratesrevision 
set approvaldate = now(),
	updatedby = 'CDM-15404',
	updatedon = now()
where guardiansubsidyid = 'd11c084d-f382-483c-8f38-f218f0c4dd14'
	and approvaldate is not null
	and activeflag = 1 ;

