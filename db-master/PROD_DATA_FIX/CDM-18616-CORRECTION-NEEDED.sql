/*
   Issue Description: CDM-18616
   Category/ Module  : permanency plan
   Root cause: user asked to update the intital date permanency plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

update permanencyplan 
	set projecteddate = '2021-01-05 05:00:00', establisheddate = '2021-01-05 05:00:00', updatedby = 'CDM-18616', updatedon = now()
	where permanencyplanid in ('0d38d010-b721-4c7f-9f76-e3bf5411a124', 'c31d2c3a-3aac-4a1e-ab66-89030f298f5c', '5b690db4-db9e-40e5-b816-46e117992b41');
