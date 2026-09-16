/*
  Issue Description:  CDM-41262
   Category/ Module  :  CPA Home
   Root cause: User request to Data fix to expunge the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2215833' 
and inv_finding_id= 191774;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2215833'::character varying,
		null::date
	) ;
    
