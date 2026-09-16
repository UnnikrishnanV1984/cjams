/*
-- Issue Description:
-- Category/ Module: Payments
-- Root cause:  user error, user requested to change the payment amount to $874.80 for JESSA WASHINGTON (CJAMS PID # 4179060)
--Fix provided: Data fix is done to update the payment amount.
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update gapagreementrate set paymentamout = '874.80', updatedby = 'CJAMS-68301', updatedon = now() 
where gapagreementrateid = '7f64591e-e340-4e37-ae22-c85f3f1b3c17';


update gapratesrevision set paymentamt = '874.80', approvaldate = now() , updatedby = 'CJAMS-68301', updatedon = now() 
where gaprateid = '7f64591e-e340-4e37-ae22-c85f3f1b3c17' and activeflag = 1;