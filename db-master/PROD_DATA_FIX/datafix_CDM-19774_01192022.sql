-- CDM-19774 - GAP Subsidy Payment
/*
-- Issue Description: 
   The system did not generate payment for a provider for two months after Annual Review and Agreement were updated.

-- Case ID: 3175612
-- Client ID: 2683438 (RODNEY BOWSER) - 8a0113a8-a4db-4b83-9619-c081573f24dc
-- GAP ID: 1636 - 2011-04-29 To 2024-11-03 - e89aeba2-ef2f-4914-b694-00a054d654a0
-- Provider ID: 5047860	(Chemere Watson)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Rate Start Date as 11/04/2021 (old value is 04/28/2022)
select startdate, enddate, updatedby, updatedon, activeflag 
	from gapagreementrate  
where gapagreementrateid = 'b9c729ac-9899-4cb8-bbf0-120d754dea6f'
	and activeflag = 1 ;
	
update gapagreementrate  
set startdate = '2021-11-04 12:00:000',
--	enddate = '2022-11-03 08:00:00',
	updatedon = now(), 
	updatedby = 'CDM-19774'
where gapagreementrateid = 'b9c729ac-9899-4cb8-bbf0-120d754dea6f'
	and activeflag = 1 ;
	
select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
	from gapratesrevision 
where gaprateid = 'b9c729ac-9899-4cb8-bbf0-120d754dea6f';

update gapratesrevision
set ratestartdate = '2021-11-04 12:00:000',
--	rateenddate = '2022-11-03 08:00:00',
	approvaldate = now(),	
	updatedon = now(), 
	updatedby = 'CDM-19774'
where gaprateid = 'b9c729ac-9899-4cb8-bbf0-120d754dea6f';


