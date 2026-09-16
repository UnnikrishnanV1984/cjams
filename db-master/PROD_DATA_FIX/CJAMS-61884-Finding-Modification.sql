/*
   Issue Description: CW2234140:Please modify this indicated finding to unsubstantiated and expunge from the system.
   Category/ Module  : Finding modification requests
   Root cause: Finding Modification Request
   Fix Provided: data fix to modify the findings from indicated physical abuse to unsubstantiated physical abuse, and expunge the case # CW2234140
*/

--select * from tb_conv_inv_finding where referral_id = 'CW2234140';

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2234140';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
(	'IR'::character varying,
    'CW2234140'::character varying,
    null::date
) ;