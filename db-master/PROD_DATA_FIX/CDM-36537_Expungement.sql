/*
 * CDM-36537 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Description - CW2242120:Please expunge this investigation. The Department does not have the closed record for this investigation. 
 * Assistant Deputy Director, Stephanie Cooke has approved this expungement request.
 * 
 */

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2242120') ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2242120'::character varying,
		null::date
	);