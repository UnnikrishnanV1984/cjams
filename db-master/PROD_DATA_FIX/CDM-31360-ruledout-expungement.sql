/*
   Issue Description: CDM-31360
   Category/ Module  : INVESTIGATION FINDING
   Root cause: user wants to update investigation finding and expunge
   Pull request# for code fix:
   Reason why no related code fix: user error
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id = 'CW2224212';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2224212'::character varying,
        null::date
    ) ;