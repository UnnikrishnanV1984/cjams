/*
Issue: Please do a data fix to expunge the case as requested
Category/Module: Support
Root cause: :CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch. So, we are expunging these CIS Investigations with SSA approvals.
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CJAMS-59268
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Reason why no related code fix: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch.
So, we are expunging these CIS Investigations with SSA approvals.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2528366'::character varying,
		null::date
	) ;