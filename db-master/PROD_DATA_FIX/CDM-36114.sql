 	/*
   Issue Description: CDM-36114
   Category/ Module  : Investigation findings
   Root cause: user requested to indicated to Unsubstantiated 
 Fix Provided: did data fix to updated the value to Unsubstantiated   
*/

     
     
      update cjams.investigationfinding
 	set investigationfindingtypekey ='UD', updatedby ='CDM-36114', updatedon = now()
 	where investigationfindingid ='f3b3454f-9bd1-493f-b5da-a1a9e464c066';