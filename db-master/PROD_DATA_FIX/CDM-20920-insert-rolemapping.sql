/*
  Issue Description: CDM-20920 CJAMS CW-Provider Read-Only Access Blank -IMPORTANT
   Category/ Module  :  user management
   Root cause: User is not having the CJAMS_CENTRAL_POLICY_STAFF_PROV (153)role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
-- email:'brenda.kirk@maryland.gov', 'lawrence.givens@maryland.gov', 'kimberley.sanders@maryland.gov','virginia.anderson@maryland.gov' 
--id :3931,12014,12200,12013

INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '12013', 153, 1, 'CDM-20920', 'CDM-20920', now(), now(), NULL, 'LDSS');
INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '12014', 153, 1, 'CDM-20920', 'CDM-20920', now(),now(), NULL, 'LDSS');
INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '12200', 153, 1, 'CDM-20920', 'CDM-20920', now(),now(), NULL, 'LDSS');
INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '3931', 153, 1, 'CDM-20920', 'CDM-20920', now(),now(), NULL, 'LDSS');
