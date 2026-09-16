/*
   Issue Description: CDM-37681
   Category/ Module  : Old case removal
   Root cause:  case expungement
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2185523'::character varying,
        null::date
    ) ;