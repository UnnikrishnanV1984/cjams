/*
Issue: CJAMS-63405 Incorrect Role
Category/Module: User Profile
Root cause:  jennifer.porter@montgomerycountymd.gov is caseworker in sailpoint but superviosr in CJAMSS.
Fix provided:  Data fix has been done to update the role to Case Worker
Data/Code fix ticket#: CJAMS-63405
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
*/

update cjams.rolemapping 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CJAMS-63405'
	where id = 167379629;


INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '4740', 71, 1, 'CJAMS-63405', 'CJAMS-63405', now(), now(), '', 'CW');

