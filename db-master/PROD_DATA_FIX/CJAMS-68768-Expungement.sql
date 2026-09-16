/*
-- Issue Description: 
	User request is for expunge the 1 CPS-IRs: CW2153234
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IR CW2828633 case.
-- Pull request# N/A 
-- Reason why no related code fix:CIS Converted Investigation with No information about maltreator or the maltreatment/allegation. 
                 CJAMS is not expunging such CIS converted investigations with automated batch. 
                 So, we are expunging these CIS Investigations with SSA approvals.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2153234'::character varying,
		null::date
 	) ;