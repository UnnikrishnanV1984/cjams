/*
   Issue Description: CDM-35380
   Category/ Module  : Finding modification requests
   Root cause: Finding Modification Request
   Fix Provided: Updated the investigation_finding to Unsubstantiated
*/

select * from tb_conv_inv_finding where referral_id = 'CW2219149';

update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2219149';



