/*
 * CDM-38078 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2215758:Please modify this indicated physical abuse finding to ruled out physical abuse. 
 * Documentation supporting this request has been attached to this ticket and uploaded in the document tab. 
 * 
 */

-- SELECT * FROM tb_conv_inv_finding where referral_id='CW2215758';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=191699 and referral_id='CW2215758'; 
