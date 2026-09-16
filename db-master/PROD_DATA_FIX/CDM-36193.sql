/*
 * CDM-36193 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * modify the investigation findings for below CPS IR cases;
 * CW2276377 - modify this indicated neglect finding to unsubstantiated neglect.
 */

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where referral_id='CW2276377';
