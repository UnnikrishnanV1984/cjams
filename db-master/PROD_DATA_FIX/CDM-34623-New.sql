/*
 * CDM-34623 - Family Support Worker Access
 * Customer Email ID:tara.newcomer2@maryland.gov
 * Customer Name:Tara Newcomer
 * Focus Area:Contacts: Notes
 * Description - Dashboard:The family advocate (caseworker specialist) no longer has the ability to access the rest of the unit's cases in order to put in a contact note. 
 * The supervisor has to assign admin rights to the unit's support worker. This takes unnecessary extra steps and time to complete those requests. 
 * This was not initially the case and something changed in CJAMS. Are we able to go back to allowing unit's to have access to complete a contact note 
 * without assigning a case to them? 
 * the user (markeisha.williams1@maryland.gov) is still not able to create a contact note from other cases that not assigned to her.
 * 
 */

--select * from "role" where id=135;
--select * from v_userprofile where userid=3359;
--select * from permissiongroup where permissiongroupid='c471f3f5-09b3-418e-8998-11166132f9b6';
--select * from permissiongroup where permissiongroupname ilike '%investigation_full_access%'; --c471f3f5-09b3-418e-8998-11166132f9b6

delete from cjams.userresource where insertedby = 'CDM-34623' and roleid=135 and userid=3359 and permissiongroupid='c471f3f5-09b3-418e-8998-11166132f9b6' and activeflag=1;
INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(gen_random_uuid(), 3359, 'c471f3f5-09b3-418e-8998-11166132f9b6', 135, NULL, 1, 'CDM-34623', now(), 'CDM-34623', now(), true, true, true, NULL);
select * from cjams.userresource where roleid=135 and userid=3359 and permissiongroupid='c471f3f5-09b3-418e-8998-11166132f9b6' and activeflag=1;
