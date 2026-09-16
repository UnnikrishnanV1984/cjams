/*
Issue: CJAMS-64577 Response Timer
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023146734.
            AV:
            Alleged victim Unavailable
            Attempted Face to Face
            3-4 Attempts
            ICC:
            Initial Contact Caregiver Unavailable
            Attempted Face to Face
            3-4 Attempts
Fix provided:  Data fix has been done to update the LLR information for the case 251023146734
               
Data/Code fix ticket#: CJAMS-64577
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF', 
    cpsresponsetimerreason3 ='V34F',
    cpsresponsetimerreason7 ='CCCN',
    cpsresponsetimerreason8 ='CFFN',
    cpsresponsetimerreason9 = 'C34F',
    updatedby = 'CJAMS-64577',
    updatedon = now()
where cpsresponsetimeractionsid in ('ee2092ee-f9b9-4d55-94c8-97993f11778b')
and intakeserviceid = '2e5b53af-2ae7-4bae-b9fd-308e3011aaa6'
and activeflag =1;