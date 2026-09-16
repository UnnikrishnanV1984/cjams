-- CDM-22120 - A/R Generated for Provider incorrectly
/*
-- Issue Description: 
   Provider 5005776 (Ginger Van Iderstine) shows an A/R generated in March-22 
   from the Feb-22 adoption CJAMS paid. However the provider was not actually overpaid. 
   
-- Adoption Case ID: 3152845 - megan.turner@maryland.gov
-- Client ID: 2032290 (ELIZABETH C VANIDERSTINE) - 908603d7-fbd6-4fa4-a772-73a57cedfd1f
-- Provider ID: 5005776	(Ginger Van iderstine) - Local Department Home


-- Category/ Module: Adoption (Case Management) 
-- Root cause: Migrated Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- Fix the overlapping Rate Slabs
/*
-- Correct Rates
05/19/2005 - 11/30/2005 rate was $535
12/01/2005 - 06/30/2006 rate was $560
07/01/2006 - 02/28/2008 rate was $585
03/01/2008 - 07/31/2008 rate was $735
08/01/2008 - present 	rate was $835

-- Current Rates
d74cef15-4638-4c01-b5a3-949bbdc24005		2005-05-19	2022-02-24 	585.00			2005-05-19
970c3b6e-1b70-4066-b229-c3f4c9101b69		2008-03-01	2022-02-24  735.00			2008-03-01
6a1b074f-1b1f-45b1-a129-b256b2c68eb8		2008-08-01 	2022-02-24 	835.00			2008-08-01
da04c452-8217-42a1-a343-a16e5e28549a		2022-02-25 	2023-02-24 	835.00			2022-02-28
*/

-- adoptionagreementrateid					startdate	enddate		paymentamout	transactiondate
--------------------------------------------------------------------------------------------------------
-- d74cef15-4638-4c01-b5a3-949bbdc24005		2005-05-19	2022-02-24 	585.00			2005-05-19

-- Update as 05/19/2005 - 11/30/2005 rate was $535
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'd74cef15-4638-4c01-b5a3-949bbdc24005'
	and activeflag = 1;

update adoptioncaseagreementrate
set -- startdate = '2005-05-19 00:00:00',
	enddate = '2005-11-30 00:00:00', -- 2022-02-24 00:00:00
	paymentamout = 535.00, -- 585.00
	-- approvaldate = now(),
	updatedon = now(), -- 2007-10-10 14:47:55
	updatedby = 'CDM-22120' -- MTU014621
where adoptionagreementrateid = 'd74cef15-4638-4c01-b5a3-949bbdc24005'
	and activeflag = 1;

-- Insert New 12/01/2005 - 06/30/2006 rate was $560
INSERT INTO cjams.adoptioncaseagreementrate
	(	adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
		provider_id, paymentamout, isapproval, approvaldate, isspeacialneeds, parent1actorid, 
		parent2actorid, childrelationship, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status,
		fk_id, isssaapproved, ssaapproveddate, etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), '8bcc1193-5592-4db5-9b22-5caffcc2b5f6', '2005-12-01 00:00:00', '2006-06-30 00:00:00',
		5005776, 560.00, 1, '2007-10-11 00:00:00', NULL, '00000000-0000-0000-0000-000000000000', 
		'00000000-0000-0000-0000-000000000000', 'Foster Parent', NULL, 1, '2005-12-01 00:00:00', 
		'CDM-22120', now(), 'CDM-22120', now(), NULL, 
		'ADDA', NULL, '2005-12-01 00:00:00', NULL, 'Approved', NULL, 0, NULL, NULL, NULL
	);


-- adoptionagreementrateid					startdate	enddate		paymentamout	transactiondate
--------------------------------------------------------------------------------------------------------
-- 970c3b6e-1b70-4066-b229-c3f4c9101b69		2008-03-01	2022-02-24  735.00			2008-03-01

-- Update as 07/01/2006 - 02/28/2008 rate was $585
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '970c3b6e-1b70-4066-b229-c3f4c9101b69'
	and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2006-07-01 00:00:00', -- 2008-03-01 00:00:00
	enddate = '2008-02-28 00:00:00', -- 2022-02-24 00:00:00
	paymentamout = 585.00, -- 735.00
	-- approvaldate = now(),
	updatedon = now(), -- 2008-03-13 13:28:48
	updatedby = 'CDM-22120' -- MTU014621
where adoptionagreementrateid = '970c3b6e-1b70-4066-b229-c3f4c9101b69'
	and activeflag = 1;
	
-- adoptionagreementrateid					startdate	enddate		paymentamout	transactiondate
--------------------------------------------------------------------------------------------------------
-- 6a1b074f-1b1f-45b1-a129-b256b2c68eb8		2008-08-01 	2022-02-24 	835.00			2008-08-01

-- Update as 03/01/2008 - 07/31/2008 rate was $735
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = '6a1b074f-1b1f-45b1-a129-b256b2c68eb8'
	and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2008-03-01 00:00:00', -- 2008-08-01 00:00:00
	enddate = '2008-07-31 00:00:00', -- 2022-02-24 00:00:00
	paymentamout = 735.00, -- 835.00
	-- approvaldate = now(),
	updatedon = now(), -- 2008-08-14 11:04:54
	updatedby = 'CDM-22120' -- MTU014621
where adoptionagreementrateid = '6a1b074f-1b1f-45b1-a129-b256b2c68eb8'
	and activeflag = 1;
	
-- adoptionagreementrateid					startdate	enddate		paymentamout	transactiondate
--------------------------------------------------------------------------------------------------------
-- da04c452-8217-42a1-a343-a16e5e28549a		2022-02-25 	2023-02-24 	835.00			2022-02-28

-- Update as 08/01/2008 - present 	rate was $835
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'da04c452-8217-42a1-a343-a16e5e28549a'
	and activeflag = 1;

update adoptioncaseagreementrate
set startdate = '2008-08-01 00:00:00', -- 2022-02-25 05:00:00
	-- enddate = 2023-02-24 05:00:00
	-- paymentamout = 835.00,
	-- approvaldate = now(),
	updatedon = now(), -- 2022-02-28 13:57:54
	updatedby = 'CDM-22120' -- dd3ac302-59b9-4e32-ac55-94a0d551ee4f
where adoptionagreementrateid = 'da04c452-8217-42a1-a343-a16e5e28549a'
	and activeflag = 1;

-- Update adoptioncaserevision
select startdate, enddate, approvaldate, paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementrateid = 'da04c452-8217-42a1-a343-a16e5e28549a' ;

update adoptioncaserevision
set startdate = '2008-08-01 00:00:00', -- 2022-02-25 05:00:00
	-- enddate = '2023-02-24 05:00:00',
	updatedon = now(), -- 2022-02-28 13:57:54
	updatedby = 'CDM-22120' -- dd3ac302-59b9-4e32-ac55-94a0d551ee4f
where adoptionagreementrateid = 'da04c452-8217-42a1-a343-a16e5e28549a' ;
