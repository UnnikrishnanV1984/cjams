-- CDM-34919 - Close Service case
/* Issue Description:User request to close service case #231030200110

-- sercice case ID: 3f37c2ea-2be9-4e6e-979a-9f4db4dc650e

-- Category/ Module: Service Case 

-- Root cause: User requested to close service case 
-- Fix Provided: Datafix has been provided to remove service case for #231030200110
-- Pull request# N/A

*/

select activeflag ,* from servicecase where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e';
update servicecase
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-34919'
where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e' and activeflag=1;

select activeflag,servicerequestsubtypeid,* from servicecaserequest where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e';
update servicecaserequest
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-34919'
where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e' and activeflag=1;

select activeflag ,* from servicerequestsubtype where servicerequestsubtypeid='c8b9a908-4152-4fe1-bc15-346d1176f9cc';
update servicerequestsubtype
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-34919'
where servicerequestsubtypeid='c8b9a908-4152-4fe1-bc15-346d1176f9cc' and activeflag=1;

select activeflag ,* from servicecasedisposition where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e';
update servicecasedisposition
set activeflag = 0,
	updatedon = now(), 	
	updatedby = 'CDM-34919'
where servicecaseid = '3f37c2ea-2be9-4e6e-979a-9f4db4dc650e' and activeflag=1;
