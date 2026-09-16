-- CDM-19317 - Wrong date on adoption subsidy rate
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date (Bio Case side)
   
-- Service Case ID: 3156232 - 94388221-ebbf-42e7-86bd-528dfb8b5bf3
  
-- Category/ Module: Adoption Subsidy Planning(Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Bio Case Side
-- Delete 2021-12-21 To 2037-07-08 
select startdate, enddate, updatedby, updatedon, activeflag
	from adoptionagreementrevision  
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff'
	and adoptionagreementrevisionid 
		in ( 'e9def4bf-35b8-466c-90a5-623aba5984c6', 'e1a070e4-008c-404f-bc9c-7907806da53c' )
	and activeflag = 1 ;

update adoptionagreementrevision
set activeflag = 0,	
	updatedon = now(), 
	updatedby = 'CDM-19317'
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff'
	and adoptionagreementrevisionid 
		in ( 'e9def4bf-35b8-466c-90a5-623aba5984c6', 'e1a070e4-008c-404f-bc9c-7907806da53c' )
	and activeflag = 1 ;

-- Update 2021-11-17 To 2037-07-08 
select startdate, enddate, updatedby, updatedon, activeflag, adoptiveparent1id, adoptiveparent2id
	from adoptionagreementrevision  
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementrevisionid 
		not in ( 'e9def4bf-35b8-466c-90a5-623aba5984c6', 'e1a070e4-008c-404f-bc9c-7907806da53c' ) ;

update adoptionagreementrevision
set adoptiveparent1id = 522048,
	adoptiveparent2id = 522051,
	updatedon = now(), 
	updatedby = 'CDM-19317'
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementrevisionid 
		not in ( 'e9def4bf-35b8-466c-90a5-623aba5984c6', 'e1a070e4-008c-404f-bc9c-7907806da53c' ) ;

-- Update 2021-11-17 To 2022-11-17  (Old 2021-12-21 To 2022-12-21 )
select startdate, enddate, updatedby, updatedon
	from adoptionagreementrate 
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' ;

update adoptionagreementrate
set startdate = '2021-11-17 19:25:34',	
	enddate = '2022-11-16 00:25:34',
	updatedon = now(), 
	updatedby = 'CDM-19317'
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' ;

	 
select startdate, enddate, updatedby, updatedon, activeflag 
	from adoptionagreementraterevision 
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementraterevisionid = '2b933307-e224-48ef-9ae1-888cb5440316' 
	and activeflag = 1 ;
	
		
update adoptionagreementraterevision
set activeflag = 0,	
	updatedon = now(), 
	updatedby = 'CDM-19317'
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementraterevisionid = '2b933307-e224-48ef-9ae1-888cb5440316' 
	and activeflag = 1 ;

select startdate, enddate, updatedby, updatedon 
	from adoptionagreementraterevision 
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementraterevisionid = '36c6e226-8a77-4d42-84ba-b27478994193' 
	and activeflag = 1 ;
	
update adoptionagreementraterevision
set startdate = '2021-11-17 18:23:02',	
	enddate = '2022-11-16 22:23:02',
	updatedon = now(), 
	updatedby = 'CDM-19317'
where adoptionagreementid = 'bd7dca89-01a6-4f4d-95c4-eca359d50cff' 
	and adoptionagreementraterevisionid = '36c6e226-8a77-4d42-84ba-b27478994193' 
	and activeflag = 1 ;

select eventcode, remarks, updatedby, updatedon, activeflag 
	from routing 
where routingid = '49fc93b7-61cc-459b-ae6c-93da3e9bece9'
	and objectid = '019f82b4-a4c7-4de4-bf58-0a3b5ec59cc1'
	and activeflag = 1 ;

update routing 
set activeflag = 0,	
	updatedon = now(), 
	updatedby = 'CDM-19317'
where routingid = '49fc93b7-61cc-459b-ae6c-93da3e9bece9'
	and objectid = '019f82b4-a4c7-4de4-bf58-0a3b5ec59cc1'
	and activeflag = 1 ;
