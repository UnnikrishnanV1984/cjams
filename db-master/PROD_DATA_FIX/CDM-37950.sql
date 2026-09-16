/*
 * CDM-37950 - Removal of case
 * Customer Email ID:christy.lewis@maryland.gov
 * Focus Area:Case Timeline
 * Description - CW2050646:Jurisdiction has reviewed the CJAMS record. 
 * Finding should be removed. Record would have been destroyed according to Recordkeeping. 
 * expunge the CPS IR # CW2050646.
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2050646'::character varying,
		null::date
	);