/*
Issue: CJAMS-59222 Findind needs to be modified
Category/Module: Findind needs to be modified
Root cause: This is an old case with SSA approval and data fix need to CW2211185:Please modify this indicated finding to ruled out and expunge from the system. 
			Please ensure that this investigation is also removed from R360. 
			The department does not have the closed record for this investigation. 
			Assistant Deputy Director, Stephanie Cooke has approved this request
Data/Code fix ticket#:  CJAMS-59222
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix after SSA approaval.
*/

--Updating tb_conv_inv_finding from indicated to ruled out

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2211185';

--Expunge case from system
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2211185'::character varying,
		null::date
	)