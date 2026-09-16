 /*
   Issue Description: CIDM-10548 insert beacon role in teammemberroletype table
   Category/ Module  :  User management
   Root cause: Beacon additional permission is failing from sailpoint due to role seup. Role mapping is missing for team member.
   Fix provided : Added the missing role "beacon allow access"
   Code fix ticket#: CIDM-10548
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
----BEACON DOL Allow Access
delete from cjams.teammemberroletype where roletypekey ='CWDOLAA' and activeflag =1;

INSERT INTO cjams.teammemberroletype
( roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES('CWDOLAA', 1, 'BEACON DOL Allow Access', 'CW', false, 'CIDM-9736', now(), 'CIDM-9736', now(), now(), NULL, NULL, false, NULL, NULL);



--Adding the beacon permissin group for the iv-e users
delete  from cjams.userresource where userid in 
(4642,
3298,
3304,
3294,
7022,
14369,
14540,
15009)
and activeflag =1 and 
roleid =(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(4642,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(3298,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(3304,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(3294,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(7022,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(14369,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(14540,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);

INSERT INTO cjams.userresource
( userid, 
permissiongroupid, 
roleid,
resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(15009,
(select permissiongroupid::uuid  from cjams.permissiongroup p where permissiongroupname = 'BEACON DOL ALLOW ACCESS'),
(select id from cjams."role" where roletypekey ='CWDOLAA' and activeflag =1)
, NULL, 1, 'CIDM-9736', now(), 'CIDM-9736', now(), true, true, true, NULL);