/* 
    Issue Description: CJAMS-59208
   Category/ Module  : Finding Modification Request
   Root cause: :Please modify these indicated neglect findings to ruled out neglect. 
   Documentation supporting this request has been uploaded to the document tab and attached to this ticket.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2220608';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2220608'::character varying,
		null::date
	) ;