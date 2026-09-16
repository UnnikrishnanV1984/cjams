/*
 * CDM-33317 - CPS modification of finding
 * Customer Email ID:joann.gochnour@maryland.gov
 * Customer Name: Joann Gochnour
 * Focus Area:Decision
 * Sub Component:Application
 * Description -
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2157631';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2157631'::character varying,
		null::date
	);