/*
   Issue Description: CDM-30887
   Category/ Module  : routing
   Root cause: Approved case need to remove.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-30887',
	updatedon = now()
where
	routingid = 'cccb94d0-dbd8-4625-82b1-fac0d9bd06b7';
	