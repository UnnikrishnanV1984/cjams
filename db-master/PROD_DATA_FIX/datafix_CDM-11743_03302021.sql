-- CDM-11743 - PAYMENTS NOT generated
/*
-- Issue Description: 
   The GAP recon is the case #3090628 for 2 clients has been updated however payments have not generated. 
   
   Case ID: 3090628 - a318a048-a2f8-4a30-a50e-ee4268176e26
   Client ID: 3477941 (EMANI MAKAYLA JONES)- 42128b3f-9639-4a07-863e-3de21524d534 
   GAP ID: 5063 - 37bf5cca-dfcf-4573-a7b2-3783556281ed
   PP ID: 72de277d-4d97-4702-bf4f-fde7dcd93569
   
   Client ID: 3460565 (PEYTON JONES) - 41c59957-322a-4608-ac10-16c89be39bb1
   GAP ID: 5064 - 26a9a57d-7caa-4e39-940d-aede22bc691f	
   PP ID: 6b946204-39ef-4d6f-9cca-2a03f11187e5
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- Client ID: 3477941
-- Actor ID: f6890d8c-096a-4b51-a88d-7e985ef5506d - active flag 0
-- New Actor ID: d25e4bf6-c685-496a-83a4-53270118fbbf (update)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid 
	from cjams.permanencyplan  
where permanencyplanid = '72de277d-4d97-4702-bf4f-fde7dcd93569'
	and activeflag  = 1 ;


update cjams.permanencyplan  
	set intakeservicerequestactorid = 'd25e4bf6-c685-496a-83a4-53270118fbbf',
		updatedby = 'CDM-11743',
		updatedon = now()	
where permanencyplanid = '72de277d-4d97-4702-bf4f-fde7dcd93569'
	and activeflag  = 1 ;
	
-- To Trigger Under Over
-- 2021-01-10 to 2022-01-07
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '37bf5cca-dfcf-4573-a7b2-3783556281ed'
	and activeflag = 1 ;

update cjams.gapratesrevision
	set approvaldate = now(),
		updatedby = 'CDM-11743',
		updatedon = now()	
where guardiansubsidyid = '37bf5cca-dfcf-4573-a7b2-3783556281ed'
	and activeflag = 1 ;


INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, 
		paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		gaprateid, guardiansubsidyid, providerid, alternateid, 
		etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), '2019-01-31 15:57:15', '2019-01-10 00:00:00', '2020-01-09 00:00:00', 
		852, NULL, '3047', now(), NULL, 
		now(), 'CDM-11743', now(), 'CDM-11743', 1, 
		'f50e188b-c2a0-4ed8-a157-97b26fe26a9b', '37bf5cca-dfcf-4573-a7b2-3783556281ed', 5089600, nextval('sequence_gapraterevision'::regclass), 
		NULL, NULL
	);

	
-- Client ID: 3460565	
-- Actor ID: a4b310e5-e15b-4c3a-8f31-d05bbffbb7c5  - active flag 0
-- New Actor ID: 8ccdb504-cb09-4c57-bb33-ce3f65f894e9 (update)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid  
	from cjams.permanencyplan p 
where permanencyplanid = '6b946204-39ef-4d6f-9cca-2a03f11187e5'
	and activeflag  = 1 ;

update cjams.permanencyplan  
	set intakeservicerequestactorid = '8ccdb504-cb09-4c57-bb33-ce3f65f894e9',
		updatedby = 'CDM-11743',
		updatedon = now()	
where permanencyplanid = '6b946204-39ef-4d6f-9cca-2a03f11187e5'
	and activeflag  = 1 ;


-- To Trigger Under Over
-- 2021-01-10 to 2022-01-07 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '26a9a57d-7caa-4e39-940d-aede22bc691f'
	and activeflag = 1 ;

update cjams.gapratesrevision
	set approvaldate = now(),
		updatedby = 'CDM-11743',
		updatedon = now()	
where guardiansubsidyid = '26a9a57d-7caa-4e39-940d-aede22bc691f'
	and activeflag = 1 ;


INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
		"comments", approvalstatustypekey, approvaldate, isoriginal, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		gaprateid, guardiansubsidyid, providerid, alternateid, 
		etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), '2020-03-13 13:52:18', '2020-01-10 00:00:00', '2021-01-09 00:00:00', 852, 
		NULL, '3047', now(), NULL, 
		now(), 'CDM-11743', now(), 'CDM-11743', 1, 
		'0c55dce1-82d3-423a-8995-dc23fa24f731', '26a9a57d-7caa-4e39-940d-aede22bc691f', 5089600, nextval('sequence_gapraterevision'::regclass),  
		NULL, NULL);
