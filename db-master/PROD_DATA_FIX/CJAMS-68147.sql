/*
   Issue Description: CJAMS-68147
   Category/ Module  : Delete intake
   Root cause: user wants to delete intakes as its no longer needed
   Fix type: Data fix is done to delete the intakes as requested
   Is code fix required : N
   Reason why no related code fix: user error
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from CW_transactions_dataclenup('INTKE','I261014091153','CJAMS-68147');

select * from CW_transactions_dataclenup('INTKE','I261013890086','CJAMS-68147');