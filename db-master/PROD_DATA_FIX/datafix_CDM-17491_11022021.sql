-- CDM-17491 - GAP agreement stuck in review
/*
-- Issue Description: 
   GAP Agreement is stuck in review for Jayden Smith. 
   Under the first permanency plan marked reunification. 
   I Went into Brandi's box to complete the approval, system says its been updated successfully but continues to read in review.
   

-- Case ID: 3286587
-- Client ID: 4217743 (JAYDEN SMITH) - 57241a00-0b40-4db4-bcd5-adce2bf2a0d1
-- GAP ID: 1005860 - 2021-06-30 To 2036-09-10 - 96d9e634-1b74-4c6c-a4e0-cdab0cbe0869
-- Provider ID: 5089089	(Yolanda Dale) 
-- Permanency Plan ID: 1c475d08-7a0f-48cf-8ec2-2d2bbb60d2d5
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan -> intakeservicerequestactorid
-- 1	af6d5f1f-8c78-41a2-b2e2-64004aa3fb6b	CHILD
-- 0	b89fc8d3-23de-4dda-bd71-dcebb631201d	AV

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '1c475d08-7a0f-48cf-8ec2-2d2bbb60d2d5'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'af6d5f1f-8c78-41a2-b2e2-64004aa3fb6b',
	updatedby = 'CDM-17491',
	updatedon = now()
where permanencyplanid = '1c475d08-7a0f-48cf-8ec2-2d2bbb60d2d5'
	and activeflag  = 1 ;
	
-- Delete PERMANENCY PLAN  - Guardianship by relative 
select activeflag, gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid  = '96d9e634-1b74-4c6c-a4e0-cdab0cbe0869'
	and activeflag = 1;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where gapid = '96d9e634-1b74-4c6c-a4e0-cdab0cbe0869'
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '34a69229-5b0e-4d8c-bded-83fadeb811c5'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where objectid = '34a69229-5b0e-4d8c-bded-83fadeb811c5'
	and eventcode = 'GAAR'
	and activeflag = 1 ;

select activeflag, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementid = '34a69229-5b0e-4d8c-bded-83fadeb811c5'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where gapagreementid = '34a69229-5b0e-4d8c-bded-83fadeb811c5'
	and activeflag = 1 ;

select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '246ad5e2-559e-4abc-8045-b51f4f97534d'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where objectid = '246ad5e2-559e-4abc-8045-b51f4f97534d'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- Delete PERMANENCY PLAN - Reunification
select alternateid, activeflag,  updatedby, updatedon 
	from guardianship 
where gapid = '0dc02a8c-c147-4e22-8dc4-a8a4f5518935'
	and activeflag = 1 ;

update guardianship
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where gapid = '0dc02a8c-c147-4e22-8dc4-a8a4f5518935'
	and activeflag = 1 ;

select activeflag, gapid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapid  = '0dc02a8c-c147-4e22-8dc4-a8a4f5518935'
	and activeflag = 1;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where gapid = '0dc02a8c-c147-4e22-8dc4-a8a4f5518935'
	and activeflag = 1;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '4398587c-30d9-4f38-81e3-d757d50fd708'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
update routing 
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where objectid = '4398587c-30d9-4f38-81e3-d757d50fd708'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
	
select activeflag, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementid = '4398587c-30d9-4f38-81e3-d757d50fd708'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where gapagreementid = '4398587c-30d9-4f38-81e3-d757d50fd708'
	and activeflag = 1 ;
	
select eventcode, routingstatustypeid, activeflag, updatedby, updatedon 
	from routing 
where objectid = '69f26f55-baa3-4104-8c8b-20cd398ff2fb'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-17491',
	updatedon = now()
where objectid = '69f26f55-baa3-4104-8c8b-20cd398ff2fb'
	and eventcode = 'GARR'
	and activeflag = 1 ;
	