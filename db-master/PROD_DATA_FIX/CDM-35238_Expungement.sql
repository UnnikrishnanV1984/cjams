-- CDM-35328 - Expungement
/*
-- Issue Description: 
	User request To Expunge CPS Case CW2265696

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause:CW2265696:Please modify the Indicated Neglect finding to Unsubstantiated Neglect. The Department does not have the closed record for the investigation
-- Fix Provided: Datafix has been promoted to expunge the CPS-IR # CW2265696 and modify indicated Neglect finding to unsubstantantiated neglect
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

SELECT * FROM tb_conv_inv_finding where referral_id='CW2265696';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=241637 and referral_id='CW2265696'; 

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2265696'::character varying,
		null::date
	) ;

