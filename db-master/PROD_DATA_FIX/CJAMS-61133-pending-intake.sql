/*
   Issue Description: CJAMS-61133
   Category/ Module  :  remove intake
   Root cause: user asked to remove intake as new intake and case already created.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select * from CW_transactions_dataclenup('INTKE','I251013331861','CJAMS-61133');
