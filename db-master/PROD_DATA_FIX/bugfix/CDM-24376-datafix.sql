/*
   Issue Description: CDM-24376
   Category/ Module  :  Service Log documents
   Root cause: Supervisor not able to see the worker uploaded attachment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select * from documentproperties 
where documentpropertiesid = '902a7e46-348b-4c20-8d35-718817f5fc68' and filename ='62e2deba917a706a2036ed59' and activeflag = 1;

update 	documentproperties 
set 	additionalobjectid = 1840104,
		updatedby = 'CDM-24376',
		updatedon = now()
where 	documentpropertiesid = '902a7e46-348b-4c20-8d35-718817f5fc68' and filename ='62e2deba917a706a2036ed59' and activeflag = 1;