/*
Issue: Please do a data fix to expunge the case as requested
Category/Module: Support
Root cause: :CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch. So, we are expunging these CIS Investigations with SSA approvals.
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CJAMS-58928
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Reason why no related code fix: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging such CIS converted investigations with automated batch.
So, we are expunging these CIS Investigations with SSA approvals.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--update Unsubstantiated investigationfinding
 update
	investigationfinding
set
	updatedby = 'CJAMS-58928',
	updatedon = now(),
	investigationfindingtypekey = 'UD'
where
	investigationallegationid in ('24c4a5a9-eeca-4779-873a-4478728b7067')
	and activeflag = 1;
--expunging case
 select
	vl_sqlcode,
	vs_err_message
from
	cjams.expungcaserequest('IR'::character varying,
	'CW2880740'::character varying,
	null::date);