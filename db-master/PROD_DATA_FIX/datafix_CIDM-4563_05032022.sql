-- CIDM-4563 - Finance Report - GAP Cases
/*
-- Issue Description: 
	The GAP subisdy payments are missing. 

1. GAP ID: 1005957 - Missing Start Date & Provider ID
2. GAP ID : 1005976 - Missing Start Date
3. GAP ID : 1006008 - Missing Start Date

-- Category/ Module: GAP (Case Management) 
-- Root cause: N/A 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3230491
-- Client ID: 3588166 (BRANDY L	BUCKLEW) - ad8e9ab3-7dea-458f-89de-668bdb23a4e1
-- GAP ID: 1005957 - Null To 2030-07-02 - 6d616d2f-e3f1-4aa1-8cca-8307ae116992
-- Provider ID: 5048951	(Tyra Holland)
-- Update Start Date 2022-01-12
-- gapagreementid: 8ac300d7-3a76-4554-bf3d-de7e5c896c56

-- Update GAP Start Date as 2022-01-12  (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '6d616d2f-e3f1-4aa1-8cca-8307ae116992'
	and gapagreementid = '8ac300d7-3a76-4554-bf3d-de7e5c896c56'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2022-01-12 08:00:00',
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = '6d616d2f-e3f1-4aa1-8cca-8307ae116992'
	and gapagreementid = '8ac300d7-3a76-4554-bf3d-de7e5c896c56'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '6d616d2f-e3f1-4aa1-8cca-8307ae116992'
	and gapagreementid = '8ac300d7-3a76-4554-bf3d-de7e5c896c56' ;

update gapagreementrevision
set startdate = '2022-01-12 08:00:00',
	approvaldate = now(),
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = '6d616d2f-e3f1-4aa1-8cca-8307ae116992'
	and gapagreementid = '8ac300d7-3a76-4554-bf3d-de7e5c896c56' ;

-- Delete Duplicate Agreement
select gapagreementid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapagreementid = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and activeflag = 1 ;

update gapagreement
set activeflag = 0,
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapagreementid = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and activeflag = 1 ;

select gapagreementid, activeflag, updatedby, updatedon 
	from gapagreementrevision 
where gapagreementid = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and activeflag = 1 ;
	
update gapagreementrevision	
set activeflag = 0,
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapagreementid = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and activeflag = 1 ;

select routingid, remarks, activeflag, updatedby, updatedon 
	from routing 
where objectid  = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and eventcode= 'GAAR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CIDM-4563',
	updatedon = now()
where objectid  = 'fee9ad22-403d-450b-bc5a-e642adfd673a'
	and eventcode= 'GAAR'
	and activeflag = 1 ;

-- Case ID: 3296163
-- Client ID: 4325129 (ZARRIYAH GRINNELL) - 0d583a3d-d8f6-4bc9-924e-645e2fcd31ee
-- GAP ID: 1006008 - Null To 2032-08-11 - 483b1813-1089-4a72-a931-fb3b0bc1a26d
-- Provider ID: 5048951	(Tyra Holland)
-- Update Start Date 2022-01-27
-- gapagreementid: 51cf1b30-6899-4a3d-8b6c-62fd7c0020f0

-- Update GAP Start Date as 2022-01-27  (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = '483b1813-1089-4a72-a931-fb3b0bc1a26d'
	and gapagreementid = '51cf1b30-6899-4a3d-8b6c-62fd7c0020f0'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2022-01-27 08:00:00',
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = '483b1813-1089-4a72-a931-fb3b0bc1a26d'
	and gapagreementid = '51cf1b30-6899-4a3d-8b6c-62fd7c0020f0'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = '483b1813-1089-4a72-a931-fb3b0bc1a26d'
	and gapagreementid = '51cf1b30-6899-4a3d-8b6c-62fd7c0020f0' ;

update gapagreementrevision
set startdate = '2022-01-27 08:00:00',
	approvaldate = now(),
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = '483b1813-1089-4a72-a931-fb3b0bc1a26d'
	and gapagreementid = '51cf1b30-6899-4a3d-8b6c-62fd7c0020f0' ;
	
	
-- Case ID: 3297148
-- Client ID: 4342617 (ARIA DASILVA) - 75696fdd-8656-41af-b394-0144524101df
-- GAP ID: 1005976 - Null To 2036-05-09 - b9ff70f2-fb91-44f2-a650-527600cfa633
-- Provider ID: 5048951	(Tyra Holland)
-- Update Start Date 2022-02-24
-- gapagreementid: 4223d5e0-ba9e-40c6-8f14-1a5cac585a28
	
-- Update GAP Start Date as 2022-02-24  (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'b9ff70f2-fb91-44f2-a650-527600cfa633'
	and gapagreementid = '4223d5e0-ba9e-40c6-8f14-1a5cac585a28'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2022-02-24 08:00:00',
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = 'b9ff70f2-fb91-44f2-a650-527600cfa633'
	and gapagreementid = '4223d5e0-ba9e-40c6-8f14-1a5cac585a28'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'b9ff70f2-fb91-44f2-a650-527600cfa633'
	and gapagreementid = '4223d5e0-ba9e-40c6-8f14-1a5cac585a28' ;

update gapagreementrevision
set startdate = '2022-02-24 08:00:00',
	approvaldate = now(),
	updatedby = 'CIDM-4563',
	updatedon = now()
where gapid = 'b9ff70f2-fb91-44f2-a650-527600cfa633'
	and gapagreementid = '4223d5e0-ba9e-40c6-8f14-1a5cac585a28' ;
		