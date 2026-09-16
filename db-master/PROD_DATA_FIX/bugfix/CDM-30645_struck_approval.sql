/*
   Issue Description: CDM-30645
   Category/ Module  : routing
   Root cause: Approved case for case id 3253189 remains pending tab, user wants it to be removed.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update
	routing
set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-30645'
where
	routingid = 'c6374557-448f-43a6-b8d0-d977749a0555';
	