/*
-- Issue Description: 
	User request To Expunge CPS Case CW2294372 and Modify finding

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause:C to review and approval to modify the findings from indicated neglect to Unsubstantiated neglect, and expunge the case # CW2007836.. The Department does not have the closed record for the investigation.
-- Fix Provided: Datafix has been promoted to expunge and modify physical abuse finding from Indicated to Unsubstantiated for the CPS-IR # CW2294372
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=17637 and referral_id='CW2007836'; 

SELECT vl_sqlcode, vs_err_message
FROM cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2007836'::character varying,
		null::date
	) ;
