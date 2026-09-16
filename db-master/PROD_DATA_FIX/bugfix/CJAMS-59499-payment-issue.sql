/*
Issue Description:3166056: The payments for February and March are not showing in the system and the provider is going without payment
Category/Module: Maintenance and Subsidy payments
Root cause:Payments were not generated as the approval date was not updated while doing the data fix for CJAMS-59048 for change the GAP agreement end date.
Fix provided: Data fix has been done to update the approval date in gapratesrevision table which is needed to trigger the payments in finance batch.
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: This is a data fix error that occurred due to CJAMS-59048 where approval date updation was missed.
*/


update gapratesrevision
set approvalDate = now(),
    updatedby = 'CJAMS-59499',
    updatedon = now()
where gaprateid='4567e044-2c49-40b5-ac17-9c6b0e6254e4'
and activeflag = 1;    