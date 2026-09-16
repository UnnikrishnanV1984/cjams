/*
-- Issue Description:
-- Category/ Module: Payments
-- Root cause:  user error, user requested to change the payment amount to  $889.80  for JOURNEY Elizabeth WASHINGTON (CJAMS PID# 4065288)
--Fix provided: Data fix is done to update the payment amount.
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update gapagreementrate set paymentamout = '889.80', updatedby = 'CJAMS-68302', updatedon = now() 
where gapagreementrateid = '509de3b7-9231-408d-b07d-662f6292d323';


update gapratesrevision set paymentamt = '889.80', approvaldate = now() , updatedby = 'CJAMS-68302', updatedon = now() 
where gaprateid = '509de3b7-9231-408d-b07d-662f6292d323' and activeflag = 1;