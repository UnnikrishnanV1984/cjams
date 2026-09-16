/*
 * CDM-38082 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2250985:Please modify this indicated neglect finding to ruled out neglect. 
 * Documentation supporting this request has been attached with this ticket and uploaded in the Document tab. 
 * 
 */

-- SELECT * FROM tb_conv_inv_finding where referral_id='CW2250985';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=226926 and referral_id='CW2250985'; 
