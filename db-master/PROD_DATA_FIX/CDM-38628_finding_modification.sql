/*
-- Issue Description: Please modify this indicated neglect finding to unsubstantiated neglect. Documentation supporting this request has been attached to this ticket and uploaded in the document tab.
-- Category/ Module: Intake Referral (Intake Management)
-- Root cause: Change requested by user.
-- Fix Provided: Updated the appropriate columns inside a tb_con_inv_finding to Ruled Out.
*/


update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where referral_id = 'CW2275972';