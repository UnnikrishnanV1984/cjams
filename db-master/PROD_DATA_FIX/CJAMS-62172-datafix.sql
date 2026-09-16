/*
Issue Description:CJAMS-62172 251023118637:The LRR drop down menu for Alleged Victim should be: "Alleged victim unavailable > Attempted face to face > 3-4 attempts"
Category/Module: Overdue Reason
Root cause: Data entry error and we are not able to see the Alleged Victim reasons for overdue
            We need a data fix to update the following information
            Alleged victim unavailable > Attempted face to face > 3-4 attempts
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face >  3-4 attempts
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedon = now(),
    updatedby = 'CJAMS-62172'
where cpsresponsetimeractionsid = '96f5ca30-bba8-405a-bd1f-e16b415fb0cb'
and intakeserviceid = '9836dc50-74bf-41eb-8f1d-60ccb9e38983'
and activeflag = 1;
