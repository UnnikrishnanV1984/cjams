/*
  Issue Description:  CDM-43162
   Category/ Module  :  Case Timeline
   Root cause: User request to expunge the case and change the investigation findings to Rule out
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
/*
select * from tb_conv_inv_finding where referral_id ='CW2154868';
*/
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2154868';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2154868'::character varying,
		null::date
	) ;
    

