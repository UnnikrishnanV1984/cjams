/*
  Issue Description: CDM-21166 CJAMS Upload Issue: Cynthia Proctor
   Category/ Module  :  user management
   Root cause: Incorrect team for the user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 'd86b1d6-d20b-47f4-87f8-c654433e0126
*/
-- email:'cynthia.proctor1@maryland.gov'
-- id : 14420
-- team deactivated : 6d86b1d6-d20b-47f4-87f8-c654433e0126 teamnumber : 1429_4
-- team added : 8029cd04-e257-4d67-9184-9581e129a505 teamnumber : 1443_24

update teammember set teamid ='8029cd04-e257-4d67-9184-9581e129a505',updatedby ='CDM-21166',updatedon =now() 
where teammemberid = '6e674438-8978-4e43-90c4-335b4f87ee7c' 
and activeflag =1 and teamid = '6d86b1d6-d20b-47f4-87f8-c654433e0126';