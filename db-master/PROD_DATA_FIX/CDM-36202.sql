/*
 * CDM-36202 - Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * modify the Finding from "Physical Abuse Indicated" to "Physical Abuse Ruled Out" and expunge the CPS IR # CW2293999.
 */

select * from tb_conv_inv_finding where referral_id ='CW2293999';

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2293999';
