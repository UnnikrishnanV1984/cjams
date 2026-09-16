/*
  Issue Description:  CJAMS-57925
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to end date the Assignments
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/


 
 update caseassignment 
 set enddate = '2024-07-02',
 updatedby ='CJAMS-57925',
 updatedon =now()
 where caseassignmentid in ('a26a56cd-1df8-4029-a2d9-a1c8de693074','c642a224-96d5-4618-b1ec-78366504db46',
 '25c05e67-a192-4d85-bb38-85413c9a5584','c6bfa0f8-cc78-47f5-ba2c-2a85ae315b6e')and activeflag =1;