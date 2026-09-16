-- CDM-42072 -Parent signature answer to the question needs changed on child removal tab.
/*
-- Issue Description: 
  231030174784:A data fix is needed for the child removal for a VPA.
  The question of "Have both parents signed the agreement?" has a yes checked and it should be a "NO."
  The father Lawrence Krupa was not available to sign. This is a critical need for IV-E as the case will remain incomplete as they are unable to change. 
   
-- Category/ Module: Child Removal 
-- Root cause:The question of "Have both parents signed the agreement?" has a yes checked and it should be a "NO." The father Lawrence Krupa was not available to sign so need to change on child removal tab. 
-- Fix Provided: Data fix to change the isbothparentssigned column value from 1 to 2 from intakeservreqchildremoval table. */


update intakeservreqchildremoval
set isbothparentssigned = 2,
	updatedby = 'CDM-42072',
	updatedon = now()
where intakeservreqchildremovalid = '74347bac-4db5-4cfe-be4a-8f473ede400b'; 