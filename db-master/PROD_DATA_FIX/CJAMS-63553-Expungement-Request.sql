/*
-- to expunge the CPS IR # CW2234394.
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--			   CJAMS is not expunging such converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2234394'::character varying,
		null::date
	) ;