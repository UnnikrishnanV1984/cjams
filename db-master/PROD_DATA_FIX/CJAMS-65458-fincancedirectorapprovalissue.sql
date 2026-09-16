/*
Issue: CJAMS-65458 We need to be sure that I have the permissions needed to "approve" financial
Category/Module: Purchase Authorization - Director Pending Approval
Root cause: melinda.baldwin@maryland.gov Needs to approve the pending director approval records that are in the deborah.walsh@maryland.gov Dashboard but she is unable to approve due to the incorrect roles mapping.
            It is a know sailpoint integration issue and data fix is needed to resolve it.
Fix provided:  Data fix has been done provide correct roles to melinda.baldwin@maryland.gov to approve the records pendning in the finance dashboard.
Data/Code fix ticket#: CJAMS-65458 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a known sailpoint integration issue.
*/


INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '78245', 36, 1, 'CJAMS-65458', 'CJAMS-65458', now(), now(), '', 'CW');

--Deactivating existing record with Finance director role in role
update rolemapping
set activeflag = 0 ,
    updatedby = 'CJAMS-65458',
    updatedon = now()
where principalid = '78245'
and   id = '182227776'
and  roleid = '5984'
and activeflag = 1;

--Adding Finance Director permission group

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 78245, '57a390b8-3387-428a-97a8-0b8559fd1f1e'::uuid, 5984, NULL, 1, 'CJAMS-65458', now(), 'CJAMS-65458', now(), true, true, true, NULL);


--Correcting roles in CWSP table
update teammember
set roletypekey = 'CWSP',
    updatedon = now(),
    updatedby = 'CJAMS-65458'
where teammemberid = 'fe22f0eb-1a9e-446c-a61f-e4f763711b54'
and activeflag =1;    


----Adding routing records
update routing
set eventcode = 'PCAUTHR',
    tosecurityusersid = null,
    updatedby = 'CJAMS-65458',
    updatedon = now()
where objectid in ('4223752', '4238750', '4223819', '4234261', '4180741')
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
    and routingstatustypeid = 42
    and activeflag = 1