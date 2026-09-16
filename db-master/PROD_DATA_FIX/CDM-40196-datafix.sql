/*
  Issue Description:  CDM-40196
   Category/ Module  :  Decision
   Root cause: Data fix to Rule out and Expunge the Cases
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2234390';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2234390'::character varying,
		null::date
	) ;
	

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2234391';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2234391'::character varying,
		null::date
	) ;


update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2234393';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2234393'::character varying,
		null::date
	) ;	
