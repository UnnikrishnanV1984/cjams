/*
 Issue Description: CDM-40593
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to update investigation finding to Ruled Out and Use requested to expunge the Case 
-- Fix Provided: Datafix has been promoted to update the investigation finding and sql query provided to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out'
where 
inv_finding_id=249938 and 
referral_id='CW2273997';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2273997'::character varying,
		null::date
	) ;