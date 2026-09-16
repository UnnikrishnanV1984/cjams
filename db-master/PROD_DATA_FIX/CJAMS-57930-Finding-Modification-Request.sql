/*
-- CJAMS-57930 - Finding Modification Request
-- Focus Area:Decision
-- Fix Provided: modify indicated neglect finding to unsubstantiated neglect.
 * 
 */

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out'
where inv_finding_id=268612 and referral_id in ('CW2292671' );

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out'
where inv_finding_id=268613 and referral_id in ('CW2292672' );

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292671'::character varying,
		null::date
	);


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2292672'::character varying,
		null::date
	);