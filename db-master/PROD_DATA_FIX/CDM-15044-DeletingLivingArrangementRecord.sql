/*
   Issue Description: CDM-15044
   Category/ Module  :  Deleting Living Arrangement Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement set activeflag = 0, updatedby = 'CDM-15044', updatedon = now() where placementid = 'cef90123-3b9c-4b4b-a512-e5f114e88842';