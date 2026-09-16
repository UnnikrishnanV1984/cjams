/* 
    Issue Description: CDM-43940
   Category/ Module  : Finding Modification Request
   Root cause: :modified these  indicated physical abuse finding to ruled out physical abuse.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


UPDATE cjams.tb_conv_inv_finding
SET investigation_finding_cd='Ruled Out' 
where inv_finding_id=249844 and referral_id='CW2273903';