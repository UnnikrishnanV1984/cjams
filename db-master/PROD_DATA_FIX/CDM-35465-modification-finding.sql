-- CDM-35465 - Finding ModificationRequest
/* Issue Description:CW2213320:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2213320 - 981809a1-5137-4ab7-8b4d-624c1c49606c/CW2213320

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2213320
-- Pull request# N/A
*/




update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2213320';


-- select vl_sqlcode, vs_err_message
-- from cjams.expungcaserequest
-- 	(	'IR'::character varying,
-- 		'CW2213320'::character varying,
-- 		null::date
-- 	) ;