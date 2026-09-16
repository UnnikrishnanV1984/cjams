/*
 * CDM-39663 - need expungement/ appeals rights
 * Customer Email ID:elizabeth.long@maryland.gov
 * Description - CW2097743:Need appeals rights to old case where there is no longer any record to be accessed; 
 * must be expunged to complete clearance.
 * expunge the case# CW2097743.
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2097743'::character varying,
		null::date
	);