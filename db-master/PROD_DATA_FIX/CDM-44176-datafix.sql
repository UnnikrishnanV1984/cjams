/*

Issue Description: CDM-44176
   Category/ Module  : Data fix for expunge request.
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--CW2212057

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2212057';

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2212057'::character varying,
		null::date
 	) ;

--CW2212058     

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2212058';

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2212058'::character varying,
		null::date
 	) ;