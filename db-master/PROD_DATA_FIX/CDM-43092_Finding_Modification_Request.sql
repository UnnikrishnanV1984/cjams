/*
   Issue Description: CDM-43092
   Category/ Module  : Finding modification 
   Root cause: modify this Indicated Physical Abuse finding to Ruled Out Physical Abuse.
   Fix Provided: Updated investigation finding to Ruled out
*/
/*
select * from tb_conv_inv_finding where referral_id ='CW2245518';
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2245518';
