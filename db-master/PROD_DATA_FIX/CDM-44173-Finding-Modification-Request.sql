/*

Issue Description: CDM-44173
   Category/ Module  : Data fix for expunge request.
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2276469' and inv_finding_id=252410;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2276469'::character varying,
		null::date
 	) ;


update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2276470' and inv_finding_id=252411;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2276470'::character varying,
		null::date
 	) ;


update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2223486' and inv_finding_id=199427;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2223486'::character varying,
		null::date
 	) ;

     