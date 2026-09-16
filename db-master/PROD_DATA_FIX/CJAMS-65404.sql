/*
-- Issue Description:
-- Category/ Module: Payments
-- Root cause:  user error, user requested to change the payment amount from $882 to $852 for Provider ID: 5083649 (Kevin Glace)
   Subsidy Rate Slab Start & End Date: 03/01/2025 - 02/28/2026  
--Fix provided: Data fix is done to update the payment amount.
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update gapagreementrate set paymentamout = '852', updatedby = 'CJAMS-65404', updatedon = now() 
where gapagreementrateid = 'a0304335-4d2e-424c-ba40-c2ca982dd1e6';


update gapratesrevision set paymentamt = '852', approvaldate = now() , updatedby = 'CJAMS-65404', updatedon = now() 
where gaprateid = 'a0304335-4d2e-424c-ba40-c2ca982dd1e6' and activeflag = 1;