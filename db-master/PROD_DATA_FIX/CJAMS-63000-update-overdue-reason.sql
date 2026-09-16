/*
Issue:CJAMS-63000 Overdue Reason Box Update
251023142463:Please change all Overdue Reason Box selections to "Data Entry Error but Face to Face Mandate Met"
Category/Module: Overdue Reason (LLR)
Root cause:LLR reason is approved and data fix needed to change the reason from  Data Entry Error to Data Entry Error but Face to Face Mandate Met
Fix provided: Data fix has been done to correct the response timer to Data Entry Error but Face to Face Mandate Met
Data/Code fix ticket#: CJAMS-63000
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error and data fix should resolve it.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VDER',
    cpsresponsetimerreason2 = NULL,
    cpsresponsetimerreason4 = 'ODER',
    cpsresponsetimerreason5 = NULL,
    cpsresponsetimerreason7 = 'CDER',
    cpsresponsetimerreason8 = NULL,
    updatedon = now(),
    updatedby = 'CJAMS-59487'
where cpsresponsetimeractionsid = 'fc72a155-62d5-4b18-992b-91cf06351d7c'
and intakeserviceid = 'c55d5361-25e8-418b-8ec3-2484e594a855';