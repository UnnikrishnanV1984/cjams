/*
Issue: CJAMS-69331 - Overdue Reason fix
User requested to update the overdue reason for the Alleged Victim as listed below
   on Intake# 261023749170

   Contact with Alleged Victim Completed : Alleged victim Unavailable /
   Insufficient information reported - attempts were made to obtain / 3-4 Attempts

Category/Module: Response Timer, Overdue Reason
Root cause: Data entry error - the alleged victim overdue reason was not captured.
Fix provided: Data fix has been done to update the LRR alleged victim overdue reason as requested.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cjams.cpsresponsetimeractions
set
    cpsresponsetimerreason1 = 'VAVU', -- Alleged victim Unavailable
    cpsresponsetimerreason2 = 'VIIR', -- Insufficient information reported - attempts were made to obtain
    cpsresponsetimerreason3 = 'V34R', -- 3-4 Attempts
    allegedvictimcontact = 'false',
    updatedby = 'CJAMS-69331',
    updatedon = now ()
where
    cpsresponsetimeractionsid = 'b85782d7-e93b-434d-914b-c1065f753c8d'
    and intakeserviceid = '7ff2d79c-d2a8-4fea-8453-1723cad43df3'
    and activeflag = 1;
