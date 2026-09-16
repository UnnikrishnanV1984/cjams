-- CDM-19958 - Placement
/*
-- Issue Description: 
   User request delete the 4 living arrangement (Placement) and update end date for one.
   
-- Case ID: 3247132
-- Client ID: 2380118 (KAMAR DAYSHAWN THOMPSON) - cca1ec4e-5842-4812-9d81-9a17760b6263
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete the below 4 living arrangements (Placements)
/*
3084e99f-eb9b-4cfe-b88e-61749808b734	1513497	LA	2017-12-14 2021-01-15 Trial visit home
553c01ec-7a5c-45d6-96d7-3e85678ea10a	1513498	LA	2017-12-06 2017-12-14 Inpatient Psychiatric Care
5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4	1513499	LA	2017-12-03 2017-12-06 Inpatient Psychiatric Care
76a27124-ba7d-4305-bdc3-2989a8843ef5	1513500	LA	2017-12-01 2017-12-03 Trial visit home
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag = 1 ;
	
update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-19958',
	updatedon = now()
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-19958',
	updatedon = now()
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag  = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-19958',
	updatedon = now()
where placementid 
	in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
			'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
			'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
			'76a27124-ba7d-4305-bdc3-2989a8843ef5'
		)
	and activeflag = 1 ;
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid 
		in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
				'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
				'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
				'76a27124-ba7d-4305-bdc3-2989a8843ef5'
			)
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-19958',
	updatedon = now()
where objectid 
		in ( 	'3084e99f-eb9b-4cfe-b88e-61749808b734',
				'553c01ec-7a5c-45d6-96d7-3e85678ea10a',
				'5a0b6839-cbdb-4f2e-b4b4-d6d22e91cad4',
				'76a27124-ba7d-4305-bdc3-2989a8843ef5'
			)
	and eventcode = 'PLTR'
	and activeflag = 1 ;

/*
Update the End date for the below living arrangement (Placement) as 11/30/2017 12AM

daffa888-981f-4dc4-95d0-f8f84724f662	1513501	LA	2017-11-22 2017-12-01 Runaway
*/
select activeflag, alternateid, placementtypekey, 
	startdatetime, starttime, enddatetime, endtime, updatedby, updatedon
from placement 
where placementid = 'daffa888-981f-4dc4-95d0-f8f84724f662'
	and activeflag = 1 ;
	
update placement  
set enddatetime = '2017-11-30 00:00:00',
	endtime = '12:00',
	updatedon = now(), 
	updatedby = 'CDM-19958'
where placementid = 'daffa888-981f-4dc4-95d0-f8f84724f662'
	and activeflag = 1 ;

/* 
-- No data
select activeflag, entrydate, entrytime, exitdate, exittime, updatedby, updatedon 
	from placementrevision 
where placementid = 'daffa888-981f-4dc4-95d0-f8f84724f662'
	and activeflag  = 1 ;
	
update placementrevision 
set exitdate = '2017-11-30 00:00:00',
	exittime = '12:00',
	updatedby = 'CDM-19958',
	updatedon = now()
where placementid = 'daffa888-981f-4dc4-95d0-f8f84724f662'
	and activeflag = 1 ;
*/