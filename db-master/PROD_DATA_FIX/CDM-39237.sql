/*
 * CDM-39237 - Expungement
 * Customer Email ID:joann.gochnour@maryland.gov
 * Focus Area:Case Timeline
 * Description: CW2185293:This 1988 record can not be located. They is no information regarding the content. Client is 
 * seeking employment and this is an issue. This case needs to be Expunged, Jane Gehring AD
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2185293'::character varying,
		null::date
	);
    