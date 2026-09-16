/*
Issue Description:CJAMS-59550 Overdue Reason Timer
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for alleged victim as Dara entry error but face to face mandate met.
Fix provided: Data fix has been done to update the overdue reason as follows Alleged victim Data entry error but face to face met.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VDER',
    cpsresponsetimerreason2 = NULL,
    updatedon = now(),
    updatedby = 'CJAMS-59550'
where cpsresponsetimeractionsid = '626e76d8-806f-4a15-a6ea-29509abd691e'
and intakeserviceid = 'd187a059-cbe0-4375-bd5b-28c26f4f07e6';