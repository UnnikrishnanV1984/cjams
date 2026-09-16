-- CDM-35483 - Finding ModificationRequest
/* Issue Description:CW2217952:Please modify this indicated neglect finding to Unsubstantiated neglect. 

-- Case ID: CW2217952 - 61000809-9f4a-4418-8719-7e4eb17edcbc/CW2217952

-- Category/ Module: Investigation Findings

-- Root cause: It was given as Indicated and was told to update to Unsubstantiated
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2217952
-- Pull request# N/A
*/


update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2217952';


-- select vl_sqlcode, vs_err_message
-- from cjams.expungcaserequest
-- 	(	'IR'::character varying,
-- 		'CW2217952'::character varying,
-- 		null::date
-- 	) ;