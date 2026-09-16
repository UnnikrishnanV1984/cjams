/*
 * CDM-40199 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - :The record for Case # CW2281393 was requested pursuant to a background clearance application for CIS ID# 030721392 , but could not be located. Please modify the finding to Ruled Out and immediately expunge. 
 * Assistant Deputy Director, Stephanie Cooke has approved this request.
 * data fix for expunging the case
 * 
 */


update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2281393' and inv_finding_id=257334;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2281393'::character varying,
		null::date
 	) ;