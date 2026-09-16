/*
 * CJAMS-58783 - Expungement Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Root cause: User Expungement Request, The investigation did not automatically expunge from the system after the finding was modified to ruled out. 
 * Assistant Deputy Director, Stephanie Cooke has approved this modification request.
 */

 select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2229824'::character varying,
		null::date
	);