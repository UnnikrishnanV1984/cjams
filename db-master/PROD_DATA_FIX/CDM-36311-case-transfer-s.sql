/*
   Issue Description: CDM-36311
   Category/ Module  :user roles
   Root cause: The user (megan.turner@maryland.gov) is having a supervisor role as requested it should be only caseworker.
   Fix provided: Datafix has been given to update user to case worker.
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '2913', 71, 1, 'CDM-36311', 'CDM-36311', now(), now(), '', 'CW');
-- Backup
select * from cjams.rolemapping where principalid ='2913' and roleid =36 and activeflag = 1 and teamtypekey ='CW';
-- Update
update rolemapping set activeflag =0,updatedby='CDM-36311',updatedon =now() where principalid ='2913' and roleid =36 and activeflag = 1 and teamtypekey ='CW';

-- Backup
select * from cjams.teammember where teammemberid ='47c803ce-4f29-411c-a8bb-6b72954a8b39';
-- Update
update teammember set roletypekey = 'CWCW',updatedby='CDM-36311',updatedon =now() where teammemberid ='47c803ce-4f29-411c-a8bb-6b72954a8b39';

-- Backup
select * from cjams.userresource where userid ='2913' and roleid = 36 and activeflag  = 1;
--5bee53fc-6b6e-4e66-9ee2-85a9127eed03 - del
--4d41025f-2f41-4981-8055-7bb5d2d4e13b - 
--49aabcf2-fd90-4421-824b-8daa3533169b - del
--Update
update userresource set activeflag =0,updatedby='CDM-36311',updatedon =now() where userresourceid in ('49aabcf2-fd90-4421-824b-8daa3533169b','5bee53fc-6b6e-4e66-9ee2-85a9127eed03') and userid ='2913' and roleid = 36 and activeflag = 1;