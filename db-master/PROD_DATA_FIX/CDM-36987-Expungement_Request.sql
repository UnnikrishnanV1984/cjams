-- CDM-36987 - Expungement Request
/* Issue Description: CW2255987: Please expunge this investigation. 
                                 The Department does not have the closed record for this investigation. 
-- Case ID: CW2255987
-- Category/ Module: Investigation Findings
-- Root cause: User asked to expunge this investigation - CW2255987
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2255987
-- Pull request# N/A
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2255987'::character varying,
		null::date
 	) ;