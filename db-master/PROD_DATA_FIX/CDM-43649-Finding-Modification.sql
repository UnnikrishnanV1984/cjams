/*
 * CDM-43649 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2274080:Expunge case.
 * Attached is the agency's settlement notice regarding modifying this finding. 
 * 
 */

update tb_conv_inv_finding
set investigation_finding_cd='Ruled Out'
where referral_id='CW2274080' and inv_finding_id=250021;

