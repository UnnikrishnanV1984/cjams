/*
  Issue Description:  CDM-40391
   Category/ Module  :  Application
   Root cause: User  requested to change the findings to Ruled out and expunge the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id in ('CW2221197','CW2221196');

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2221197'::character varying,
		null::date
	);
	
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2221196'::character varying,
		null::date
	);