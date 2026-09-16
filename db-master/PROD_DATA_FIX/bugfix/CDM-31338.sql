/*
   Issue Description: CDM-31338
   Category/ Module  : Change user's notification from name  
   Root cause: user requeseted to rename it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update usernotificationmap set fromsecurityusersid='74542e14-b26d-4824-ac24-dae0b75fc8e0',updatedby = 'CDM-31338',
	updatedon = now() where usernotificationid='68f64af6-3ac5-44de-a455-ca46e52602e9';