-- CDM-20461 - Hospital Overstay Request not found
/*
-- Issue Description: 
   Code 7108 Hosptial Overstay Purchase Authorization request was submitted to the SSA Placment Manager 
   on 12/15/2021 however it is not showing in the SSA Placement Manager's inbox. 
	
-- Case ID: 3293923
-- Client ID: 3905366 (DJORIAN E SMITH)- 977b7270-f5ba-418a-a0ba-67241d814833
-- Provider ID: 5009247	(Kennedy Krieger Institute)
-- Authorization ID: 1810218 - 06/03/2021 To 06/09/2021
-- Service: Hospital Overstay - Inpatient Medical (Paid)
-- Fiscal Category Code: 7108 Hospital/Psych Overstay

-- Category/ Module: Service Purchase Authorization (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/
-- To update toroleid column as Finance role
select objectid, eventcode, routingstatustypeid, tosecurityusersid, fromroleid, toroleid, updatedby, updatedon
	from routing 
where routingid = 'd8dff9ea-5abb-4b5a-933d-118e0adbd70d'
	and activeflag = 1 ;

update routing
set toroleid = 'FNSFW',
	updatedby = 'CDM-20461',
	updatedon = now()
where routingid = 'd8dff9ea-5abb-4b5a-933d-118e0adbd70d'
	and activeflag = 1 ;