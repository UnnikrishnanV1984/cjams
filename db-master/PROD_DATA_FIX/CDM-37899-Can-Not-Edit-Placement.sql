/*
-- CDM-37899: Can not Edit Placement
-- Issue Description: 231030119492: I am attempting to correct placement provider. 
		      I have the placement under group home and need it to be adjusted to diagnostic center. 
		      The edit functions will only allow me to make comments but I can not edit the actual placement as needed. 
		      I can not also delete the entry in its entirety to make a new correct one.
-- Category/ Module: Intake/ Placement
-- Root cause: This is not a defect as per system design, the provider placement structure & program can not be edited once it is saved and submitted for supervisor approval.
-- Fix Provided: Datafix has been provided.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from placement where personid = 'd23d4aa0-7d7a-4f71-9e1e-16bce9f4264f';

update placement 
set activeflag = '0', updatedby = 'CDM-37899', updatedon = now()
where placementid = '2c877128-3baf-4c0d-940b-76991e48e5a2';

update placementrevision 
set activeflag = 0, updatedby = 'CDM-37899', updatedon = now()
where placementid = '2c877128-3baf-4c0d-940b-76991e48e5a2' and activeflag = 1;

update routing 
set activeflag = 0, updatedby = 'CDM-37899', updatedon = now()
where objectid = '2c877128-3baf-4c0d-940b-76991e48e5a2' and activeflag = 1;