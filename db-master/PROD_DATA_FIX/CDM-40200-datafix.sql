/*
  Issue Description:  CDM-40200
   Category/ Module  :  Decision
   Root cause: Data fix to modify the Investigation finding to "Ruled Out" and Expunge the Cases # CW2254670, CW2254668, CW2254667,and CW2254666.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

--CW2254666

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2254666';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254666'::character varying,
		null::date
	) ;

--CW2254667

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2254667';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254667'::character varying,
		null::date
	) ;
	
--CW2254668

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2254668';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254668'::character varying,
		null::date
	) ;

--CW2254670

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2254670';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2254670'::character varying,
		null::date
	) ;
