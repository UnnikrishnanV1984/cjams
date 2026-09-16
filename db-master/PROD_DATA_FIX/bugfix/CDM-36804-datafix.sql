/*
   Issue Description: CDM-36804
   Category/ Module  :Question about expungement
   Root cause: To expunge the case CW2002726 from back end - To be done by Dev team
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2002726'::character varying,
        null::date
    ) ;
