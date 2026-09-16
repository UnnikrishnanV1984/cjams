/*
   Issue Description: Cjams-64766
   Category/ Module  : Delete intake
   Root cause: user wants to delete intake as its a duplicate 
   Pull request# for code fix: 7258
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select * from CW_transactions_dataclenup('INTKE','I261013657200','CJAMS-64766');

