/*
-- Issue Description: 
:Please expunge this investigation from CJAMS. The department does not have the closed record for the investigation. The individual is attempting to seek employment. Refer to Intake # I251013346473 for additional information.
-- Fix provided: Datafix has been updated to expunge the  case # CW2238665  .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2238665'::character varying,
		null::date
 	) ;