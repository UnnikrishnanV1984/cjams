/*
Issue: Please do a data fix to expunge the case as requested
Category/Module: Support
Root cause: Case expungement as part of data cleanup
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CDM-41746
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expungement request
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2239182';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2239182'::character varying,
		null::date
	) ;