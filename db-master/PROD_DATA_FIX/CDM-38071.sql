/*
 * CDM-38071 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Focus Area:SDM
 * Description - CW2250984:Please modify this indicated neglect finding to ruled out neglect. 
 * Documentation supporting this request has been attached to this request and uploaded to the Document tab. 
 * 
 */

SELECT * FROM tb_conv_inv_finding where referral_id='CW2250984';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=226925 and referral_id='CW2250984'; 
