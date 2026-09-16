/*
   Issue Description: Referral
   Category/ Module  : Delete intakes
   Root cause: user wants to delete  intakes  referral as they are created in error by user
   Fix type: Data fix is done to delete the intakes as requested
   Is code fix required : N
   Reason why no related code fix: user error
   Regression impacts: NA

*/

select * from CW_transactions_dataclenup('INTKE','I251013374808','CJAMS-69852');
 
select * from CW_transactions_dataclenup('INTKE','I251013463705','CJAMS-69852');
