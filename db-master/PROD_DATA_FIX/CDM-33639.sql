/*
 * CDM-33639 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2239658:Please modify this physical abuse finding from Indicated to Unsubstantiated. 
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

SELECT * FROM tb_conv_inv_finding where referral_id='CW2239658';

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated' 
where inv_finding_id=215599 and referral_id='CW2239658'; 