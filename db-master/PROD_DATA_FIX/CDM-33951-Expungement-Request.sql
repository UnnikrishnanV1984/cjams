/* 
-- CDM-33951 - Expungement Request
-- Issue Description: CW2278618: Please expunge this investigation. 
                                 The Department does not have the closed record for this investigation. 
-- Case ID: CW2278618
-- Category/ Module: Investigation Findings
-- Root cause: CW2278618:Please expunge this investigation. The Department does not have the closed record for this investigation. Assistant Deputy Director, Stephanie Cooke has approved this expungement request
-- Fix Provided: Datafix has been updated to Unsubstantiated from Indicated Service case # CW2278618
-- Pull request# N/A
*/


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2278618'::character varying,
		null::date
 	) ;