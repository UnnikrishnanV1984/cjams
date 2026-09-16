/*
Issue: CJAMS-66796
Category/Module: CPS IR case
Root cause: User requested to set the case start date as per the addendum narative date and time
Fix provided: Data fix has been done by updating the start date of CPS IR case #261023722246.
Data/Code fix ticket#: CJAMS-66796
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
*/

update intakeservicerequest 
set reporteddate ='2026-03-31 15:04:25.020', updatedby ='CJAMS-66796', updatedon =now()
where servicerequestnumber ='261023722246' and activeflag =1;