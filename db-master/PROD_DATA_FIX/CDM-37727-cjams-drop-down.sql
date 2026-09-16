-- CDM-37727
/*

-- Category/ Module: User Management
-- Root cause: Assignment worker is not showing up in the dropdown. As the user Hana Hawthorne was not having the role of QUALIFIED_INDIVIDUAL_Worker.
-- Fix: Data fix provided for the user by adding user resource with QUALIFIED_INDIVIDUAL_Worker role 
*/

select * from userresource where userid='39355' and activeflag=1 and permissiongroupid in ('4ba216d8-5eb2-4164-b01b-e19452425387');

INSERT INTO cjams.userresource
(userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('93c95339-b1cb-40a4-a004-79a58c180aaf'::uuid, 39355, '4ba216d8-5eb2-4164-b01b-e19452425387'::uuid, 5988, NULL, 1, 'CDM-37727', now(), 'CDM-37727', now(), true, true, true, NULL);
