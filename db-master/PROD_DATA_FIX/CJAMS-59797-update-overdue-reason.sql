/*
Issue Description:CJAMS-59797 251023018545:Please add the number of attempts to the Alleged Victim section of the LRR reporting window. "5 or more attempts" 
Category/Module: Overdue Reason
Root cause: Third dropdown reason is missing under the Alleged Victim completed. This should not be the scenario as we it is a mandatory field and it is needed for submission of LLR window records.
            We are not able to reproduce the issue in stage-3 and analysing on how the empty data got inserted.
            Need data fix to add the third reason with "5 or more attempts" under the Contact with Alleged Victim Completed as highlighted below.
Fix provided: Data fix has been done to update the overdue reason as follows 
                Alleged victim unavailable > Attempted face to face > 5 or more attempts
Regression Impacts: N/A
Is Code fix Required?: TBD.We are closely monitoring this issue and will keep a track of it.
Code fix ticket#: TBD 
Reason why no related code fix: N/A  
*/

update cpsresponsetimeractions
set cpsresponsetimerreason3 = 'V5MF',
    updatedon = now(),
    updatedby = 'CJAMS-59797'
where cpsresponsetimeractionsid = '51c2d21b-5764-4918-9bd1-b9e6da1c4c32'
and intakeserviceid = 'a94ac7da-47a6-4cd8-a628-684c2a8d81a5';