/*
   Issue Description: CDM-27974
   Category/ Module  : INVESTIGATION FINDING
   Root cause: user wants to update investigation finding 
   Pull request# for code fix:
   Reason why no related code fix: user error
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Ruled Out' where referral_id = 'CW2144772';