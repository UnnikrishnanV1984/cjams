/*
   Issue Description: CDM-25997
   Category/ Module  : INVESTIGATION FINDING
   Root cause: user wants to update investigation finding 
   Pull request# for code fix:6709
   Reason why no related code fix: user error
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id = 'CW2013782';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2013782'::character varying,
        null::date
    ) ;