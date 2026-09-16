/*
   Issue Description: CDM-36419: Service Case
   Category / Module  : Assign Case / Assign Service Case
   Root Cause: User Requested the below service cases to be removed from the user dashboard.
   Fix Provided: Script provided to remove from the user dashboard
*/

update servicecase 
set 
	statustypekey = 'ASSGN',
	updatedby = 'CDM-36419',
    updatedon = now()
where servicecaseid = 'df427538-33b4-45a1-8bb1-579b8f8ca178';

update servicecase 
set 
	statustypekey = 'ASSGN',
	updatedby = 'CDM-36419',
    updatedon = now()
where servicecaseid = '27cfee4d-4f99-4f91-849d-814f03e8007d';
