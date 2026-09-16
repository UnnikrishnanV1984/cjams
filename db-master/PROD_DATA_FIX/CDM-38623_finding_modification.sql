/*
-- Issue Description: Please modify this indicated neglect finding to ruled out. Assistant Deputy Director, Stephanie Cooke has approved this request.
-- Category/ Module: Intake Referral (Intake Management)
-- Root cause: Data entry error.
-- Fix Provided: Updated the appropriate columns inside a tb_con_inv_finding to Ruled Out.
*/


update tb_conv_inv_finding
set investigation_finding_cd = 'Ruled Out'
where referral_id = 'CW2281650';