
/*
   Issue Description: CDM-16936
   Category/ Module  : delet service case
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/


update servicecase set activeflag = 0, updatedon = now(), updatedby = 'CDM-16936' 
	where servicecaseid = 'b7735548-a63c-4706-9964-0a16b67078af';