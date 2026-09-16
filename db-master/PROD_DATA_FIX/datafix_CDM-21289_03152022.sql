-- CDM-21289 - GAP payments not generating
/*
-- Issue Description: 
	The GAP payments are not generating for Dayvon and Christian Best. 
	The provider is #6002667
	
-- Case ID: 3179658 - joy.iregbu@maryland.gov
-- Provider ID: 6002667 (Hilda Mae Gillyard) 
-- Client ID: 3334110 (DAYVON BEST) - 53462863-136f-4345-bb30-8a53b66a8389 
-- GAP ID: 1005959 - Null To 2030-01-16 - 11c7598e-3e34-43a0-906f-9fd4f1162358
-- gapagreementid: 1e15d301-a638-4e93-9863-116ee43e5a51

-- Client ID: 3483789 (CHRISTIAN M BEST) - ad671043-badd-478e-8806-965b44a3f4db
-- GAP ID: 1005960 - Null To 2030-12-10 - cc041df9-3f99-44d7-b4d2-d2df01359d42
-- gapagreementid: cba6ee44-16e2-4769-8398-848bacbc1f8d
-- Start Date: 2021-12-10

-- Category/ Module: GAP (Case Management) 
-- Root cause:  This error was introduced with GAP refinement user story in Dec 2021 
--				and the code fix are done for this issue. This is one of the GAP created back then.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 2021-12-10 (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid in (	'11c7598e-3e34-43a0-906f-9fd4f1162358',
					'cc041df9-3f99-44d7-b4d2-d2df01359d42'
				)	
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-10 04:00:00',
	updatedby = 'CDM-21289',
	updatedon = now()
where gapid in (	'11c7598e-3e34-43a0-906f-9fd4f1162358',
					'cc041df9-3f99-44d7-b4d2-d2df01359d42'
				)	
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid in (	'11c7598e-3e34-43a0-906f-9fd4f1162358',
					'cc041df9-3f99-44d7-b4d2-d2df01359d42'
				);

update gapagreementrevision
set startdate = '2021-12-10 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-21289',
	updatedon = now()
where gapid in (	'11c7598e-3e34-43a0-906f-9fd4f1162358',
					'cc041df9-3f99-44d7-b4d2-d2df01359d42'
				);

