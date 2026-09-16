/*
 * CDM-34801 - Finding Modification Request
 * Customer Email ID:lori.engle@maryland.gov
 * Customer Name:lori engle
 * Focus Area:Decision
 * Description - CW2017303:Please modify this physical abuse finding from Indicated to Unsubstantiated. 
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Unsubstantiated'
where inv_finding_id=25684 and referral_id='CW2017303';