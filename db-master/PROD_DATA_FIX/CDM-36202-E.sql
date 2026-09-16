/*
 * CDM-36202 - Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Description - CW2293999:Please modify this indicated Physical Abuse finding to Ruled Out Physical Abuse and expunge. 
 * The department does not have the closed record for this investigation.
 * Expunge this CPS IR #CW2293999 
 * 
 */

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2293999') ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2293999'::character varying,
		null::date
	) ;