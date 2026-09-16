/*
 * CDM-29399 - removal of case from cjams
 * Customer Email ID:jeanne.baxter@maryland.gov
 * Customer Name:Jeanne Baxter
 * Description - CW2169938:The hard copy record no longer exists and this particular case should be removed from cjams, as we have no details about this case. Thank you!
 * 
 */

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2169938') ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2169938'::character varying,
		null::date
	);