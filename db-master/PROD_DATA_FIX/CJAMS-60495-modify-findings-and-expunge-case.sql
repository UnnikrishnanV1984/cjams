/*
Issue: CJAMS-60495 Findind needs to be modified
Category/Module: Findind needs to be modified
Root cause: This is an old case with SSA approval and data fix need to CW2251383:Please modify the finding to ruled out and expunge from the system
Fix provided:  Data fix has been done to modify the finding to ruled out and expunge from the system
Data/Code fix ticket#:  CJAMS-60495
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix after SSA approaval.
*/

--Updating tb_conv_inv_finding from indicated to ruled out

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2251383';

--Expunge case from system
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2251383'::character varying,
		null::date
	)