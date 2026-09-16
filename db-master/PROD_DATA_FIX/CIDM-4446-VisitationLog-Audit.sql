
/*
   Issue Description: CIDM-4446

   Audit log for Visitation plan, Visitation log and Visitation clients
   
*/
	


update visitationplan
set updatedby = 'CIDM-4446', updatedon = now() 
where updatedby is null and updatedon is null;


update visitationplanclients 
set updatedby = 'CIDM-4446', updatedon = now() 
where updatedby is null and updatedon is null;


update visitationlog
set updatedby = 'CIDM-4446', updatedon = now() 
where updatedby is null and updatedon is null;