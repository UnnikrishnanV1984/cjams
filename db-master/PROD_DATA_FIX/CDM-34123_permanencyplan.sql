/*
   Issue Description: CDM-34123
   Category/ Module  :Adults are showing up in permanency plan 
   Root cause: migrated chessei data in draft status so deactivating 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

update permanencyplan 
set activeflag = 0, updatedby = 'CDM-34123', updatedon = now()
where permanencyplanid in ('2fad2138-13da-44e2-a818-7f3505474891','38f1aca4-a6ec-4765-a769-c5370cedf5b6',
'0480509b-63c9-4fca-a36a-81473b717e32');