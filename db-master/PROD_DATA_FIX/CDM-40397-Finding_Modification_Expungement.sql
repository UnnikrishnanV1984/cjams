
/*
 Issue Description: CDM-40397
-- Category/ Module: Investigation Finding 
-- Root cause: User wants to update investigation finding to Ruled Out and User requested to expunge the case 
-- Fix Provided: Datafix has been promoted to update the investigation finding and sql query provided to expunge the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update cjams.tb_conv_inv_finding
	SET investigation_finding_cd='Ruled Out'
where 
	inv_finding_id=217164 and 
	referral_id='CW2241223';


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241223'::character varying,
		null::date
	) ;