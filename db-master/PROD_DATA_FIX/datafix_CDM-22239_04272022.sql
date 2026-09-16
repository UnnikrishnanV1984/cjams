-- CDM-22239 - Date Correction
/*
-- Issue Description: 
   User request to change the Rate start date of GAPs

-- Case ID: 3079090
-- Provider ID: 5021942	(Tina Wilson) - Local Department Home
-- Client ID: 2904324 (ANNA LANCASTER) - 7b927b9f-2bed-467a-b507-34d21b0ea39b
-- GAP ID: 2066 - 2012-01-23 To 2023-11-16 - 311ce3ea-6883-4968-927f-a4174b7548c0
-- gapagreementid : cb2d63d7-dbb9-4f83-8641-4dd54cada696
-- gapagreementrateid: f5bd6c06-b3cd-49f9-bd66-9dc47ecb8064

-- Client ID: 1422240 (PABLO LANCASTER) - cb6fa1ac-337d-4a85-8e92-d5ec23cedde2
-- GAP ID: 2067 - 2012-01-23 To 2022-12-06 - c11bb1ea-930c-4eee-bbc6-84b6e2bfd6f9
-- gapagreementid : 6b8da57f-871c-4009-b820-1c11108eedd0
-- gapagreementrateid: 307cd54d-5ce4-4fec-a11f-a722d5da6725

-- Update GAP Rate Start Date as March 1, 2022 

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update most recent GAP Rate Slab Dates as 2022-03-01 04:00:00 To 2023-02-28 10:00:00
-- (Current Rate Dates: 2022-04-01 04:00:00	2023-01-21 10:00:00)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid 
	in (	'f5bd6c06-b3cd-49f9-bd66-9dc47ecb8064',
			'307cd54d-5ce4-4fec-a11f-a722d5da6725'
		)	
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2022-03-01 04:00:00',
	enddate = '2023-02-28 10:00:00',
	updatedon = now(), 
	updatedby = 'CDM-22239'
where gapagreementrateid 
	in (	'f5bd6c06-b3cd-49f9-bd66-9dc47ecb8064',
			'307cd54d-5ce4-4fec-a11f-a722d5da6725'
		)	
	and activeflag = 1 ;

	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid 
	in (	'f5bd6c06-b3cd-49f9-bd66-9dc47ecb8064',
			'307cd54d-5ce4-4fec-a11f-a722d5da6725'
		)	
;

update gapratesrevision
set ratestartdate = '2022-03-01 04:00:00',
	rateenddate = '2023-02-28 10:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-22239'
where gaprateid 
	in (	'f5bd6c06-b3cd-49f9-bd66-9dc47ecb8064',
			'307cd54d-5ce4-4fec-a11f-a722d5da6725'
		)	
;
