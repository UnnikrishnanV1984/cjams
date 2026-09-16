-- CDM-14725 - Response Timer
/*
-- Issue Description: 
   User requested to update the response timer at 04/18/2021 at 11:42 AM.
   
-- CPS-AR: 202101090102509 - 80203a56-a02a-42c0-8a15-1d152be2e3cf   
-- Category/ Module: Response Timer  (Investigation Management) 
-- Root cause: This case is not having ICC and the response timer was stopped before new code changes  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/


UPDATE intakeservicerequest
SET responsetimer = '2021-04-18 11:42:00.000',
	updatedby = 'CDM-14725',
	updatedon = now()
WHERE servicerequestnumber = '202101090102509';