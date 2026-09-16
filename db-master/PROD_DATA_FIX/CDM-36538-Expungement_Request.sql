/* 
-- CDM-36538 - Expungement Request
-- Issue Description: CW2290867: Please expunge this investigation. 
                                 The Department does not have the closed record for this investigation. 
-- Case ID: CW2290867
-- Category/ Module: Investigation Findings
-- Root cause: User asked to expunge this investigation - CW2290867
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2290867
-- Pull request# N/A
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2290867'::character varying,
		null::date
 	) ;