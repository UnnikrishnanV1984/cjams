-- CDM-33942 - Expungement Request
/* Issue Description:CW2293768:Please expunge this investigation. The Department does not have the closed record for this investigation. 
-- Case ID: CW2293768
-- Category/ Module: Investigation Findings
-- Root cause: User asked to expunge this investigation - CW2293768
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2293768
-- Pull request# N/A
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2293768'::character varying,
		null::date
 	) ;