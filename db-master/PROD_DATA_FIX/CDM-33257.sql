/*
   Issue Description: CDM-33257
   Category/ Module  :  
   Root cause:user requeseted to update investigation finding
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update tb_conv_inv_finding set  investigation_finding_cd = 'Ruled Out' where referral_id='CW2242691';
