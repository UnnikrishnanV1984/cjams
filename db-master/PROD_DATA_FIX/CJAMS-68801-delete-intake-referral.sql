/*
   Issue Description: CJAMS-68801
   Category/ Module: Delete intake
   Root cause: user wants to delete intake referral as its duplicated
   Fix type: Data fix is done to delete the intakes as requested
   Is code fix required : N
   Reason why no related code fix: user error
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from CW_transactions_dataclenup('INTKE','I202100548368','CJAMS-68801');
