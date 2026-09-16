/*
 Issue Description: CDM-43159
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to update investigation finding to Ruled Out and expunge the Case 
-- Fix Provided: Datafix has been promoted to update the investigation finding and sql query provided to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- SELECT * FROM tb_conv_inv_finding where referral_id='CW2214428';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=190369 and referral_id='CW2214428'; 

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2214428'::character varying,
		null::date
	) ;