--Role set up
--------------------------------------------------------------------------------------------------
-- 04/10/2025 prasanna sai kommineni - CIDM-9736 BEACON Interface
-- 06/05/2025 Elishama Kothapally - commenting Prod user in Training - Approved by Chandra Ramasamy

-----------------------------------------------------------------------------------------------------
delete from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1;
INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES((select  max(id)+1 from cjams.role), 'BEACON DOL Allow Access', 'BEACON DOL Allow Access, CW', NULL, NULL, 1, 'CIDM-9736', 'CIDM-9736', now(), now(), 'CWDOLAA', NULL, 'CJAMS_CW_DOL_ALLOW_ACCESS');

-- Permission group
delete from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS';

INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES( 'BEACON DOL ALLOW ACCESS', 'BEACON DOL ALLOW ACCESS', 1, 'CIDM-9736', 'CIDM-9736', now(), now(), NULL);

--Resource set up
delete  from cjams.resource r  where resourcename ='BEACON_DOL_ALLOW_ACCESS';

INSERT INTO cjams.resource
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'BEACON_DOL_ALLOW_ACCESS', 1, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), 'BEACON_DOL_ALLOW_ACCESS', NULL, NULL, 'BEACON_DOL_ALLOW_ACCESS', NULL, 'BEACON_DOL_ALLOW_ACCESS');

-- Permission group and resource set up
delete from cjams.pgresource p where permissiongroupid = ((select permissiongroupid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'));

INSERT INTO cjams.pgresource
( permissiongroupid, 
resourceid, 
activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES( (select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'), 
(select id from cjams.resource r  where resourcename ='BEACON_DOL_ALLOW_ACCESS'), 
1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, NULL, NULL, NULL);

--- Set up the beacon access for cortney.carey@maryland.gov
/*
delete  from cjams.userresource where userid=3293 and activeflag =1 and 
roleid =(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(3293,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);
*/
