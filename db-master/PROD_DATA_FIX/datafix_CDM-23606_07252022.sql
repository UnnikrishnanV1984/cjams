-- CDM-23606 - Payment is incorrect
/*
-- Issue Description: 
	The new guardian parent (Vickie Pawley) does not received any payment from June 2022.

-- Case ID: 3235885
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3162179 (OLIVIA N	PAWLEY) - e2f27ae4-876d-4043-a52d-d6f482fc47d0
-- GAP ID: 3866 - 2015-06-25 To 2028-01-30 - dff6b6c2-fbea-4da1-929a-24a031635af9
---------------------------------------------------------------------------------------
-- gapagreementrate & gapratesrevision (update approvaldate)
-- Delete 
-- 5075404	83d6320a-f12e-41bb-ba03-6b3d715804e3	2022-06-25 08:00:00	2022-06-01 04:00:00

-- Update End date as 2022-05-31 08:00:00
-- 5075404	6dac4b86-1c43-466d-8598-47a4127485cc	2021-06-25 00:00:00	2022-06-24 04:00:00

-- Update Start date as 2022-06-01 08:00:00 and end date as 2023-05-31 08:00:00
-- 6006520	9be30bdf-ccd9-4348-8908-d3890275e9e8	2022-06-02 08:00:00	2023-06-01 08:00:00


-- Client ID: 3622473 (SOPHIA PAWLEY) - 6571aac0-20b0-4c8f-a8b5-f9f73bb9fbc0
-- GAP ID: 3868 - 2015-06-25 To 2031-02-07 - fcbfdf63-2aa7-45c2-beb1-c4d24ac1ffdd
---------------------------------------------------------------------------------------
-- gapagreementrate & gapratesrevision (update approvaldate)
-- Delete 
-- 5075404	ffc79fb2-eb74-428e-8819-7de07140f929	2022-06-25 08:00:00	2022-06-01 04:00:00

-- Update End date as 2022-05-31 08:00:00 
-- 5075404	23f2bed4-c268-4da4-a1fc-74c908ccf31b	2021-06-25 00:00:00	2022-06-24 04:00:00

-- Update Start date as 2022-06-01 08:00:00 and end date as 2023-05-31 08:00:00
-- 6006520	cc6eb1ad-e5db-4b86-b25b-f9ef64f6f548	2022-06-02 08:00:00	2023-06-01 08:00:00


-- Client ID: 3622474 (CARTER MICHEAL PAWLEY) - 38ccba82-7342-48ac-bce4-7ff080cc8c9a
-- GAP ID: 3867 - 2015-06-25 To 2030-04-09 - 08e13ab8-5b56-4308-98b0-f5ac50c8ea8a
---------------------------------------------------------------------------------------
-- gapagreementrate & gapratesrevision (update approvaldate)
-- Delete 
-- 5075404	39549705-92c8-40b9-8cc8-3591fe8f2e38	2022-06-25 08:00:00	2022-06-01 04:00:00

-- Update End date as 2022-05-31 08:00:00
-- 5075404	bf0baf64-0ff5-443a-8fcf-1d9e60fde9ea	2021-06-25 00:00:00	2022-06-24 04:00:00

-- Update Start date as 2022-06-01 08:00:00 and end date as 2023-05-31 08:00:00
-- 6006520	af8ad8ee-0b84-4b62-94e1-a2f895c45534	2022-06-02 08:00:00	2023-06-01 08:00:00

-- Delete 
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid 
	in ( '83d6320a-f12e-41bb-ba03-6b3d715804e3', 
		'ffc79fb2-eb74-428e-8819-7de07140f929',
		'39549705-92c8-40b9-8cc8-3591fe8f2e38' 
		)
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-23606',
	updatedon = now()
where gapagreementrateid 
	in ( '83d6320a-f12e-41bb-ba03-6b3d715804e3',
		'ffc79fb2-eb74-428e-8819-7de07140f929',
		'39549705-92c8-40b9-8cc8-3591fe8f2e38' 
		)
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision
where gaprateid 
	in ( '83d6320a-f12e-41bb-ba03-6b3d715804e3',
		'ffc79fb2-eb74-428e-8819-7de07140f929',
		'39549705-92c8-40b9-8cc8-3591fe8f2e38' 
		)
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-23606',
	updatedon = now()
where gaprateid 
	in ( '83d6320a-f12e-41bb-ba03-6b3d715804e3',
		'ffc79fb2-eb74-428e-8819-7de07140f929',
		'39549705-92c8-40b9-8cc8-3591fe8f2e38' 
		)
	and activeflag = 1 ;
	
	
-- Update End date as 2022-05-31 08:00:00 
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid 
	in ( '6dac4b86-1c43-466d-8598-47a4127485cc',
		'23f2bed4-c268-4da4-a1fc-74c908ccf31b',
		'bf0baf64-0ff5-443a-8fcf-1d9e60fde9ea'
 		)
	and activeflag = 1 ;
	
update gapagreementrate 
set enddate = '2022-05-31 08:00:00',
	updatedby = 'CDM-23606',
	updatedon = now()
where gapagreementrateid 
	in ( '6dac4b86-1c43-466d-8598-47a4127485cc',
		'23f2bed4-c268-4da4-a1fc-74c908ccf31b',
		'bf0baf64-0ff5-443a-8fcf-1d9e60fde9ea'
 		)
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision
where gaprateid 
	in ( '6dac4b86-1c43-466d-8598-47a4127485cc',
		'23f2bed4-c268-4da4-a1fc-74c908ccf31b',
		'bf0baf64-0ff5-443a-8fcf-1d9e60fde9ea'
 		) ;

update gapratesrevision
set rateenddate = '2022-05-31 08:00:00',
	updatedby = 'CDM-23606',
	updatedon = now()
where gaprateid 
	in ( '6dac4b86-1c43-466d-8598-47a4127485cc',
		'23f2bed4-c268-4da4-a1fc-74c908ccf31b',
		'bf0baf64-0ff5-443a-8fcf-1d9e60fde9ea'
 		) ;


-- Update Start date as 2022-06-01 08:00:00 and end date as 2023-05-31 08:00:00
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid 
	in ( '9be30bdf-ccd9-4348-8908-d3890275e9e8',
		'cc6eb1ad-e5db-4b86-b25b-f9ef64f6f548',
		'af8ad8ee-0b84-4b62-94e1-a2f895c45534'
 		)
	and activeflag = 1 ;
	
update gapagreementrate 
set startdate = '2022-06-01 08:00:00',
	enddate = '2023-05-31 08:00:00',
	updatedby = 'CDM-23606',
	updatedon = now()
where gapagreementrateid 	
	in ( '9be30bdf-ccd9-4348-8908-d3890275e9e8',
		'cc6eb1ad-e5db-4b86-b25b-f9ef64f6f548',
		'af8ad8ee-0b84-4b62-94e1-a2f895c45534'
 		)
	and activeflag = 1 ;
	
-- Trigger Under Over 	
select providerid, ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision
where gaprateid 
	in ( '9be30bdf-ccd9-4348-8908-d3890275e9e8',
		'cc6eb1ad-e5db-4b86-b25b-f9ef64f6f548',
		'af8ad8ee-0b84-4b62-94e1-a2f895c45534'
 		) ;

update gapratesrevision
set ratestartdate = '2022-06-01 08:00:00',
	rateenddate = '2023-05-31 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-23606',
	updatedon = now()
where gaprateid 
	in ( '9be30bdf-ccd9-4348-8908-d3890275e9e8',
		'cc6eb1ad-e5db-4b86-b25b-f9ef64f6f548',
		'af8ad8ee-0b84-4b62-94e1-a2f895c45534'
 		)
;

