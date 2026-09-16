-- CJAMS-66102 - Finance
/*
-- Issue Description: 
   User request to add the GAP rate missing slab  02/01/2019 till 01/31/2020 with amount $ 466
   
-- Case ID: 3128667

   
-- Category/ Module: GAP (Case Management)
-- Root cause: User error,Requested to add the GAP rate missing slab  02/01/2019 till 01/31/2020 with amount $ 466
--Fix Provided: Data fix has been done to add the missing gap rate slab
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


INSERT INTO cjams.gapagreementrate
(gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
isoverride, paymenttypekey, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, provider_id, alternateid, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate)
VALUES(gen_random_uuid(), '6fdeb68a-f529-43e3-b75f-28b913c80141'::uuid, '2019-02-01 00:00:00.000', '2020-01-31 00:00:00.000', 466,
 NULL, NULL, NULL, 1, now(), 'CJAMS-66102', now(), 'CJAMS-66102', now(), NULL, 5058202, nextval('sequence_gapagreementrate'::regclass),'Approved', now(), NULL, NULL, NULL,NULL);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2019-02-01 00:00:00.000', '2020-01-31 00:00:00.000', 466, 
		NULL, '3045', now(), false, now(), 
		'CJAMS-66102', now(), 'CJAMS-66102', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '6fdeb68a-f529-43e3-b75f-28b913c80141'
			and insertedby = 'CJAMS-66102' 
		), 
		'87128528-c360-4a80-a28c-ff1140406064', 5058202, NULL, NULL
	);


INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2019-02-01 00:00:00.000', '2020-01-31 00:00:00.000', 466, 
		NULL, '3047', now(), false, now(), 
		'CJAMS-66102', now(), 'CJAMS-66102', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '6fdeb68a-f529-43e3-b75f-28b913c80141'
			and insertedby = 'CJAMS-66102' 
		), 
		'87128528-c360-4a80-a28c-ff1140406064', 5058202, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
		fromroleid, toroleid, 
		objectid, 
		routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'GARR', 'd9f3046e-7510-4d66-84f8-870a24203d33', 'd9f3046e-7510-4d66-84f8-870a24203d33', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWCW', 'CWSP', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '6fdeb68a-f529-43e3-b75f-28b913c80141'
			and insertedby = 'CJAMS-66102' 
		), 
			15, 0, 
		'CJAMS-66102', now(), 'CJAMS-66102', now(), true, 
		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3128667', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
		fromroleid, toroleid, 
		objectid, 
		routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'GARR', 'd9f3046e-7510-4d66-84f8-870a24203d33', 'd9f3046e-7510-4d66-84f8-870a24203d33', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWCW', 'CWSP', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '6fdeb68a-f529-43e3-b75f-28b913c80141'
			and insertedby = 'CJAMS-66102' 
		), 
			16, 1, 
		'CJAMS-66102', now(), 'CJAMS-66102', now(), true, 
		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3128667', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);
--To Trigger batch payments
update  gapagreementrevision
set updatedby='CJAMS-66102',
    updatedon = now(),
    approvaldate =now()
where gapagreementid  = '6fdeb68a-f529-43e3-b75f-28b913c80141'
and gapagreementrevisionid = '02f9fee7-20fb-49fc-9a75-5f4663f7c141'
and approvalstatustypekey = '3047'
and activeflag  = 1;

update gapagreementrate
set updatedon  = now(),
    updatedby='CJAMS-66102'
where gapagreementid = '6fdeb68a-f529-43e3-b75f-28b913c80141'
    and activeflag  = 1 ;


    