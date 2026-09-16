/*
 * CDM-43939 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2229824:Please modify this indicated physical abuse finding to ruled out physical abuse. The department does not have the closed record for the investigation
 * 
 */
--SELECT * FROM tb_conv_inv_finding where referral_id='CW2229824';
UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=205765 and referral_id='CW2229824'; 
