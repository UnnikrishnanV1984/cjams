/*
  Issue Description:  CDM-41423
   Category/ Module  :  Case Timeline
   Root cause: User request to Data fix remove the intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2899479'::character varying,
        null::date
    );