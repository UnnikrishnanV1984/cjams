/*
   Issue Description: CDM-40203
   Category/ Module  : INVESTIGATION FINDING
   Root cause: The records for Case #s CW2280833,CW2280832, and CW2280831 were requested pursuant to a background clearance application for CIS ID# 030817149 , but could not be located. 
         Please modify the findings to Ruled Out and immediately expunge. Please make sure the investigations are also removed from R360. 
   Pull request# for code fix:
   Reason why no related code fix: user error
*/

update tb_conv_inv_finding 
set investigation_finding_cd = 'Ruled Out' 
where referral_id = 'CW2280833' and inv_finding_id ='256774';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2280833'::character varying,
        null::date
    ) ;

update tb_conv_inv_finding 
set investigation_finding_cd = 'Ruled Out' 
where referral_id = 'CW2280832' and inv_finding_id ='256773';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2280832'::character varying,
        null::date
    ) ;

update tb_conv_inv_finding 
set investigation_finding_cd = 'Ruled Out' 
where referral_id = 'CW2280831' and inv_finding_id ='256772';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2280831'::character varying,
        null::date
    ) ;
