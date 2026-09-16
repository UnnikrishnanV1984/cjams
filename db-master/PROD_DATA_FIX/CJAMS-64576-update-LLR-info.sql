/*
Issue: CJAMS-64576 drop down choices need to be changed
Category/Module: Response Timer /LLR
Root cause: Case has been closed and user requested to update the LLR information for the case CPS AR# 251023121429.
            to change the All Response Timer dropdown  to worker assigned multiple cases all requiring 24 hour response / after hours worker unable to meet mandate for assigned worker. 
Fix provided:  Data fix has been done to update the LLR information for the case CPS AR# 251023121429
Data/Code fix ticket#: CJAMS-64576
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VWCR', 
    cpsresponsetimerreason2 = '["VAWR"]',
    cpsresponsetimerreason4 ='OWCR',
    cpsresponsetimerreason5 ='["OAWR"]',
    cpsresponsetimerreason7 ='CWCR',
    cpsresponsetimerreason8 = '["CAHR"]',
    updatedby = 'CJAMS-64576',
    updatedon = now()
where cpsresponsetimeractionsid in ('2099accc-58d8-4093-879b-9f50abac0867')
and intakeserviceid = 'a813e604-0049-435a-8bf2-372b2371e5a9'
and activeflag =1;