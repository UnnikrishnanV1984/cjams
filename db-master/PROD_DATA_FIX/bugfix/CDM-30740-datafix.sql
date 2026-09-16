/*
   Issue Description: CDM-30740
   Category/ Module  :permanency plan 
   Root cause:  User request to delete Rejected Plan
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the permanencyplan table for the rejected plan
*/

select 	establisheddate, enddate,activeflag, * from permanencyplan
where 	servicecaseid = '4c17f8e5-56da-4e42-bfbd-dc25300013f4' and permanencyplanid = 'e9aa4a13-cb51-4d31-874b-0d325e87a0fa' and activeflag = 1;

update 	permanencyplan
set 	activeflag = 0,
		updatedby = 'CDM-30740',
		updatedon = now()
where 	servicecaseid = '4c17f8e5-56da-4e42-bfbd-dc25300013f4' and permanencyplanid = 'e9aa4a13-cb51-4d31-874b-0d325e87a0fa' and activeflag = 1;