/*
   Issue Description: CDM-25779   
   Root cause: Removed these items as they have been approved by another supervisor going directly into the case and approving these items
*/

update 	cjams.servicecasedisposition 
set		activeflag = 0,
		updatedby = 'CDM-25779',
		updatedon = now()
where 	servicecaseid in ('a85e51cb-63c9-4828-b302-dad76c210012','3e03991a-a693-4262-8e9d-02349d28e7cd');

update 	cjams.routing 
set		activeflag = 0,
		updatedby = 'CDM-25779',
		updatedon = now()
where 	objectid in ('624e284d-f642-453b-8e83-00c29e08d43f', '358d980c-5d5e-4ab9-b382-16d7c24db132');


