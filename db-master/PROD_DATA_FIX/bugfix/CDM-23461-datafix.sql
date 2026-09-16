/*
   Issue Description: CDM-23461
   Category/ Module  : Permanancy Plans
   Root cause: Migration data missing when the application was launched. Soft deleting the respective records from
   permanencyplan table

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update permanencyplan
set activeflag = 0, updatedby ='CDM-23461', updatedon =now()
where permanencyplanid in (
'79d56213-6f39-466b-97ef-3ba5d1aebca6',
'3af7c9eb-8453-4b11-9128-40644c2d0d40',
'4d45914e-5427-46fe-8c9d-f2a9d25db198',
'00ccd5d1-03c0-4ce1-8a01-8b1eb9ce3b92'
);
