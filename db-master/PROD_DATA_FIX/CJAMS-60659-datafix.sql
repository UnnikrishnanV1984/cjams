/*
Issue Description:CJAMS-60659  251023029616:Wrong choices were used in the late initial contact explanations.: "Alleged victim unavailable > Family was contacted but unable to meet within mandate."
Category/Module: Overdue Reason
Root cause: Data entry error and we are not able to see the Alleged Victim reasons for overdue
            We need a data fix to update the following information
                "Alleged victim unavailable > Family was contacted but unable to meet within mandate."
Fix provided: Data fix has been done to update the overdue reason as follows 
                "Alleged victim unavailable > Family was contacted but unable to meet within mandate."
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedon = now(),
    updatedby = 'CJAMS-60659'
where cpsresponsetimeractionsid = '915cb45a-a539-437e-a31d-9cf56c01e047'
and intakeserviceid = '0029d5dc-2ad7-436a-b2d2-b9bacb2e15cf'
and activeflag = 1;