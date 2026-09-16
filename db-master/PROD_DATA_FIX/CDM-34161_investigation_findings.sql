/*
 * CDM-34161 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2275971:Please modify this physical abuse finding from Indicated to Ruled Out. 
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out'
where inv_finding_id=251912 and referral_id='CW2275971';
