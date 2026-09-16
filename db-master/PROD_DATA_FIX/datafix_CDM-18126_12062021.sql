-- CDM-18126 - GAP STUCK IN REVIEW
/*
-- Issue Description: 
   GAP Agreement is stuck in review for YACOBEY JONES CJAMS#4012994 
   USING A DIFFERENT PERMANENCY PLAN AS INTRUCTED BY K MORTON (BCDSS- CJAMS).
   
-- Case ID: 3241981 - f52bcb7d-082f-4250-8d4a-0048f46821bf
-- Client ID: 4012994 (YACOBEY JONES) - 98efe647-a917-4266-9b1b-390397295a06

-- Keep GAP ID: 1005880 - 0dd19686-c3f5-41c1-9911-8a21a8ac1e38
-- PP ID: 517ae2b3-64e6-483a-aad1-7f08d426ccf3 - update intakeservicerequestactorid

-- Delete  GAP ID: 1005688 - e581ac82-4761-45d3-9b42-919215b536d0
-- PP ID: 6befa6e6-786b-49a8-a117-4e8a458af208 - update intakeservicerequestactorid
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan -> intakeservicerequestactorid
-- 1	91b179d4-32ba-4e14-b74e-40696ac6584e	CHILD
-- 0	61d59876-78ef-4ef4-81f2-c1069079df84	LG

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid in ( '517ae2b3-64e6-483a-aad1-7f08d426ccf3',
							'6befa6e6-786b-49a8-a117-4e8a458af208' 
						  )
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '91b179d4-32ba-4e14-b74e-40696ac6584e',
	updatedby = 'CDM-18126',
	updatedon = now()
where permanencyplanid in ( '517ae2b3-64e6-483a-aad1-7f08d426ccf3',
							'6befa6e6-786b-49a8-a117-4e8a458af208' 
						  )
	and activeflag  = 1 ;
	
-- Ask user to usre PERMANENCY PLAN  - Guardianship by relative & Reunification 
select activeflag, gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid  = '0dd19686-c3f5-41c1-9911-8a21a8ac1e38'
	and activeflag = 1;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where gapid = '0dd19686-c3f5-41c1-9911-8a21a8ac1e38'
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '33961519-2592-409c-90f8-3682efe65679'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where objectid = '33961519-2592-409c-90f8-3682efe65679'
	and eventcode = 'GAAR'
	and activeflag = 1 ;

select activeflag, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementid = '33961519-2592-409c-90f8-3682efe65679'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where gapagreementid = '33961519-2592-409c-90f8-3682efe65679'
	and activeflag = 1 ;

select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = 'b8b94eba-a4cd-47ea-9771-ee4a18bd9496'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where objectid = 'b8b94eba-a4cd-47ea-9771-ee4a18bd9496'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- Delete PERMANENCY PLAN - Guardianship by relative & Guardianship by relative 
select alternateid, activeflag,  updatedby, updatedon 
	from guardianship 
where gapid = 'e581ac82-4761-45d3-9b42-919215b536d0'
	and activeflag = 1 ;

update guardianship
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where gapid = 'e581ac82-4761-45d3-9b42-919215b536d0'
	and activeflag = 1 ;

select activeflag, gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid  = 'e581ac82-4761-45d3-9b42-919215b536d0'
	and activeflag = 1;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where gapid = 'e581ac82-4761-45d3-9b42-919215b536d0'
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '0090c36f-db26-4bad-9739-714c9aff7359'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where objectid = '0090c36f-db26-4bad-9739-714c9aff7359'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
select activeflag, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementid = '0090c36f-db26-4bad-9739-714c9aff7359'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where gapagreementid = '0090c36f-db26-4bad-9739-714c9aff7359'
	and activeflag = 1 ;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid IN ( '95a204ee-c94e-4e57-88b6-150d4e9f45df',
					'164c1c68-d994-49ef-9f2d-7f20c0c3e7a6'
				  )	
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where objectid IN ( '95a204ee-c94e-4e57-88b6-150d4e9f45df',
					'164c1c68-d994-49ef-9f2d-7f20c0c3e7a6'
				  )	
	and eventcode = 'GARR'
	and activeflag = 1 ;
	
-- Delete Permanency Plan	
select permanencyplanid, activeflag, updatedby, updatedon 
	from permanencyplan 
where permanencyplanid  = '6befa6e6-786b-49a8-a117-4e8a458af208'
	and activeflag = 1 ;

update permanencyplan 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where permanencyplanid  = '6befa6e6-786b-49a8-a117-4e8a458af208'
	and activeflag = 1 ;

select routingid, eventcode, activeflag, updatedby, updatedon
	from routing 
where objectid = '6befa6e6-786b-49a8-a117-4e8a458af208'
	and eventcode = 'PPLR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-18126',
	updatedon = now()
where objectid = '6befa6e6-786b-49a8-a117-4e8a458af208'
	and eventcode = 'PPLR'
	and activeflag = 1 ;
	