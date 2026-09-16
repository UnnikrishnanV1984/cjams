/* 
   Issue Description: CJAMS-59974 3282274:I am attempting to delete a duplicate permanency plan but I am only given the option to exit the plan
   Category/ Module  : Permanency Plan
   Root cause:  As per system design new permanency plan can not be added while there is an open/active Permanency Plan. And connect with the user to get their supervisor approval to remove the duplicate Permanency Plan with the rejected status.
   Fix Provided : Data fix has been the duplicate rejected permanency plan
   Regression Impacts : N/A
   Is code fix needed : NO
   Reason why no related code fix: As per the system design we cannot update delete the existing permanency plan and data fix is needed.
*/

update permanencyplan_history
set activeflag = 0,
    updatedby = 'CJAMS-59974',
    updatedon = now()
where permanencyplanid = '8fb7edf9-a504-4132-8bb4-64f9eec87ab3' 
and permanencyplanhistoryid in ('704253d6-21d0-4d3d-bd74-066cceef605d','41e349ce-806f-41f6-83ff-12bdc56fef5b','a4b8a5cf-6849-4949-851e-b7d5eef1cfc8','b8f6271a-6b45-42ae-8f0c-4905194825d6') and activeflag = 1;    

update permanencyplan
set activeflag = 0,
    updatedby = 'CJAMS-59974',
    updatedon = now()
where  permanencyplanid = '8fb7edf9-a504-4132-8bb4-64f9eec87ab3' and activeflag = 1;

update routing
set activeflag = 0,
    updatedby = 'CJAMS-59974',
    updatedon = now()
where objectid = '8fb7edf9-a504-4132-8bb4-64f9eec87ab3' and activeflag = 1;
