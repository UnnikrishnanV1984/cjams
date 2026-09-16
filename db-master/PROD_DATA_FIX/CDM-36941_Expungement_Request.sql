/*
 * CDM-36941 - Expungement Request
 * Customer Email ID:jeanne.baxter@maryland.gov
 * Customer Name:Jean Baxter
 * Description - CW2141452:	Per Susan Tyzack, this report and CPS documentation from the 2003 investigation should be removed from CJAMS. 
 *							There were numerous attempts to locate the record, but no success. Without a record and information in CJAMS, this case cannot be held against this person. 
 *								CW2141452 Patricia Neidert is the casehead
 * 
 */

select referral_id, maltreatment_type_cd, investigation_finding_cd 
	from tb_conv_inv_finding 
where referral_id in ('CW2141452') ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2141452'::character varying,
		null::date
	);