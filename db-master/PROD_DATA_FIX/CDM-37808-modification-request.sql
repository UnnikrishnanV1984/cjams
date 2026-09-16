/*
 * CDM-37808 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2221713:Please modify this physical abuse finding from Indicated to Unsubstantiated. 
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

SELECT * FROM tb_conv_inv_finding where referral_id='CW2221713';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=197654 and referral_id='CW2221713'; 