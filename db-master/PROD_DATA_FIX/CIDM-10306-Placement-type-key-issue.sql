/*
  Issue Description:CIDM-10306 Placement type key issue
  Category/ Module : User Management
  Root cause: Internal Team Request, Some ids are there in placement table stored placementtypekey as null. 
  Fix Provided: Bulk Datafix has been applied to update the placementtypekey as LA for those ids which placementtypekey is null
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A

*/
-- select  placementid,remarks ,* from placement p 
-- where placementtypekey is null and activeflag =1; --171222

update placement 
set updatedby = 'CIDM-10306',
	updatedon = now(),
	placementtypekey = 'LA'
where placementtypekey is null 
and activeflag =1
and coalesce(remarks, '') not ilike 'CIS Provider%'; --  LA 522

update placement 
set updatedby = 'CIDM-10306',
	updatedon = now(),
	placementtypekey = 'PRPL'
where placementtypekey is null 
and activeflag =1
and coalesce(remarks, '') ilike 'CIS Provider%'; -- PRPL 170700
