/*
   Issue Description: Worker created multiple intake referrals for CPS history clearance for camp portal and the applications were not processed and need to be removed. 
   Category/ Module  : Delete intakes
   Root cause: user wants to delete  intakes  referral as its no longer needed as user has already created another intake through which service case is created
   Fix type: Data fix is done to delete the intakes as requested
   Is code fix required : N
   Reason why no related code fix: user error
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from CW_transactions_dataclenup('INTKE','I261014137854','CJAMS-69485');