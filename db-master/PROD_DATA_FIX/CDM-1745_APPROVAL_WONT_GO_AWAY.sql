/*  Issue Description: CDM-17465
   Category/ Module  :  APPROVAL SCREEN
   Root cause: user asked to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing  set activeflag = 0 , updatedby ='CDM-17465',updatedon = now() 
	where routingid = 'b10b45ef-4522-41fe-9ef9-3e7e00458bde';