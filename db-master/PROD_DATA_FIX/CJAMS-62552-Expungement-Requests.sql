/*
-- Issue Description: 
Please expunge this investigation. The department does not have the closed record for the investigation. The individual is seeking employment. Refer to intake # I251013345872 for additional information. Assistant Deputy Director, Stephanie Cooke approved this request.
-- Fix provided: Datafix has been updated to expunge the  case # CW2239530  .
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2239530'::character varying,
		null::date
 	) ;