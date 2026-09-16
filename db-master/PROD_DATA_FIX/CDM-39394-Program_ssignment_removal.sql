/*
 * CDM-39394 - Program Assignment Removal Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - Please remove CIS # 430014292 program assignment from CJAMS investigation # CW2285597. The Department does not have
  the closed record for this investigation. Assistant Deputy Director, Stephanie Cooke has approved this request.
 */


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2285597'::character varying,
		null::date
 	) ;