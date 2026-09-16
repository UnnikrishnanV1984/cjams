/*
   Issue Description: CDM-41260
   Category/ Module  : Investigation Findings
   Root cause: Need to Rule Out and expunge the case.

   Reason why no related code fix: Worker needs to update/add the requested data. 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2290776' and inv_finding_id=266717;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2290776'::character varying,
		null::date
 	) ;