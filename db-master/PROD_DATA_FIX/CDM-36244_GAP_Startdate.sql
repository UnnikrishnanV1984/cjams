/*
 Issue Description: CDM-36244
 Category/ Module : Guardianship Planning
 Root cause: GAP agreement start date was recorded wrong in application.
 Fix: Update the GAP record with the start date, which user requested
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */
-- Statd Date update
-- startdate (current) -- 2023-03-23 08:00:00
-- startdate (after change) -- 2023-03-22 08:00:00

select * from gapagreement WHERE gapagreementid = '3b2c15bc-b75e-4790-a8ff-578927beb586'; 

UPDATE gapagreement
	SET startdate = '2023-03-22 08:00:00',
		updatedon = now(),
		updatedby = 'CDM-36244'
	WHERE gapagreementid = '3b2c15bc-b75e-4790-a8ff-578927beb586'; 
	
	
select * from gapagreementrevision where gapagreementid = '3b2c15bc-b75e-4790-a8ff-578927beb586' and activeflag = 1; 	

UPDATE gapagreementrevision
	SET startdate = '2023-03-22 08:00:00',
		approvaldate = now(),
		updatedon = now(),
		updatedby = 'CDM-36244'
	WHERE gapagreementid = '3b2c15bc-b75e-4790-a8ff-578927beb586'
		and activeflag = 1; 
	
-- No changes needed as startdate is already 2023-03-22 in below tables
select * from gapagreementrate where gapagreementrateid = 'b5b75ffa-180f-4446-8258-d59f303e085c';
select * from gapratesrevision where gaprateid = 'b5b75ffa-180f-4446-8258-d59f303e085c'; 