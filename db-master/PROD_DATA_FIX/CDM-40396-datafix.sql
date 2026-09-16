/*
  Issue Description:  CDM-40396
   Category/ Module  :  Decision
   Root cause: Data fix to modify the Investigation finding to "Ruled Out" and Expunge the Cases CW2228089
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2228089';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2228089'::character varying,
		null::date
	) ;
