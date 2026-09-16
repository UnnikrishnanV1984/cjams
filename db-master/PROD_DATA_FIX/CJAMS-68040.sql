
/*
Issue Description: CJAMS-68040 Finding Modification Request
Category/Module: Expungement, Finding Modification 
Root cause:Need data fix to modify the findings from indicated neglect to Unsubstantiated neglect, and expunge the case # CW2220720.
Fix provided: Data fix has been promoted to modify the findings from indicated neglect to Unsubstantiated neglect, and expunge the case # CW2220720.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=196661 and referral_id='CW2220720'; 

SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2220720'::character varying,
		null::date
	) ;