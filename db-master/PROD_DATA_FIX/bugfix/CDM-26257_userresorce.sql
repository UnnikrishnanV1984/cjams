-- CDM-26257 - approval error
/*
-- Issue Description: 
   New CJAMS role not showing in profile when logging into CJAMS: Netricia Barnett

-- Category/ Module: User Management
-- Root cause: NA
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

-- select * from userresource where userid='7368' and activeflag=1 and permissiongroupid in ('5c760141-a1ff-4ae2-bbc8-5692391e3dc1');

INSERT INTO cjams.userresource
(userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(7368, '5c760141-a1ff-4ae2-bbc8-5692391e3dc1', 5984, NULL, 1, 'CDM-26257', now(), 'CDM-26257', now(), NULL, NULL, NULL, NULL);