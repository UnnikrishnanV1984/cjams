/*
Issue Description:CJAMS-61786 CW2099496:Old 2005 case 2099496 had unsub appeal in 2006; should have been changed and expunged by now. Need case to either be expunged or appeals tab to be opened so appeals coordinator can change finding appropriately.
Category/Module: Expungement 
Root cause: User requested to expunge the case and modify findings from indicated to unsubtantiated as the part of data cleanup
Fix provided: Data fix has been done to expunge the case and modify the findings to unsubtantiated
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are expunging the cases with data fix as the part of data cleanup
*/

update
    tb_conv_inv_finding
set
    investigation_finding_cd = 'Unsubstantiated'
where
    referral_id = 'CW2099496';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
    (    'IR'::character varying,
        'CW2099496'::character varying,
        null::date
    ) ;

