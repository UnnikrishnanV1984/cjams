-- CDM-33708 - Adoption Subsidy Renewal
/*
-- Issue Description: 
   Overlapping subsidy rate slabs Migrated data issue
   
-- Adoption Case ID: 3150150
-- Client ID: 1972493 (WILLIAM PATTON) - cc51f73a-5504-4b91-9ab9-d80fb4402202
-- Adoption ID: 15512 - 2009-08-14 To 2024-08-14 - 824b04e2-74bf-4b8c-a248-19b36d463974
-- Provider ID: 5007402	(Carolyn Patton)

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Migrated Data Issue (Overlapping subsidy rate slabs)
-- Fix Provided: Datafix has been provided to split the yearly rate slabs.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- old
6748bb6b-fc15-4304-bd5c-9a847af94304	2007-08-14	2008-08-14	750.00
2e0af841-a19e-431d-9551-097d4adcd0a2	2008-08-14	2009-08-14	850.00
5c915a25-5961-4303-9988-6bc0f3519973	2009-08-14	2023-08-14	850
*/

-- New
-- 6748bb6b-fc15-4304-bd5c-9a847af94304	2007-08-14	2008-08-14	750.00 - Update End Date 2008-08-13
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '6748bb6b-fc15-4304-bd5c-9a847af94304'
	and activeflag = 1;
	
update adoptioncaseagreementrate
set enddate = '2008-08-13 00:00:00', -- 2008-08-14 00:00:00
	updatedon = now(), -- 2009-07-29 13:25:57
	updatedby = 'CDM-33708' -- SVI834222
where adoptionagreementrateid = '6748bb6b-fc15-4304-bd5c-9a847af94304'
	and activeflag = 1;

	
-- 2e0af841-a19e-431d-9551-097d4adcd0a2	2008-08-14	2009-08-14	850.00 - Update End Date 2009-08-13
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '2e0af841-a19e-431d-9551-097d4adcd0a2'
	and activeflag = 1;
	
update adoptioncaseagreementrate
set enddate = '2009-08-13 00:00:00', -- 2009-08-14 00:00:00
	updatedon = now(), -- 2009-07-29 13:32:22
	updatedby = 'CDM-33708' -- SVI834222
where adoptionagreementrateid = '2e0af841-a19e-431d-9551-097d4adcd0a2'
	and activeflag = 1;

-- new	2009-08-14	2010-08-13	850.00 
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2009-08-14 00:00:00.000', '2010-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2009-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);


-- new	2010-08-14	2011-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2010-08-14 00:00:00.000', '2011-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2010-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2011-08-14	2012-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2011-08-14 00:00:00.000', '2012-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2011-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new 2012-08-14	2013-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2012-08-14 00:00:00.000', '2013-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2012-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2013-08-14	2014-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2013-08-14 00:00:00.000', '2014-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2013-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new 2014-08-14	2015-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2014-08-14 00:00:00.000', '2015-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2014-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2015-08-14	2016-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2015-08-14 00:00:00.000', '2016-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2015-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2016-08-14	2017-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2016-08-14 00:00:00.000', '2017-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2016-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2017-08-14	2018-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2017-08-14 00:00:00.000', '2018-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2017-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new 2018-08-14	2019-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2018-08-14 00:00:00.000', '2019-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2018-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new 2019-08-14	2020-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2019-08-14 00:00:00.000', '2020-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2019-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new	2020-08-14	2021-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2020-08-14 00:00:00.000', '2021-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2020-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);
	
-- new 2021-08-14	2022-08-13	850.00
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, 
		parent1actorid, parent2actorid, childrelationship, notes, 
		activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
		old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date)
VALUES
	(	gen_random_uuid(), 'c5c54441-7700-479f-934c-2a6289041c50', '2021-08-14 00:00:00.000', '2022-08-13 00:00:00.000', 
		5007402, 850.00, 1, '2008-08-22 00:00:00.000', NULL, 
		'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 'Foster Parent', 'see above', 
		1, '2021-08-14 00:00:00.000', 'CDM-33708', now(), 'CDM-33708', now(), 
		NULL, 'ADBG', NULL, '2008-08-14 00:00:00.000', 'Y', 'Approved', 
		NULL, 0, NULL, NULL, NULL
	);

-- 5c915a25-5961-4303-9988-6bc0f3519973	2009-08-14	2023-08-14	850.00 - Update Start Date 2022-08-14 & End Date 2023-08-13
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '5c915a25-5961-4303-9988-6bc0f3519973'
	and activeflag = 1;
	
update adoptioncaseagreementrate
set startdate = '2022-08-14 00:00:00', -- 2009-08-14 00:00:00
	enddate = '2023-08-13 00:00:00', -- 2023-08-14 00:00:00
	updatedon = now(), -- 2023-08-17 13:49:57
	updatedby = 'CDM-33708' -- 251ca32d-4b6f-460e-ab34-0d740c55b6dd
where adoptionagreementrateid = '5c915a25-5961-4303-9988-6bc0f3519973'
	and activeflag = 1;


-- Update Adoption start date as 08/14/2007
select startdate, enddate, updatedby, updatedon
	from adoptioncase
where adoptioncaseid = '824b04e2-74bf-4b8c-a248-19b36d463974'
	and activeflag = 1 ;

update adoptioncase
set startdate = '2007-08-14 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-33708' 
where adoptioncaseid = '824b04e2-74bf-4b8c-a248-19b36d463974'
	and activeflag = 1 
	and startdate::date <> '2007-08-14'::date;

select startdate, enddate, updatedby, updatedon
	from adoptioncaseagreement
where adoptioncaseid = '824b04e2-74bf-4b8c-a248-19b36d463974'
	and activeflag = 1 ;

update adoptioncaseagreement
set startdate = '2007-08-14 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-33708' 
where adoptioncaseid = '824b04e2-74bf-4b8c-a248-19b36d463974'
	and activeflag = 1 
	and startdate::date <> '2007-08-14'::date;

