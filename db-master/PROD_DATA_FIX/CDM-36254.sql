/*
 * CDM-36254 - Finding Modification Request
 * Customer Email ID:andrea.clark@maryland.gov
 * Customer Name:Andrea Clark
 * Focus Area:Decision
 * Description - CW2251358:Please modify this indicated neglect finding to ruled out neglect. 
 * The closed record has been reviewed and the department is modifying the finding to ruled out. 
 * Assistant Deputy Director, Stephanie Cooke has approved this modification request.
 * modify the findings from Neglect Indicated to Neglect Ruled Out for CPS IR # CW2251358.
 * 
 */

select * from tb_conv_inv_finding where referral_id ='CW2251358';

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2251358';
