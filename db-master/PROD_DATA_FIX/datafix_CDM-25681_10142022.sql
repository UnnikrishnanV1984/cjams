-- CDM-25681 - MYONNA TORRES NEEDS A NEW BEGIN DATE
/*
-- Issue Description: 
	The GAP successor guardianship has not getting any payment until now, 
	please check why the payment is not generated.

-- Case ID: 3195262 - c3bdb45f-77ee-4326-9b51-7d86f3239546
-- Client ID: 3283058 (MYONNA K TORRES) - 65d0ff17-dede-4b52-bd1d-fdf984931d5b
-- GAP ID: 1006046 - 2022-04-14 To 2026-04-03 - 6409651e-530d-4622-8291-0c2187576c57
-- Provider ID: 6007226	(WHITTNEY V BRUNSON)
-- permanencyplanid = '9491f58d-7858-409c-b9e1-a78e9587056f'
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- 0	cb6d966c-2462-4734-af24-5d1071ce9dbe	d1422cbf-c581-44f3-aa92-f99a8cf46ec3	AV
-- 1	f05e69a2-f8e5-4991-b155-803611de173b	d1422cbf-c581-44f3-aa92-f99a8cf46ec3	CHILD

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '9491f58d-7858-409c-b9e1-a78e9587056f'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'f05e69a2-f8e5-4991-b155-803611de173b',
	updatedby = 'CDM-25681',
	updatedon = now()
where permanencyplanid = '9491f58d-7858-409c-b9e1-a78e9587056f'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = 'ef032bfa-eb42-46f8-adce-6c62cb9f398a' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-25681',
	updatedon = now()
where gaprateid = 'ef032bfa-eb42-46f8-adce-6c62cb9f398a' ;
