/*
   Issue Description: CDM-19376
   Category/ Module  : Person - Child removal history
   Root cause: User wants remove the duplicate entry from child removal history screen.
   Pull request# for code fix: 4576
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update Intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-19376', updatedon  = now()  where intakeservreqchildremovalid in ( '31810b1b-73cb-4911-a34b-67c38e007588', 'bc4f07a2-66d2-4f9e-abd2-2b70defb4007') and activeflag = 1;