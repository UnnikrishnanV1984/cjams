/*
   Issue Description: CDM-36625
   Category/ Module  :  Investigation Findings
   Root cause:user requeseted to update investigation finding
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update tb_conv_inv_finding set  investigation_finding_cd = 'Ruled Out' where referral_id='CW2251626';
