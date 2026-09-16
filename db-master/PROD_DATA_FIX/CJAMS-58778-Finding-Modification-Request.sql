/*
 * CJAMS-59240 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Root cause: Modified this indicated neglect finding to ruled out neglect
 * Description - CW2273690:Please modify this indicated finding to ruled out and expunge from the system.
 * The closed record has been reviewed and the department is modifying the finding to ruled out. 
 * Assistant Deputy Director, Stephanie Cooke has approved this modification request.
 */

 update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where inv_finding_id=249631 and  referral_id = 'CW2273690';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2273690'::character varying,
		null::date
	) ;