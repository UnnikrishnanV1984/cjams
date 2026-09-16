/*
-- Issue Description: 
I am doing a clearance for Asmaa El Bachiri who works for a daycare. In the CW2946596 case from 2019 she was ruled out for neglect, as well as another provider. I do not see why this case would still be on the system, as it is well past the 2 yr retention, so I believe it should be expunged.-- Root cause: User requested to expunge the case.
-- Fix provided: Datafix has been updated to expunge the  case # CW2946596  .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2946596'::character varying,
		null::date
 	) ;