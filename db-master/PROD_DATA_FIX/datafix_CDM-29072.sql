/*
 * CDM-29072 - Case removal
 * Customer Email ID:jeanne.baxter@maryland.gov
 * Customer Name:Jeanne Baxter
 * CW2143802:This record from 1990 was previously destroyed and is no longer on file. Therefore, this reference to the case should be removed from CJAMS. 
 * It is in two places, one with the correct DOB and the other with 00/00/00. 
 * Expunge case # CW2143802
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2143802'::character varying,
		null::date
	);