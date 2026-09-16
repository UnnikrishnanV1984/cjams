/*
   Issue Description: CDM-35188
   Category/ Module  : case>investigationfindings
   Root cause: expungerequest for cases CW2529006 and CW2742707
   Fix: Expunging the cases CW2529006 and CW2742707
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
        'CW2742707' :: character varying,
        null :: date
    );

select
    vl_sqlcode,
    vs_err_message
from
    cjams.expungcaserequest (
        'IR' :: character varying,
        'CW2529006' :: character varying,
        null :: date
    );