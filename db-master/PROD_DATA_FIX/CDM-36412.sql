/*
 * CDM-36412 - Conversion Issue
 * Customer Email ID:tonjua.boston@maryland.gov
 * Customer Name:Tonjua Boston
 * Description - 3195476:Case #3195476 (Timothy Schaumburg - Provider ID#5087195) is receiving GAP payments for Jacob Barnhart ID #3182447. 
 * However, case did not convert from CHESSIE to CJAMS. Finance would like for payments to be issued from CJAMS. 
 * This ticket requires a data fix to remove the last rate slab 

-- User request to add the GAP rate for below date
-- Rate Type	Rate Begin Date	Rate End Date	Rate Approval Date	Negotiated Amount
-- Monthly Assistance	03/24/2017	03/23/2018	03/07/2017	835
-- Monthly Assistance	03/24/2018	03/23/2019	03/07/2018	835
-- Monthly Assistance	03/24/2019	03/23/2020	03/07/2019	835
 * 
 */

-- remove the last rate slab 
DELETE FROM cjams.gapagreementrate WHERE insertedby = 'CDM-36412';
DELETE FROM cjams.gapratesrevision WHERE insertedby = 'CDM-36412';
DELETE FROM cjams.routing WHERE insertedby = 'CDM-36412';

select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-36412',
	updatedon = now()
where gapagreementrateid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-36412',
	updatedon = now()
where gaprateid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-36412',
	updatedon = now()
where objectid = 'aa5e3e8d-0683-4243-8b30-4fcaa788b189'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- To add the GAP rate for given date
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2017-03-24 00:00:00', '2018-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2017-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2017-03-24 00:00:00', '2018-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2017-03-24 00:00:00' and enddate = '2018-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2017-03-24 00:00:00', '2018-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2017-03-24 00:00:00' and enddate = '2018-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

--INSERT INTO cjams.routing
--	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
--		fromroleid, toroleid, 
--		objectid, 
--		routingstatustypeid, activeflag, 
--		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
--		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
--		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
--		etl_load_date, entityid, reassignnotes
--	)
--VALUES
--	(	gen_random_uuid(), 'GARR', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '8984bc95-6fe7-4947-9c31-be812a50116c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
--		'CWCW', 'CWSP', 
--		( select gapagreementrateid  
--			from gapagreementrate  
--		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
--			and insertedby = 'CDM-36412' and startdate = '2017-03-24 00:00:00' and enddate = '2018-03-23 00:00:00' 
--		), 
--			15, 0, 
--		'CDM-36412', now(), 'CDM-36412', now(), true, 
--		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3195476', 'Servicecase', 
--		NULL, NULL, NULL, NULL, NULL, 
--		NULL, NULL, NULL
--	);


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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2017-03-24 00:00:00' and enddate = '2018-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2018-03-24 00:00:00', '2019-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2018-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2018-03-24 00:00:00', '2019-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2018-03-24 00:00:00' and enddate = '2019-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2018-03-24 00:00:00', '2019-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412'  and startdate = '2018-03-24 00:00:00' and enddate = '2019-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

--INSERT INTO cjams.routing
--	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
--		fromroleid, toroleid, 
--		objectid, 
--		routingstatustypeid, activeflag, 
--		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
--		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
--		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
--		etl_load_date, entityid, reassignnotes
--	)
--VALUES
--	(	gen_random_uuid(), 'GARR', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '8984bc95-6fe7-4947-9c31-be812a50116c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
--		'CWCW', 'CWSP', 
--		( select gapagreementrateid  
--			from gapagreementrate  
--		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
--			and insertedby = 'CDM-36412'  and startdate = '2018-03-24 00:00:00' and enddate = '2019-03-23 00:00:00' 
--		), 
--			15, 0, 
--		'CDM-36412', now(), 'CDM-36412', now(), true, 
--		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3195476', 'Servicecase', 
--		NULL, NULL, NULL, NULL, NULL, 
--		NULL, NULL, NULL
--	);

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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412'  and startdate = '2018-03-24 00:00:00' and enddate = '2019-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2019-03-24 00:00:00', '2020-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2019-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 
	
INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2019-03-24 00:00:00', '2020-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412'  and startdate = '2019-03-24 00:00:00' and enddate = '2020-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);


INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2019-03-24 00:00:00', '2020-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412'   and startdate = '2019-03-24 00:00:00' and enddate = '2020-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

