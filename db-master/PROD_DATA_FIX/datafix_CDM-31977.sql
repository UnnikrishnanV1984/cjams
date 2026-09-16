/*
 * CDM-31977 - removing an expunged case
 * Customer Email ID:jeanne.baxter@maryland.gov
 * Customer Name:Jeanne Baxter
 * Dashboard:David Boyd's only CPS case was from 2001 and after reviewing the record, it was determined by Deputy Director, Susan Tyzack, 
 * that this would now be expunged. It is not a finding the Dept would indicate, as it would be an alternative response case by today's standards. 
 * The subject has been cleared and entered under Intake, but this record should be removed from CJAMS. Thank you
 * CASE NUMBER - CW2186801
 * 
 */

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2186801'::character varying,
		null::date
	);