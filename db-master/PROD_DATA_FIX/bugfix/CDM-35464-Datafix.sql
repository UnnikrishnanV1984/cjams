/*
   Issue Description: CDM-35464
   Category/ Module  : Finding modification requests
   Root cause: Finding Modification Request
   Fix Provided: Modified this Indicated Physical Abuse finding to Unsubstantiated Physical Abuse.
*/
select * from tb_conv_inv_finding where referral_id = 'CW2279671';

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2279671';



