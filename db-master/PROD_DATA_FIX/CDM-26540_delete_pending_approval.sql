/*
   Issue Description : CDM-26540
   Category/ Module : Approval inbox  
   Root cause: user wants to remove the approved record from pending approval
*/

update routing 
set activeflag = 0
	, updatedby = 'CDM-26540'
	, updatedon =now() 
where routingid = 'ee3b4ff1-2641-4dd5-a516-b86451d3632b'; 