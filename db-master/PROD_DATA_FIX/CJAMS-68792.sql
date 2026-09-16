/*
-- Issue Description:CJAMS-68792-Change in already approved information
-- Category/ Module: Payments
-- Root cause:  user error, user requested to change the payment amount to $874 for Client ID:  204110445 (Kash Smith),Client ID: 203198278 (Kian Barrington)
--Fix provided: Data fix is done to update the payment amount.
--Is code fix required: No
-- Pull request :
-- Reason why no related code fix: User error
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update gapagreementrate set paymentamout = '874', updatedby = 'CJAMS-68792', updatedon = now() 
where gapagreementrateid in ('8e27f5fa-b6ba-4c95-af03-621f00cc6372','f432c05c-6061-435b-87ae-7e83584c2113');


update gapratesrevision set paymentamt = '874', approvaldate = now() , updatedby = 'CJAMS-68792', updatedon = now() 
where gaprateid in ('8e27f5fa-b6ba-4c95-af03-621f00cc6372','f432c05c-6061-435b-87ae-7e83584c2113') and activeflag = 1;