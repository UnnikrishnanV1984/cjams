/*
 * CJAMS-59011 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Root cause: Modified this indicated neglect finding to Unsubstantiated neglect
 * Description - CW2286782:Please modify this indicated finding to Unsubstantiated and expunge from the system.
 * The closed record has been reviewed and the department is modifying the finding to Unsubstantiated. 
 * Assistant Deputy Director, Stephanie Cooke has approved this modification request.
 */

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where inv_finding_id=262723 and  referral_id = 'CW2286782';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2286782'::character varying,
		null::date
	);