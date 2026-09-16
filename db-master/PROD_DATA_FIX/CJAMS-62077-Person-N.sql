/*
Issue:Dashboard:The date of death is missing for this child (marc dorceus)- please enter date of death as 10/31/2024.
Root Cause:User requested update the date ,due to they do not have access do that.
Fix Provided (Data Fix Only):Data fix was done by Updated person table .
Data/Code fix ticket#: CJAMS-62077
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update person 
set dateofdeath='2024-10-31 00:00:00', updatedby='CJAMS-62077',updatedon =now()
where personid ='e4653aef-21b6-4bbf-b4db-b0fa95cb5f23' and activeflag=1;