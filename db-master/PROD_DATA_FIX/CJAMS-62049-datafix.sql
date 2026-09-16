/*
Issue Description:CJAMS-62049 251023099796:The LRR drop down menu for Alleged Victim should be: "Alleged victim unavailable > Attempted face to face > 1-2 attempts"
Category/Module: Overdue Reason
Root cause: Data entry error and we are not able to see the Alleged Victim reasons for overdue
            We need a data fix to update the following information
            Alleged victim unavailable > Attempted face to face > 3-4 attempts
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face > 3-4 attempts
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
    updatedby = 'CJAMS-62049'
where  intakeserviceid = '56446d59-809f-4784-a68c-005567dcef04'
and activeflag = 1;