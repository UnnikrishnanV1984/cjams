
/*
   Issue Description: CDM-34923
   Category/ Module  : Placement   
   Root cause: user request 
   Fix Provided: Did data fix to update  the correct date  
*/

update cjams.placementcpahomes

set entrydt ='2022-11-16 14:00:00.000', entrytm ='2022-11-16 14:00:00.000',

updateuserid ='CDM-34923',  updatets = now() 

where placementcpahomeid ='a38f14a5-56b3-4071-9bc9-9b860a237190';