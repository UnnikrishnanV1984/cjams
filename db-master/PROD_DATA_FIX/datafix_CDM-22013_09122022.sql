-- CDM-22013 - Response timer incorrect
/*
-- Issue Description: 
   User requested to update the response timer at 03/28/2022 - 12:00 PM
   
-- CPS-IR: 221020200138 - cbb21f1e-3a08-4fc2-a8bf-a760bd1c964b

-- Category/ Module: Response Timer  (Investigation Management) 
-- Root cause: The newborn child was added to the CPS case   
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '221020200138'
	and activeflag = 1 ;

update intakeservicerequest
set responsetimer = '2022-03-28 12:00:00',
	responsetimerdetails = '[{"roletype":"AV","contactdate":"2022-03-28T12:00:00","witsid":9866049},{"roletype":"ICC","contactdate":"2022-03-28T12:00:00","witsid":9866049},{"roletype":"OTH","contactdate":"2022-03-28T12:00:00","witsid":9866049}]',
	updatedby = 'CDM-22013',
	updatedon = now()
where servicerequestnumber = '221020200138'
	and activeflag = 1 ;
