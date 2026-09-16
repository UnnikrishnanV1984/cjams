/*
 * CDM-37448 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Description - CW2238361:Please expunge this investigation. The department does not have the closed record for this investigation. Assistant Deputy Director, Stephanie Cooke has approved this request.
 * 
 */

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2238361');

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2238361'::character varying,
		null::date
	);