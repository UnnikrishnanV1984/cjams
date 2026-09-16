/*
   Issue Description: CDM-36302
   Category/ Module  :Investigation finding  
   Root cause: User wants to change investigation findings from Indicated to Ruled Out
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id= 'CW2217497';