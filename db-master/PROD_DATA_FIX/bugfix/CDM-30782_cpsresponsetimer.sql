-- CDM-30782 - Response timer incorrect
/*
-- Issue Description: 
  The response timer will not stop despite completing face to face with the children and attempt with the ICC
   
-- CPS-IR: 231020500446 

-- Category/ Module: Response Timer  (Investigation Management) 
-- Root cause:    
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020500446'
	and activeflag = 1 ;

update intakeservicerequest
set responsetimer = '2023-04-18 14:54:00',
	responsetimerdetails = '[{"roletype":"AV","contactdate":"2023-04-18T09:48:00","witsid":10729026},{"roletype":"ICC","contactdate":"2023-04-18T14:54:00","witsid":10730584},{"roletype":"OTH","contactdate":"2023-04-18T09:48:00","witsid":10729026}]',
	updatedby = 'CDM-30782',
	updatedon = now()
where servicerequestnumber = '231020500446'and activeflag = 1 ;