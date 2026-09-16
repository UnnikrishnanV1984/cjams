/*
Issue Description:CJAMS-59773 251023006680:The LRR drop down menu for Alleged Victim should be: "Alleged victim unavailable > Attempted face to face > 1-2 attempts"
Category/Module: Overdue Reason
Root cause: Data entry error and we are not able to see the Alleged Victim reasons for overdue
            We need a data fix to update the following information
            Alleged victim unavailable > Attempted face to face > 1-2 attempts
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face > 1-2 attempts
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedon = now(),
    updatedby = 'CJAMS-59773'
where cpsresponsetimeractionsid = '23a4be7b-b639-4948-bff8-931508bee8cd'
and intakeserviceid = 'd772d10c-5c9f-40c9-ad95-42f6499936f0'
and activeflag = 1;