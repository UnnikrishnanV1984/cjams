/* 
    Issue Description: CDM-43157
   Category/ Module  : Finding Modification Request
   Root cause: :Please modify these indicated neglect findings to ruled out neglect. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled out'
where referral_id = 'CW2276886';