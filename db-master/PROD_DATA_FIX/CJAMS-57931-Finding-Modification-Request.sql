/*
-- CJAMS-57931 - Finding Modification Request
-- Focus Area:Decision
-- Fix Provided: modify indicated neglect finding to unsubstantiated neglect.
 * 
 */

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out'
where inv_finding_id=211883 and referral_id in ('CW2235942' );


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2235942'::character varying,
		null::date
	);