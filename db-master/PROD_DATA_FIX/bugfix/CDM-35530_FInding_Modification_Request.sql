/*
 Issue Description: Investigation finding
 Category/ Module: update investigation finding from indicated to unsubstantiated
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */
update
    tb_conv_inv_finding
set
    investigation_finding_cd = 'Unsubstantiated'
where
    referral_id = 'CW2250874';