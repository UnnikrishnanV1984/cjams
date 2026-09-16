
/*
   Issue Description: CDM-21436
   Category/ Module  : Updating the parentname
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- null
update permanencyplan p set parentname = '00000000-0000-0000-0000-000000000000' , updatedby = 'CDM-21436', updatedon = now() 
where permanencyplanid = '4b36e828-9901-4f0f-9f0b-4a51c83e45d1';