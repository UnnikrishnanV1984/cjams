/*
-- Issue Description:
-- Category/ Module: Payments
-- Root cause:  user error, user requested to change the payment amount to 889.80 for client : BRAYDEN SMITH
--Fix provided: Data fix is done to update the payment amount.
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update gapagreementrate set paymentamout = '889.80', updatedby = 'CJAMS-67477', updatedon = now() 
where gapagreementrateid = '0cb7965c-2870-4072-83f6-bb5905033ed8';


update gapratesrevision set paymentamt = '889.80', approvaldate = now() , updatedby = 'CJAMS-67477', updatedon = now() 
where gaprateid = '0cb7965c-2870-4072-83f6-bb5905033ed8' and activeflag = 1;