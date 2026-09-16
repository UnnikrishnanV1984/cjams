/*
   Issue Description: CDM-15892
   Category/ Module  : CW CJAMS
   Root cause: Accidental Deletion by the User
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-15892' , updatedon = now()
where tosecurityusersid = 'db5ac50c-a8f4-472d-b6ee-aa47933cadda' 
and objectid = '658e15b9-ac00-4303-9e25-1ef72b16d94a'
and activeflag = 1
