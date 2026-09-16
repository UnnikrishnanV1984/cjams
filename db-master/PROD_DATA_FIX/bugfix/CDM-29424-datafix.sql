/*
- Category/ Module: Case Management
-- Root cause: Data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update 	servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-29424', 
		updatedon = now() 
where 	servicecaseid = 'a4809887-6261-43b7-8085-fbd6895941e5' and activeflag = 1;


update 	cjams.routing 
set 	activeflag =0,  updatedby = 'CDM-29424', updatedon = now() 
where 	objectid='a4809887-6261-43b7-8085-fbd6895941e5'  and activeflag = 1;


update 	servicecasedisposition 
set 	activeflag = 0, updatedby = 'CDM-29424', updatedon = now() 
where 	servicecaseid = 'a4809887-6261-43b7-8085-fbd6895941e5' and activeflag = 1;

update 	servicecaserequest 
set 	activeflag = 0, updatedby = 'CDM-29424', updatedon = now() 
where 	servicecaseid = 'a4809887-6261-43b7-8085-fbd6895941e5' and activeflag = 1;