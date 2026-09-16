/*
   Issue Description: Case needs to be deleted from worker's dashboard
   Category/ Module  : Delete intakes
   Root cause: user wants to delete  intake as they have created it long ago and worker forgot to submit for approval
   Fix type: Data fix is done to delete the intakes as requested
   Is code fix required : N
   Reason why no related code fix: user error
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from CW_transactions_dataclenup('INTKE','I261014019071','CJAMS-69462');