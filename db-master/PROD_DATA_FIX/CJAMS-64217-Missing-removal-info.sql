/*
Issue: CJAMS-64217 missing info in remova
Category/Module: Child Removal
Root cause: User didn't enter parent information in the child removal form which in not allowing to complete the removal.
            Data fix needs to be done to update the removal info 
            Milan Soso Client ID - 1504270
            Case number - 3285605
            Have both parent signed the agreement - Yes
            1st parent -JULIE SOSO (4086582)
            2nd parent -DANIEL SOSO (4283431)
Fix provided:  Data fix has been done to enter the missing child information regarding parent information and have parent agreement signed.
Data/Code fix ticket#: CJAMS-64217
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:Data entry error 
*/

update intakeservreqchildremoval
set parent1id = 4086582,
    parent2id = 4283431,
    isbothparentssigned = 1,
    updatedon = now(),
    updatedby = 'CJAMS-64217'
where intakeservreqchildremovalid = '3a7c90be-ace7-41b1-a291-076a3db16960'
and activeflag =1;  

