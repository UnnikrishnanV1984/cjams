/*
Issue Description: 3222009:The worker put in the wrong date to establish the perm plan and the information will not populate into the case plan. There is no way to edit the date and I cannot delete what has been entered. I am trying not to exit it and create confusion by having multiple plans entered. 
                   Can the plan established date be changed to 8/3/25
Root cause: 3220099:Case worker entered the wrong date and Data fix is needed to change the permanency plan established date from 09/12/2025 to 08/03/2025.
Fix provided: Data fix has been done to update the dates for the permanency plan established date to 08/03/2025.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix needed to update the permanency plan details.
*/

update permanencyplan
set establisheddate = '2025-08-03 00:00:00.000',
    updatedby = 'CJAMS-62221',
    updatedon = now()
where permanencyplanid  = 'bb0db7ef-6017-4124-9e63-9f3e607b548a'
and activeflag = 1;