--INSERT INTO cjams.routing
--	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
--		fromroleid, toroleid, 
--		objectid, 
--		routingstatustypeid, activeflag, 
--		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
--		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
--		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
--		etl_load_date, entityid, reassignnotes
--	)
--VALUES
--	(	gen_random_uuid(), 'GARR', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '8984bc95-6fe7-4947-9c31-be812a50116c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
--		'CWCW', 'CWSP', 
--		( select gapagreementrateid  
--			from gapagreementrate  
--		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
--			and insertedby = 'CDM-36412'and startdate = '2019-03-24 00:00:00' and enddate = '2020-03-23 00:00:00' 
--		), 
--			15, 0, 
--		'CDM-36412', now(), 'CDM-36412', now(), true, 
--		'Guardianship Agreement Submitted for review', NULL, 'Guardianship Agreement Submitted for review', '3195476', 'Servicecase', 
--		NULL, NULL, NULL, NULL, NULL, 
--		NULL, NULL, NULL
--	);

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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2019-03-24 00:00:00' and enddate = '2020-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

-- To add the GAP rate for given date   	
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2020-03-24 00:00:00', '2021-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2020-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2020-03-24 00:00:00', '2021-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2020-03-24 00:00:00' and enddate = '2021-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2020-03-24 00:00:00', '2021-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2020-03-24 00:00:00' and enddate = '2021-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2020-03-24 00:00:00' and enddate = '2021-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

-- To add the GAP rate for given date   	
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2021-03-24 00:00:00', '2022-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2021-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2021-03-24 00:00:00', '2022-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2021-03-24 00:00:00' and enddate = '2022-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2021-03-24 00:00:00', '2022-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2021-03-24 00:00:00' and enddate = '2022-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2021-03-24 00:00:00' and enddate = '2022-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

-- To add the GAP rate for given date   	
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2022-03-24 00:00:00', '2023-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2022-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2022-03-24 00:00:00', '2023-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2022-03-24 00:00:00' and enddate = '2023-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2022-03-24 00:00:00', '2023-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2022-03-24 00:00:00' and enddate = '2023-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2022-03-24 00:00:00' and enddate = '2023-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);	

-- To add the GAP rate for given date   	
INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, status, negotiateddate, rateapprovaldate, etl_userid, etl_load_date, ssaapprovaldate
	)
VALUES
	(	gen_random_uuid(), 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc', '2023-03-24 00:00:00', '2024-03-23 00:00:00', 835, 
		false, NULL, NULL, 1, '2023-03-24 00:00:00',
		'CDM-36412', now(), 'CDM-36412', now(), NULL, 
		5050248, 'Approved', NULL, now(), NULL, NULL, NULL
	) ; 

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2023-03-24 00:00:00', '2024-03-23 00:00:00', 835, 
		NULL, '3045', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 0, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2023-03-24 00:00:00' and enddate = '2024-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
	);

INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
		insertedby, updatedon, updatedby, activeflag, 
		gaprateid, 
		guardiansubsidyid, providerid, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), now()::date, '2023-03-24 00:00:00', '2024-03-23 00:00:00', 835, 
		NULL, '3047', now(), false, now(), 
		'CDM-36412', now(), 'CDM-36412', 1, 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2023-03-24 00:00:00' and enddate = '2024-03-23 00:00:00' 
		), 
		'66497785-a277-4bc0-8fd6-acb0cd9937f6', 5050248, NULL, NULL
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
	(	gen_random_uuid(), 'GARR', '8984bc95-6fe7-4947-9c31-be812a50116c', '4351c0b5-e95b-4e47-994e-4ade18d59c94', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 
		'CWSP', 'CWCW', 
		( select gapagreementrateid  
			from gapagreementrate  
		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc'
			and insertedby = 'CDM-36412' and startdate = '2023-03-24 00:00:00' and enddate = '2024-03-23 00:00:00' 
		), 
		16, 1, 
		'CDM-36412', now(), 'CDM-36412', now(), true, 
		NULL, NULL, 'Guardianship Rate Approved ', '3195476', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);				

--DELETE FROM cjams.routing 
--where objectid in (select distinct gapagreementrateid::character varying
--	from gapagreementrate
--where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc' and insertedby = 'CDM-36412');
--
--DELETE FROM cjams.gapratesrevision
--WHERE gapratesrevisionid in (select distinct gapratesrevisionid 
--	from gapratesrevision
--where gaprateid in (select gapagreementrateid  
--			from gapagreementrate  
--		 where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc' and insertedby = 'CDM-36412'));
--		 
--DELETE FROM cjams.gapagreementrate
--WHERE gapagreementrateid in (select distinct gapagreementrateid 
--	from gapagreementrate
--where gapagreementid = 'e9f580aa-95ec-4e20-83c2-3d1617ada4cc' and insertedby = 'CDM-36412');	
