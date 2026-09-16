/*
-- Issue Description: Please remove CIS # 469015997 program assignment from CJAMS investigation # CW227500 and CW227507. The Department does not have the closed record for the investigation.  
-- Root cause: Change requested by user.
-- Fix Provided: Called expungcaserequest store proc.
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2227500'::character varying,
		null::date
	) ;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2227507'::character varying,
		null::date
	) ;