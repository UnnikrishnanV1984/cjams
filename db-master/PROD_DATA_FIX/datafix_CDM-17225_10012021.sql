-- CDM-17225 - Delete Subsidy review
/*
-- Issue Description: 
   User request to delete 09/01/2022 Adoption Subsidy review 
   
-- Case ID: 3280288 - a66dd372-02a9-4789-9e85-9ddaf30f4fc4
-- Client ID: 4134043 (JOSHUA BRETT	BORDERS) - 83b0e9f1-9323-4c78-a3b0-3163ebbf2db0
-- Adoption ID: 47711 - 2017-08-04 To 2032-04-12 00:00:00

-- Category/ Module: Adoption Subsidy (Adoption Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 09/01/2022 Adoption Subsidy review 
select assessmentdate, activeflag, updatedby, updatedon
	from adoptioniverenewal
where adoptionid = 'a66dd372-02a9-4789-9e85-9ddaf30f4fc4'
	and adoptioniverenewalid  = '49e448ae-a9c4-47cc-8836-33d531245995'
	and activeflag = 1 ;

update adoptioniverenewal  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-17225'
where adoptionid = 'a66dd372-02a9-4789-9e85-9ddaf30f4fc4'
	and adoptioniverenewalid  = '49e448ae-a9c4-47cc-8836-33d531245995'
	and activeflag = 1 ;
	
select routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing r 
where objectid = '49e448ae-a9c4-47cc-8836-33d531245995'
	and eventcode = 'ADYR'
	and activeflag = 1 ;

update routing  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-17225'
where objectid = '49e448ae-a9c4-47cc-8836-33d531245995'
	and eventcode = 'ADYR'
	and activeflag = 1 ;
	