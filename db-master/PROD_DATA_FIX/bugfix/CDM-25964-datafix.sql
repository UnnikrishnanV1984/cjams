/*
   Issue Description: CDM-25964
   Category/ Module  : case assignment
   Root cause: user wants to assign case to Kathleen Chaney 

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update 	routing
set 	tosecurityusersid = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f',
		updatedby = 'CDM-25964',
		updatedon = now()
where 	routingid = 'd10ce2c2-0a70-478d-a1fc-5dd89e9d3153' and activeflag = 1;