/*
 * CDM-36657 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Description - CW2219729:Please modify this indicated neglect finding to ruled out neglect. 
 * Assistant Deputy Director, Stephanie Cooke has reviewed this case and approved the modification request.
 * 
 */

select * from tb_conv_inv_finding where referral_id ='CW2219729';

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2219729';
