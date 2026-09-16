/*
Issue: CJAMS-64579 Drop down reason
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023182705.
            to change the All Response Timer dropdown to case not assigned timely > supervisor delays. 
Fix provided:  Data fix has been done to update the LLR information for the case 251023182705
Data/Code fix ticket#: CJAMS-64579
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCNT', 
    cpsresponsetimerreason2 = 'VSDT', 
    cpsresponsetimerreason4 ='OCNT',
    cpsresponsetimerreason5 ='OSDT',
    cpsresponsetimerreason7 ='CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedby = 'CJAMS-64579',
    updatedon = now()
where cpsresponsetimeractionsid in ('b94a8882-51d8-46c8-a11c-b21c7d1221a5')
and intakeserviceid = 'cdd6e535-857e-43db-aa87-f54786789837'
and activeflag =1;