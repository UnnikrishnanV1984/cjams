-- CDM-13431 - Case Suspension
/*
-- Issue Description: 
	Case was suspended on 9/16/19 in the CHESSIE System. 
	Case does not show suspension approval in CJAMS. 
	I am unable to approve the suspension in CJAMS. 
	This has caused an overpayment. Suspension needs to be approved.
   
	Adoption Case ID: 3250169
	Client ID: 3759918 (SOMMER DENISE RODGERS) - 57fb4db2-e0f2-4250-abf0-2be2c6848871
    Adoption ID: 42822 - 2015-01-21 To 2021-12-28 -- c7a3c23d-2058-4e1e-be2d-2815da9b5302
	
-- Category/ Module: Adoption Subsidy (Adoption Case Management) 
-- Root cause: CHESSIE Data Issue, Active Suspension data with No routing record.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to remove Suspension records, so that user can add new suspension starting 09/16/2019
select adoptionsuspensionid, suspensionbegindate, suspensionenddate, activeflag, updatedby, updatedon 
	from adoptioncasesuspension 
where adoptioncaseid = 'c7a3c23d-2058-4e1e-be2d-2815da9b5302'
	and activeflag = 1 ;

update adoptioncasesuspension
set activeflag = 0,
	updatedby = 'CDM-13431',
	updatedon = now()
where adoptioncaseid = 'c7a3c23d-2058-4e1e-be2d-2815da9b5302'
	and activeflag = 1 ;
