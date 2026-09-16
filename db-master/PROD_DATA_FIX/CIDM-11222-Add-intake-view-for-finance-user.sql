
/*
Issue: CIDM-11222 Issue viewing Cases
Category/Module: Finance Worker and Supervisor
Root cause: Finance Worker and supervisor are not having permission to view the intake page after opening it from the global search
Fix provided: Data fix has been done to add the required permission groups to the role resource tables for Finance worker and Supervisor.  
Data/Code fix ticket#: CIDM-11222
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix has been done add necessary permission in role resorce table. 
*/

--Added intake_read_only_access for Finance Worker (FNSFW)
INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 1052, 'e66a00fe-0d20-448b-96eb-d7157ff08c39', 1, 'CIDM-11222', now(), 'CIDM-11222', now(), true, true, true, 1, NULL);

--Added intake_read_only_access LDSS Fiscal Supervisor (FNSFS)
INSERT INTO cjams.role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES(gen_random_uuid(), 1053, 'e66a00fe-0d20-448b-96eb-d7157ff08c39', 1, 'CIDM-11222', now(), 'CIDM-11222', now(), true, true, true, 1, NULL);
