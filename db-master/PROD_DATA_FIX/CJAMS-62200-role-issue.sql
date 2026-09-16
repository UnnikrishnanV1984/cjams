/*
Issue Description: CJAMS-62200 Cases assigned not showing on my dashboard
Category/Module: User roles
Root cause: elisha.smithwickbey@maryland.gov is having case management specialist role (CJAMS_CW_CASE_MGMT_SPECIALIST) as primary role in sailpoint.
            Due to this when user is logging into the screen the Case worker role is not selected by default and showing blank screen.
            Data fix needed add case worker role as primary and keep the case management role as secondary in user resource
Fix provided: Data fix needed add case worker role as primary and keep the case management role as secondary in user resource for the user elisha.smithwickbey@maryland.gov 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Sailpoint role integration issue and data fix is needed to resolve it.
*/


update teammember
set roletypekey = 'CWCW',
    updatedby = 'CJAMS-62200',
    updatedon = now()
where teammemberid = '01482fb3-93e2-4d58-8a17-be60d641b46d'
and activeflag =1;

update rolemapping
set roleid = 71,
    updatedon = now(),
    updatedby = 'CJAMS-62200'
where principalid = '71436';

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 71436, '0388441d-afe8-4aff-9553-a192e6fca30f', 135, NULL, 1, 'CJAMS-62200', now(), 'CJAMS-62200', now(), true, true, true, NULL);
