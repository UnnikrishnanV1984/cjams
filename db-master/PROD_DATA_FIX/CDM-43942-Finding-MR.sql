/*
 * CDM-43942 - Finding Modification Request : CW2160538:Please modify this indicated Physical Abuse finding to ruled out Physical Abuse. The Department does not have the closed record for the investigation.
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2215758:Please modify this indicated physical abuse finding to ruled out physical abuse. 
 * Documentation supporting this request has been attached to this ticket and uploaded in the document tab. 
 * Already expungement happened with CJAMS-58781 ticket.
 */

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2160538';

-- select vl_sqlcode, vs_err_message
-- from cjams.expungcaserequest
-- 	(	'IR'::character varying,
-- 		'CW2234140'::character varying,
-- 		null::date
-- 	) ;