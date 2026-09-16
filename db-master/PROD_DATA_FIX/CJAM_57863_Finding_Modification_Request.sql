/*
-- Issue Description: 
	User request To Expunge CPS Case CW2241798 and Modify finding

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause:CW2241798:Please modify this Indicated Physical Abuse finding to Unsubstantiated Physical Abuse and expunge it.
-- Fix Provided: Datafix has been promoted to expunge and modify physical abuse finding from Indicated to Unsubstantiated for the CPS-IR # CW2241798
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
/*
SELECT * FROM tb_conv_inv_finding where referral_id='CW2241798';
*/
UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=217739 and referral_id='CW2241798'; 

SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241798'::character varying,
		null::date
	) ;