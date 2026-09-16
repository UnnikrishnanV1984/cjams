-- CDM-22301 - Payment is not interfacing
/*
-- Issue Description: 
	The GAP subisdy payments are missing. 

-- Case ID: 3287222
-- Client ID: 4224079 (WILLIAM F JONES) - f4dcaaab-528c-4b1b-8f04-41de2bd99c97
-- Provider ID: 5092960 (Ashley Ross) 
-- GAP ID: 1005935 - Null To 2031-08-21 - afa0dcdd-7ba8-4f24-b511-50ad3b8926ae
-- gapagreementid: 04266d8c-d559-462e-9075-5e55ca3d3729
-- Update Start date as 12/03/2021 (2021-12-03)

-- Category/ Module: GAP (Case Management) 
-- Root cause: N/A 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP Start Date as 12/03/2021  (current value is NULL)
select startdate, enddate, updatedby, updatedon
	from gapagreement  
where gapid = 'afa0dcdd-7ba8-4f24-b511-50ad3b8926ae'
	and activeflag = 1 ;

update gapagreement 
set startdate = '2021-12-03 08:00:00',
	updatedby = 'CDM-22301',
	updatedon = now()
where gapid = 'afa0dcdd-7ba8-4f24-b511-50ad3b8926ae'
	and activeflag = 1 ;

select startdate, enddate, approvaldate, activeflag, updatedby, updatedon 
	from gapagreementrevision  
where gapid = 'afa0dcdd-7ba8-4f24-b511-50ad3b8926ae' ;

update gapagreementrevision
set startdate = '2021-12-03 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-22301',
	updatedon = now()
where gapid = 'afa0dcdd-7ba8-4f24-b511-50ad3b8926ae' ;

-- Delete Incorrect Suspension record
select startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapsuspensionid = '316e974e-865c-45c3-bd0c-124b37100777' 
	and activeflag = 1 ;

update cjams.gapsuspension  
set enddate = startdate,
	activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-22301'
where gapsuspensionid = '316e974e-865c-45c3-bd0c-124b37100777' 
	and activeflag = 1 ;

select startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspensionrevision 
where suspensionid = '316e974e-865c-45c3-bd0c-124b37100777' ;

update cjams.gapsuspensionrevision  
set enddate = startdate,
	activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-22301'
where suspensionid = '316e974e-865c-45c3-bd0c-124b37100777' ;

select eventcode, objectid, remarks, activeflag, updatedby, updatedon
	from cjams.routing
where routingid = '2a7175c4-709f-4086-ab91-f6b882e8392b'
	and activeflag = 1 ;
	
update cjams.routing  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-22301'
where routingid = '2a7175c4-709f-4086-ab91-f6b882e8392b'
	and activeflag = 1 ;
