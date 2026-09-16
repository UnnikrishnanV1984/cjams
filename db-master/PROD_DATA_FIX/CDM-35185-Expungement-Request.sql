/*
 Issue Description: CDM-35185
 Category/ Module  : case>investigationfindings
 Root cause: Case needs to be expunged
 Fix: Expunge request for case CW2276920
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 */
select
    vl_sqlcode,
    vs_err_message
from
    cjams.expungcaserequest (
        'IR' :: character varying,
        'CW2276920' :: character varying,
        null :: date
    );

