/*
 * CDM-36980 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2213804:Please modify this indicated neglect finding to unsubstantiated neglect.
 */

SELECT * FROM tb_conv_inv_finding where referral_id='CW2213804';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=189745 and referral_id='CW2213804'; 