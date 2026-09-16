-- CDM-19896 - Finance
/*
-- Issue Description: 
   User request to add the GAP rate missing slab 12/03/2020 - 12/02/2021
   
-- Case ID: 3222933
-- Client ID: 3476716 (KIRA	J SANCHEZ) - e074a8cf-bb46-49ae-8f7a-9c820fd03f7d
-- GAP ID: 3648 - 2014-12-03 To 2029-10-20 - eba24b9d-480f-4262-a38a-b53b33c12cd0
-- PRovider ID: 5063727	(Brenda Harris)
   
-- Category/ Module: GAP (Case Management)
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
	
-- To add the GAP rate missing slab 12/03/2020 - 12/02/2021
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), '212485e1-20da-49ef-8596-d5640543bb7f', '2020-12-03 00:00:00', '2021-12-02 00:00:00', 835, 
		false, NULL, NULL, 1, '2020-12-03 00:00:00',
		'CDM-19896', now(), 'CDM-19896', now(), NULL, 
		5063727, 'Approved', NULL, now(), NULL, NULL, NULL
	) RETURNING gapagreementrateid ; 
	
	

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2020-12-03 00:00:00', '2021-12-02 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-19896', now(), 'CDM-19896', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '212485e1-20da-49ef-8596-d5640543bb7f'
			and insertedby = 'CDM-19896' 
		), 
		'eba24b9d-480f-4262-a38a-b53b33c12cd0', 5063727, NULL, NULL
	);


INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2020-12-03 00:00:00', '2021-12-02 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-19896', now(), 'CDM-19896', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '212485e1-20da-49ef-8596-d5640543bb7f'
			and insertedby = 'CDM-19896' 
		), 
		'eba24b9d-480f-4262-a38a-b53b33c12cd0', 5063727, NULL, NULL
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
	(	gen_random_uuid(), 'GARR', '282bce60-d6fd-43f1-aa89-a602387dcd5b', 'e4271184-e42a-4639-88a5-4168eb1814f7', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1', 
		'CWCW', 'FNSFS', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '212485e1-20da-49ef-8596-d5640543bb7f'
			and insertedby = 'CDM-19896' 
		), 
			15, 0, 
		'CDM-19896', now(), 'CDM-19896', now(), true, 
		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3222933', 'Servicecase', 
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
	(	gen_random_uuid(), 'GARR', 'e4271184-e42a-4639-88a5-4168eb1814f7', '282bce60-d6fd-43f1-aa89-a602387dcd5b', 'c785fb5e-b0f4-4f4a-acf8-f9a563c10fc1', 
		'FNSFS', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = '212485e1-20da-49ef-8596-d5640543bb7f'
			and insertedby = 'CDM-19896' 
		), 
		16, 1, 
		'CDM-19896', now(), 'CDM-19896', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3222933', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	
