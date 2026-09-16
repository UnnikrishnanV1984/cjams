 		 	/*
   Issue Description: CDM-36164
   Category/ Module  : Document 
   Root cause: user requested to remove the requested document 
 Fix Provided: did data fix to updated the requested document     
*/

         
         
         update documentproperties set activeflag =0, updatedby ='CDM-36164', updatedon = now()
 		where documentpropertiesid ='9cb374ad-cd86-4512-8e70-c99a397149d2';
 	
 	 			
 		update documentattachment set activeflag =0, updatedby ='CDM-36164', updatedon = now()
 		where documentpropertiesid ='9cb374ad-cd86-4512-8e70-c99a397149d2';
 			