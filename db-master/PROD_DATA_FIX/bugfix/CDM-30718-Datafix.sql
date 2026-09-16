/*
   Issue Description: CDM-30718
   Category/ Module  : Permanency plan
   Root cause: Accidental Deletion by the User
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


       update 	routing 
set 	fromsecurityusersid = 'e9ff2da6-3f06-4123-9788-acc6117867e0',
		updatedby = 'CDM-30718',
		updatedon = now()
where 	routingid = '5f92f775-b36c-4d9e-aff7-55b068f94301';