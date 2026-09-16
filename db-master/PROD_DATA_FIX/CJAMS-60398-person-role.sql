/*
-- Issue Description: 
    The alleged maltreator role is showing when you go into Peal Cole’s persons card but from the persons tab it is just showing as parent.
    When you go to maltreatment allegation tab, it says no alleged maltreator to be able to complete this tab to start the investigation findings.
   CASE: 251023084851
-- Category/ Module: Case Data (Case Management)
-- Root cause: wrong actor ID was mapped 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakeservicerequestactor
set actorid = '0e232a2c-433b-4ddc-b2f0-199ecdf42ce4',--cb6f9e04-110d-4256-b908-75b46cbd22c1
	updatedby = 'CJAMS-60398',--5e46d48e-82ff-45dc-9b4d-e68edb67cafc
	updatedon = now()
where intakeservicerequestactorid = '221d85c9-177d-4b87-89dc-d99ba1a4f1c4'
and actorid = 'cb6f9e04-110d-4256-b908-75b46cbd22c1' and activeflag = 1;