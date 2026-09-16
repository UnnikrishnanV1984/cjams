/*
   Issue Description: CDM-42944
   Category/ Module  : Finding modification 
   Root cause:  modify this indicated neglect finding to ruled out neglect. The department does not have the closed record for the investigation. 
   Assistant Deputy Director, Stephanie Cooke has approved this request.
   Fix Provided: Updated investigation finding to Ruled out
*/
/*
select * from tb_conv_inv_finding where referral_id ='CW2216528';
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2216528';