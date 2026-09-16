/*
Issue Description:CJAMS-61831 CW2211281:Please expunge this investigation. The department does not have the closed record for the investigation. The individual requested a CPS clearance on themself.
Category/Module: Expungement 
Root cause: SSA approval given for Expunging the CPS IR # CW2211281 as a part of data clean up
Fix provided: Data fix has been done to expunge the case as the part of data clean up
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are expunging the case with data fix as the part of data cleanup
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2211281'::character varying,
        null::date
    ) ;