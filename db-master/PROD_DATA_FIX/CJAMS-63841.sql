/*
Issue Description:CJAMS-63841 
User 'jenel.keller@maryland.gov' & 'megan.jordan@maryland.gov' has supervisor access even though they are not supervisors in sailpoint
Category/Module: user profile 
Root cause: CJAMS user profile has supervisor role for this user
Fix provided: Data fix has been done to set the role to case worker
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
*/

-- Remove Supervisor Role
update cjams.rolemapping
	set activeflag = 0,
		updatedby = 'CJAMS-63841',
		updatedon = now()
	where id IN (173345436, 182806336);
	

-- Add case worker role	
INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '2910', 71, 1, 'CJAMS-63841', 'CJAMS-63841', now(), now(), '', 'CW');

INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '2969', 71, 1, 'CJAMS-63841', 'CJAMS-63841', now(), now(), '', 'CW');
