/*
Root cause: Case expungement as part of data cleanup
Fix provided: DB query to expunge the case
Data/Code fix ticket#: CDM-43143
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. CJAMS is not expunging 
such CIS converted investigations with automated batch. So, we are expunging these CIS Investigations with SSA approvals.
*/

--Updating investigation findings
update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2264099';

--Expunging the case
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2264099'::character varying,
		null::date
	);