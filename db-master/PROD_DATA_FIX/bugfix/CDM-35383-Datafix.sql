/*
   Issue Description: CDM-35383
   Category/ Module  : Finding modification requests
   Root cause: Finding Modification Request
   Fix Provided: Updated the investigation_finding to Unsubstantiated
*/

select * from tb_conv_inv_finding where referral_id = 'CW2219153';

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2219153';


-- select vl_sqlcode, vs_err_message
-- from cjams.expungcaserequest
-- 	(	'IR'::character varying,
-- 		'CW2219153'::character varying,
-- 		null::date
-- 	) ;