
/* 
 Issue Description: CDM-25567
 Category/ Module  :These cases and service case need to be removed from tree.
 Assign Case ---> To be Assigned
 CASE NUMBER : 202001280118391
 CASE NUMBER : 20200127018356 (AR)
 Assign service case ---> To be Assigned
 SERVICE CASE :  3298057
 Customer Email ID: karaa.finamore@maryland.gov
 Root cause:  Data fix to remove cases and service case from the tr
 Is routed is false for  CASE NUMBER : 202001280118391, 20200127018356 (AR)
 Status type key should be ASSGN for SERVICE CASE :  3298057
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/



update intakeservicerequest
	set isrouted = true, updatedon = now(), updatedby = 'CDM-25567'
	where intakeserviceid in ('13d124ce-20c2-4e2a-84e2-e60f12df2e3c', '91697bb7-ec80-4fad-b8d9-7c2239797a27');

update servicecase set statustypekey  = 'ASSGN', updatedon = now(), updatedby = 'CDM-25567' 
where servicecaseid = 'aa475856-2c3f-4e13-ab87-f0c63c0f8293' and servicecasenumber ='3298057';