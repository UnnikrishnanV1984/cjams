/*
Issue Description:CJAMS-62190 251023118637: I241013157266:ADD Youth Death Date of 10/11/2024
Category/Module: Overdue Reason
Root cause: User requested  to update the Death Date of 10/11/2024 for client Elias Palmer. SSA has been approved
Fix provided: Data fix has been promoted to update the Death Date of 10/11/2024 for client Elias Palmer. 
SSA has been approved
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update person 
 set dateofdeath = '2024-10-11 00:00:00',
     updatedby='CJAMS-62190',
     updatedon =now()
where personid = 'fd5d9cce-9d87-4461-b272-5f2e442308f5'
 and activeflag = 1;
