-- CDM-22410 - KEVIN CORBETT, NO EXIT PLACEMENT
/*
-- Issue Description: 
   User error to Remove the hanging on 	Guardianship Disclosure Review reuest
   and update ens date for migrated voided palcement

-- Category/ Module: GAP/Placement (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case ID: 3286758 (CHASITY L MALONE)
-- Client ID: 3850398 (KEVIN A CORBETT) - f8e3541d-6b7a-428c-8493-661fa63df1b1
-- Voided Placement ID: 326219 - 2018-04-16 To Null - 483c53f4-0920-4e93-9be4-4f0a53aafe7c
-- Provider ID: 5088925	(Dietrich Davis) 

select alternateid, startdatetime, starttime, enddatetime, endtime, updatedby, updatedon 
	from placement 
where placementid = '483c53f4-0920-4e93-9be4-4f0a53aafe7c'
	and activeflag = 1 ;

update placement
set starttime = '15:17', 
	enddatetime = '2018-04-23 12:58:24',
	endtime = '12:58',
	updatedby = 'CDM-22410',
	updatedon = now()
where placementid = '483c53f4-0920-4e93-9be4-4f0a53aafe7c'
	and activeflag = 1 ;

-- No Date in placementrevision

-- Case ID: 3195262 (INDIA E BERRAIN)
-- Client ID: 3283058 (MYONNA K	TORRES) - 65d0ff17-dede-4b52-bd1d-fdf984931d5b
-- Delete duplicate GAP Disclosure & Routing Records

select gapdisclosureid, activeflag, updatedby, updatedon 
	from gapdisclosure
where gapdisclosureid = 'c192c48a-3be0-4fdf-bb45-7ac8968869e8'
	and activeflag = 1 ; 
	
update gapdisclosure
set activeflag = 0,	
	updatedby = 'CDM-22410',
	updatedon = now()
where gapdisclosureid = 'c192c48a-3be0-4fdf-bb45-7ac8968869e8'
	and activeflag = 1 ; 

select objectid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon
	from routing
where objectid = 'c192c48a-3be0-4fdf-bb45-7ac8968869e8'
	and activeflag = 1 ;

update routing
set activeflag = 0,	
	updatedby = 'CDM-22410',
	updatedon = now()
where objectid = 'c192c48a-3be0-4fdf-bb45-7ac8968869e8'
	and activeflag = 1 ;
