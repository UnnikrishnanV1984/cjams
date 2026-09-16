/*
   Issue Description: CDM-32271
   Category/ Module  :Investigation finfing  
   Root cause: User wants to change investigation findings from Indicated to Unsubstantiated
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update tb_conv_inv_finding set investigation_finding_cd = 'Unsubstantiated' where inv_finding_id ='245182';