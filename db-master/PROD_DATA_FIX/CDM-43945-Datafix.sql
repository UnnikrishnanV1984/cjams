/* 
    Issue Description: CDM-43945
   Category/ Module  : Finding Modification Request
   Root cause: :modified these  indicated sexual abuse finding to ruled out sexual abuse.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=254025 and referral_id='CW2278084';