/*
   Issue Description: CDM-28643
   Category/ Module  :  Child Removal
   Root cause: user wants to add child removal end date
   Pull request# for data fix: 7966
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/
update intakeservreqchildremoval 
set exitdate = '2023-01-20 00:00:00', 
    updatedby = 'CDM-28678', 
    updatedon = now() 
where intakeservreqchildremovalid in ('0e0d7609-65be-4d86-9f2b-74352a580db8','c1eacfd5-1e79-45bb-8960-369d75e3cbfd','096a4a2a-2fe5-4f17-81a4-79ef9b9d9847');
