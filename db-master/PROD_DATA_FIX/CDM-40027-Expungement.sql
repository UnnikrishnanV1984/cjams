/*
   Issue Description: CDM-40027
   Category/ Module  : INVESTIGATION FINDING
   Root cause: When asked to complete a CPS clearance, it was noted that this case is 28 years old,
    there have been no further reports and there appears to be no associated criminal case found in Maryland Judiciary case search. 
   Pull request# for code fix:
   Reason why no related code fix: user error
*/


update tb_conv_inv_finding 
set investigation_finding_cd = 'Ruled Out' 
where referral_id = 'CW2023984' and inv_finding_id ='32365';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2023984'::character varying,
        null::date
    ) ;

