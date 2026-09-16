-- CDM-42803-Delete Living Arrangement  
/*
File Name: CDM-42803-livingarrangement-DeleteLivingArrangement 
-- Issue Description: 
   For the Case Id 3233880  Unable to end Living arrangement even though the discharge date and end date are same, application is still throwing the error 'Please select exit date and discharged date should be same'.
    Client ID: 3609104
    Case Number: 3233880 CLient Email ID :aaliyah.rivers2@maryland.gov

-- Resolution: Updated the activeflag to zero in the placement and livingarrangement table

-- Category/ Module: Case Management
-- Root cause: As per the recent changes made with user story B-186261 Hospitalization Tab, Living arrangement for Hospitalization should be created from Hospitalization tab. 
    Since User created living arrangement from Placement tab, system is not allowing to end the hospitalization. Hence we are deleting the one that's created from Placement tab and asking user to create a new one from Hospitalization tab to proceed further.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select activeflag,* from placement where placementid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
*/
update
	placement
set
	activeflag = 0,
	updatedby = 'CDM-42803',
	updatedon = now()
where
	placementid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
	and activeflag = 1;
/*
select activeflag,* from livingarrangement where placementid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
*/
update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CDM-42803',
	updatedon = now()
where
	placementid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
	and activeflag = 1;

/*
select * from routing r
where objectid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
and activeflag = 1;
*/

update routing 
set activeflag = 0,
	updatedby = 'CDM-42803',
	updatedon = now()
where objectid = 'e421417a-88f6-43a9-b7d4-db055a41dd53'
and activeflag = 1;
	