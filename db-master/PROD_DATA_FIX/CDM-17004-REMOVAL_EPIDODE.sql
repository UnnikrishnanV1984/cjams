/*
   Issue Description: CDM-17004
   Category/ Module  : removal epidode
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  doing inner join Child removal table with Intakeservicerequestactor to fetch the child removal data.  But  Intakeservicerequestactor table having activeflag as 0 for that particular row. So took the correct  Intakeservicerequestactorid and updated
   
*/


update intakeservreqchildremoval 
	set intakeservicerequestactorid = 'f8f1eeaf-019d-48ec-9824-394c16bcd4ca', updatedby = 'CDM-17004', updatedon = now()
	where intakeservreqchildremovalid = 'ca057a3d-b875-4c31-9738-a28e0d33c4ae';